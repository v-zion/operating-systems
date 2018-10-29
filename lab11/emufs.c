#include "emufs.h"

/**************************** File system helper functions ****************************/

//	Function to encrypt a block of data 
int encrypt(char* input, char* encrypted)
{
	for(int i=0; i<BLOCKSIZE; i++)
	{
		encrypted[i] = ~input[i];
	}
}

//	Function to decrypt a block of data 
int decrypt(char* input, char* decrypted)
{
	for(int i=0; i<BLOCKSIZE; i++)
	{
		decrypted[i] = ~input[i];
	}
}

//	The following helper functions are used to read and write 
//	superblock and metadata block. 
//	Change the function definitions with required arguments
struct superblock_t* readSuperblock(struct mount_t* mount)
{
	/*
		* Read 0th block from the device into a blocksize buffer
		* Create superblock_t variable and fill it using reader buffer
		* Return the superblock_t variable
	*/
	int dev_fd = mount->device_fd;
	char* buffer = calloc(BLOCKSIZE, sizeof(char));
	if (readblock(dev_fd, 0, buffer) == -1)
		printf("Error: Could not read from the superblock\n");
	struct superblock_t* spblock = malloc(sizeof(struct superblock_t));
	memcpy(spblock, buffer, sizeof(struct superblock_t));
	return spblock;
}

int writeSuperblock(struct superblock_t* spblock, struct mount_t* mount)
{
	/*
		* Read the 0th block from device into a buffer
		* Write the superblock into the buffer
		* Write back the buffer into block 0
	*/
	int dev_fd = mount->device_fd;
	char* buffer = calloc(BLOCKSIZE, sizeof(char));
	memcpy(buffer, spblock, sizeof(struct superblock_t));
	if (writeblock(dev_fd, 0, buffer) == -1){
		printf("Error: Could not write into the superblock\n");
		return -1;
	}
	return 1;
}

struct metadata_t* readMetadata(struct mount_t* mount)
{
	// Same as readSuperBlock(), but it is stored on block 1
	// Need to decrypt if emufs-encrypted is used
	int dev_fd = mount->device_fd;
	char* sp_buffer = calloc(BLOCKSIZE, sizeof(char));
	if (readblock(dev_fd, 0, sp_buffer) == -1) {
		printf("Error (readMetadata): Could not read superblock\n");
		return NULL;
	}
	struct superblock_t* spblock = malloc(sizeof(struct superblock_t));
	memcpy(spblock, sp_buffer, sizeof(struct superblock_t));
	int fs_number = spblock->fs_number;

	char* buffer = calloc(BLOCKSIZE, sizeof(char));
	if (readblock(dev_fd, 1, buffer) == -1)
		printf("Error: Could not read from the metadata block\n");
	if(fs_number)
		decrypt(buffer, buffer);
	
	struct metadata_t* meta = malloc(sizeof(struct metadata_t));
	memcpy(meta, buffer, sizeof(struct metadata_t));
	return meta;
}

int writeMetadata(struct metadata_t* meta, struct mount_t* mount)
{
	// Same as writeSuperblock(), but it is stored on block 1
	// Need to decrypt/encrypt if emufs-encrypted is used  
	int dev_fd = mount->device_fd;
	char* sp_buffer = calloc(BLOCKSIZE, sizeof(char));
	if (readblock(dev_fd, 0, sp_buffer) == -1) {
		printf("Error (readMetadata): Could not read superblock\n");
		return -1;
	}
	struct superblock_t* spblock = malloc(sizeof(struct superblock_t));
	memcpy(spblock, sp_buffer, sizeof(struct superblock_t));
	int fs_number = spblock->fs_number;	

	char* buffer = calloc(BLOCKSIZE, sizeof(char));
	memcpy(buffer, meta, sizeof(struct metadata_t));
	if(fs_number)
		encrypt(buffer, buffer);

	if (writeblock(dev_fd, 1, buffer) == -1){
		printf("Error: Could not write into the metadata block\n");
		return -1;
	}
	return 1;
}

/**************************** File system API ****************************/

int create_file_system(struct mount_t *mount_point, int fs_number)
{
	/*
	   	* Read the superblock.
	    * Set file system number on superblock
		* Clear the bitmaps.  values on the bitmap will be either '0', or '1', or'x'. 
		* Create metadata block in disk
		* Write superblock and metadata block back to disk.

		* Return value: -1,		error
						 1, 	success
	*/
	struct superblock_t* spblock = readSuperblock(mount_point);
	
	mount_point->fs_number = fs_number;
	strcpy(mount_point->device_name, spblock->device_name);

	spblock->fs_number = fs_number;
	spblock->bitmap[0] = '1';
	spblock->bitmap[1] = '1';
	for (int i = 2; i < MAX_BLOCKS; i++) {
		if (i <= spblock->disk_size)
			spblock->bitmap[i] = '0';
		else
			spblock->bitmap[i] = 'x';
	}
	if (writeSuperblock(spblock, mount_point) == -1) {
		printf("Error (create): Writing to superblock failed\n");
		return -1;
	}
	struct metadata_t* meta = malloc(sizeof(struct metadata_t));
	if (writeMetadata(meta, mount_point) == -1) {
		printf("Error (create): Writing to metadata block failed\n");
		return -1;
	}
	printf("[%s] File system created. \n", spblock->device_name);
	return 1;
}


struct file_t* eopen(struct mount_t* mount_point, char* filename)
{
	/* 
		* If file exist, get the inode number. inode number is the index of inode in the metadata.
		* If file does not exist, 
			* find free inode.
			* allocate the free inode as USED
			* if free id not found, print the error and return -1
		* Create the file hander (struct file_t)
		* Initialize offset in the file hander
		* Return file handler.

		* Return NULL on error.
	*/
	struct metadata_t* meta = readMetadata(mount_point);
	struct file_t* file = malloc(sizeof(struct file_t));
	int inode_number = -1;
	for (int i = 0; i < MAX_FILES; i++) {
		if (meta->inodes[i].status == 1 && !strcmp(filename, meta->inodes[i].name)) {
			inode_number = i;
			break;
		}
	}
	if (inode_number == -1) {
		for (int i = 0; i < MAX_FILES; i++) {
			if (meta->inodes[i].status == 0) {
				inode_number = i;
				break;
			}
		}
		if (inode_number == -1) {
			printf("Error: No space available\n");
			return NULL;
		}
		struct inode_t* inode = &meta->inodes[inode_number];
		inode->status = 1;
		strcpy(inode->name, filename);
		inode->file_size = 0;
		for (int i = 0; i < 4; i++)
			inode->blocks[i] = -1;
		time(&inode->modtime);
	}
	file->offset = 0;
	file->inode_number = inode_number;
	file->mount_point = mount_point;
	if (writeMetadata(meta, mount_point) == -1)
		return NULL;
	printf("File '%s' Opened \n", meta->inodes[inode_number].name);
	return file;
	// return NULL;
}

int ewrite(struct file_t* file, char* data, int size)
{
	// You do not need to implement partial writes in case file exceeds 4 blocks
	// or no free block is available in the disk. 

	// Return value: 	-1,  error
	//					Number of bytes written
	struct superblock_t * spblock = readSuperblock(file->mount_point);
	struct metadata_t * meta = readMetadata(file->mount_point);
	int start = file->offset/BLOCKSIZE;
	int num_blocks = size/BLOCKSIZE;
	if (start + num_blocks > 4) {
		printf("Error (ewrite): Maximum file size exceeded\n");
		return -1;
	}
	int num_bytes = 0;
	while (num_bytes < size) {
		int block_num = meta->inodes[file->inode_number].blocks[file->offset/BLOCKSIZE];
		if (block_num == -1) {
			for (int j = 2; j < BLOCKSIZE; j++){
				if (spblock->bitmap[j] !='1'){
					spblock->bitmap[j] = '1';
					block_num = j;
					meta->inodes[file->inode_number].blocks[file->offset/BLOCKSIZE] = j;
					meta->inodes[file->inode_number].file_size += BLOCKSIZE;
					time(&(meta->inodes[file->inode_number].modtime));
					if (writeSuperblock(spblock, file->mount_point) == -1) {
						printf("Error (ewrite): Writing to superblock failed\n");
						return -1;
					}
					if (writeMetadata(meta, file->mount_point) == -1) {
						printf("Error (ewrite): Writing to metadata block failed\n");
						return -1;
					}
					break;
				}
			}
		}
		if (writeblock(file->mount_point->device_fd , block_num, data + num_bytes) == -1) {
			printf("Error (ewrite): Cannot write file %s\n", meta->inodes[file->inode_number].name);
			return -1;
		}
		num_bytes += BLOCKSIZE;
		file->offset += BLOCKSIZE;
	}
	return num_bytes;
}

int eread(struct file_t* file, char* data, int size)
{
	// NO partial READS.

	// Return value: 	-1,  error
	//					Number of bytes read
	char* buffer = calloc(size, sizeof(char));
	struct metadata_t* meta = readMetadata(file->mount_point);

	if(file->offset + size > meta->inodes[file->inode_number].file_size) {
		printf("Error (eread): Invalid offset\n");
		return -1;
	}

	struct inode_t* inode = &meta->inodes[file->inode_number];
	int start = file->offset/BLOCKSIZE;
	int num_blocks = size/BLOCKSIZE;
	
	for (int i = start; i < start + num_blocks; i++) {
		int block_num = inode->blocks[i];
		if(readblock(file->mount_point->device_fd, block_num, &buffer[(i - start)*BLOCKSIZE]) == -1) {
			printf("Error (eread): Cannot read file %s\n", inode->name);
			return -1;
		}
	}
	eseek(file, file->offset + size);
	strcpy(data, buffer);
	if (writeMetadata(meta, file->mount_point) == -1) {
		printf("Error (eread): Writing to metadata block failed\n");
		return -1;
	}
	return size;
	// return 1;
}

void eclose(struct file_t* file)
{
	// free the memory allocated for the file handler 'file'
	free(file);
	printf("File Closed\n");
}

int eseek(struct file_t *file, int offset)
{
	file->offset = offset;
	return 1;
}

void fsdump(struct mount_t* mount_point)
{

	printf("\n[%s] fsdump \n", mount_point->device_name);
	printf("%-10s %6s \t[%s] \t%s\n", "  NAME", "SIZE", "BLOCKS", "LAST MODIFIED");
	
	struct metadata_t* meta = readMetadata(mount_point);
	for (int i = 0; i < MAX_FILES; i++) {
		if (meta->inodes[i].status)
			printf("%-10s %6d \t[%d %d %d %d] \t%s", 
				meta->inodes[i].name,
				meta->inodes[i].file_size,
				meta->inodes[i].blocks[0],
				meta->inodes[i].blocks[1],
				meta->inodes[i].blocks[2],
				meta->inodes[i].blocks[3],
				asctime(localtime(&(meta->inodes[i].modtime))));
	}
}
