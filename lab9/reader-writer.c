#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>

struct read_write_lock
{
	// If required, use this strucure to create
	// reader-writer lock related variables
	pthread_mutex_t mutexLock;
	pthread_cond_t read;
	pthread_cond_t write;
	int num_rQ;
	int num_wQ;
	bool reading;
	bool writing;
}rwlock;

struct argument_t
{
	long int threadNum;
	int delay;
};

long int data = 0;			//	Shared data variable

void InitalizeReadWriteLock(struct read_write_lock * rw)
{
	pthread_mutex_init(&rw->mutexLock, NULL);
	pthread_cond_init(&rw->read, NULL);
	pthread_cond_init(&rw->write, NULL);
	rw->num_rQ = 0;
	rw->num_wQ = 0;
	rw->reading = false;
	rw->writing = false;
}

// The pthread based reader lock
void ReaderLock(struct read_write_lock * rw)
{
	pthread_mutex_lock(&rw->mutexLock);
	rw->num_rQ++;
	while (rw->writing || rw->num_wQ)
		pthread_cond_wait(&rw->read, &rw->mutexLock);
	rw->reading = true;
	rw->num_rQ--;
	pthread_mutex_unlock(&rw->mutexLock);
}

// The pthread based reader unlock
void ReaderUnlock(struct read_write_lock * rw)
{
	pthread_mutex_lock(&rw->mutexLock);
	
	rw->reading = false;
	if (rw->num_wQ)
		pthread_cond_signal(&rw->write);
	else
		pthread_cond_signal(&rw->read);
	pthread_mutex_unlock(&rw->mutexLock);
}

// The pthread based writer lock
void WriterLock(struct read_write_lock * rw)
{
	pthread_mutex_lock(&rw->mutexLock);
	rw->num_wQ++;
	while (rw->writing || rw->reading)
		pthread_cond_wait(&rw->write, &rw->mutexLock);
	rw->writing = true;
	rw->num_wQ--;
	pthread_mutex_unlock(&rw->mutexLock);	
}

// The pthread based writer unlock
void WriterUnlock(struct read_write_lock * rw)
{
	pthread_mutex_lock(&rw->mutexLock);
	rw->writing = false;
	if (rw->num_wQ)
		pthread_cond_signal(&rw->write);
	else
		pthread_cond_signal(&rw->read);
	pthread_mutex_unlock(&rw->mutexLock);
}

//	Call this function to delay the execution by 'delay' ms
void delay(int delay)
{
	struct timespec wait;

	if(delay <= 0)
		return;

	wait.tv_sec = delay / 1000;
	wait.tv_nsec = (delay % 1000) * 1000 * 1000;
	nanosleep(&wait, NULL);
}

// The pthread reader start function
void *ReaderFunction(void *args)
{
	struct argument_t *arg = (struct argument_t *) args;
	//	Delay the execution by arrival time specified in the input
	delay(arg->delay);
	//  Get appropriate lock
	ReaderLock(&rwlock);
	//	Display  thread ID and value of the shared data variable
	printf("\tReader\t%ld, data: %ld\n", arg->threadNum, data);
	//  Add a dummy delay of 1 ms before lock release
	usleep(1000);
	// Release lock
	ReaderUnlock(&rwlock);
	// free(arg);
}

// The pthread writer start function
void *WriterFunction(void *args)
{
	struct argument_t *arg = (struct argument_t *) args;
	//	Delay the execution by arrival time specified in the input
	delay(arg->delay);
	//  Get appropriate lock
	WriterLock(&rwlock);
	//	Increment the shared data variable
	data++;
	//	Display  thread ID and value of the shared data variable
	printf("Writer\t%ld, data: %ld\n", arg->threadNum, data);
	//  Add a dummy delay of 1 ms before lock release
	usleep(1000);
	// Release lock
	WriterUnlock(&rwlock);
	// free(arg);
}

int main(int argc, char *argv[])
{
	pthread_t *threads;
	struct argument_t *arg;
	
	long int reader_number = 0;
	long int writer_number = 0;
	long int thread_number = 0;
	long int total_threads = 0;	
	
	int count = 0;			// Number of 3 tuples in the inputs.	Assume maximum 10 tuples 
	int rws[10];			
	int nthread[10];
	int delay[10];

	//	Verifying number of arguments
	if(argc<4 || (argc-1)%3!=0)
	{
		printf("reader-writer <r/w> <no-of-threads> <thread-arrival-delay in ms> ...\n");		
		printf("Any number of readers/writers can be added with repetitions of above mentioned 3 tuple \n");
		exit(1);
	}

	//	Reading inputs
	for(int i=0; i<(argc-1)/3; i++)
	{
		char rw[2];
		strcpy(rw, argv[(i*3)+1]);

		if(strcmp(rw, "r") == 0 || strcmp(rw, "w") == 0)
		{
			if(strcmp(rw, "r") == 0)
				rws[i] = 1;					// rws[i] = 1, for reader
			else
				rws[i] = 2;					// rws[i] = 2, for writer
			
			nthread[i] = atol(argv[(i*3)+2]);		
			delay[i] = atol(argv[(i*3)+3]);

			count ++;						//	Number of tuples
			total_threads += nthread[i];	//	Total number of threads
		}
		else
		{
			printf("reader-writer <r/w> <no-of-threads> <thread-arrival-delay in ms> ...\n");
			printf("Any number of readers/writers can be added with repetitions of above mentioned 3 tuple \n");
			exit(1);
		}
	}

	//	Create reader/writer threads based on the input and read and write.
	threads = (pthread_t *) malloc(sizeof(pthread_t)*total_threads);
	arg = (struct argument_t *) malloc(sizeof(struct argument_t)*total_threads);

	InitalizeReadWriteLock(&rwlock);

	for (int i = 0; i < count; i++) {

		for (long int j = 0; j < nthread[i]; j++) {
			arg[thread_number].delay = delay[i];

			if (rws[i] == 1) {
				arg[thread_number].threadNum = reader_number + 1;
				pthread_create(&threads[thread_number], NULL, ReaderFunction, (void *) &arg[thread_number]);
				reader_number++;
			}
			else if (rws[i] == 2) {
				arg[thread_number].threadNum = writer_number + 1;
				pthread_create(&threads[thread_number], NULL, WriterFunction, (void *) &arg[thread_number]);
				writer_number++;
			}
			thread_number = reader_number + writer_number;
		}
	}

	//  Clean up threads on exit
	for (int i = 0; i < total_threads; i++)
		pthread_join(threads[i], NULL);

	// free(threads);
	// free(arg);

	exit(0);
}
