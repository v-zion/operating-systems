#include <pthread.h>
#include <stdio.h>

#define NTHREADS 10
#define NCOUNTERS 10
#define NLOCKS 10

long int counter[NCOUNTERS] = {0};
pthread_mutex_t mutexLock[NLOCKS] = PTHREAD_MUTEX_INITIALIZER;

//	The thread starter function
void *myThread(int n)
{
	for(int i=0; i<1000; i++) {
		pthread_mutex_lock(&mutexLock[n]);
		counter[n]++;
		pthread_mutex_unlock(&mutexLock[n]);
	}
}

int main()
{
	// Create space for pthread variables
	pthread_t tid[NTHREADS];

	for(int i=0; i<NTHREADS; i++)
	{
		//	Create a thread with default attributes and no arguments
		pthread_create(&tid[i], NULL, (void *)myThread, (void *)i);
	}

	for(int i=0; i<NTHREADS; i++)
	{
		//	Wait for all threads to finish
		pthread_join(tid[i], NULL);
	}

	for (int j = 0; j < NTHREADS; j++){
		for (int i = 0; i < 1000; i++){
			counter[j]++;
			pthread_mutex_destroy(&mutexLock[j]);
		}
	}

	for (int i = 0; i < 10; i++){
		printf("Counter[%d]: %ld\n", i, counter[i]);
	}

	return 0;
}