#include "types.h"
#include "stat.h"
#include "user.h"

void mutex_lock(int index)
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
		cond_wait(1, index);
	set_mutex_value(index, 1);
	release_mutex_spinlock(index);
}

void mutex_unlock(int index)
{
	acquire_mutex_spinlock(index);
	set_mutex_value(index, 0);
	cond_signal(1);
	release_mutex_spinlock(index);
}

int main()
{
	int ret[10];

	init_counters();

	for (int i = 0; i < 10; i++) {
		ret[i] = fork();
		for(int j = 0; j < 1000; j++) {
			mutex_lock(i);
			set_var(i, get_var(i)+1);
			mutex_unlock(i);
		}
		if (ret[i] == 0)
			break;
	}

	for (int i = 0; i < 10; i++) {
		if (ret[i] == 0)
			exit();
	}

	for (int i = 0; i < 10; i++){
		wait();
		mutex_lock(i);
		int val = get_var(i);
		mutex_unlock(i);
		printf(1,"data[%d] = %d\n", i, val);
	}
	exit();
}

