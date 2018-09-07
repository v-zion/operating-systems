#include "types.h"
#include "stat.h"
#include "user.h"
char b[1024];

#define KERNBASE 0x80000000
#define PGSIZE 4096

int getpusz()
{
	uint pa;
	int size = 0;
	int flag;
	for (uint i = 0; i < KERNBASE; i += PGSIZE)
		if (get_va_to_pa(i, &pa, &flag))
			size += PGSIZE;
	return size;
}

// answer is to match the sample output
int getpksz()
{
	uint pa;
	int size = 0;
	int flag;
	for(uint i = KERNBASE; i <= 0xFFFFF000; i += PGSIZE) {
		if(get_va_to_pa(i, &pa, &flag))
			size += PGSIZE;
		if (i == 0xFFFFF000)
			break;
	}
	return size;
}

int
main(int argc, char *argv[])
{
	char *buf;

	printf(1, "\ngetpsz: %d bytes \n", getpsz());
	printf(1,"getpusz: %d bytes \n",getpusz());
	printf(1,"getpksz: %d bytes\n",getpksz());


	buf=sbrk(4096);
	buf[0]='\0';
	printf(1, "\ngetpsz: %d bytes \n", getpsz());
	printf(1,"getpusz: %d bytes \n",getpusz());
	printf(1,"getpksz: %d bytes\n",getpksz());

	
	buf=sbrk(4096*7);
	printf(1, "\ngetpsz: %d bytes \n", getpsz());
	printf(1,"getpusz: %d bytes \n",getpusz());
	printf(1,"getpksz: %d bytes\n",getpksz());

	buf=sbrk(1);
	printf(1, "\ngetpsz: %d bytes \n", getpsz());
	printf(1,"getpusz: %d bytes \n",getpusz());
	printf(1,"getpksz: %d bytes\n",getpksz());

	buf=sbrk(2);
	printf(1, "\ngetpsz: %d bytes \n", getpsz());
	printf(1,"getpusz: %d bytes \n",getpusz());
	printf(1,"getpksz: %d bytes\n",getpksz());


	exit();
}