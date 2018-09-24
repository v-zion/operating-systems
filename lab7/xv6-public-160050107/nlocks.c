#include "types.h"
#include "stat.h"
#include "user.h"

int main()
{
	int ret[10];

	init_counters();

	for (int i = 0; i < 10; i++) {
		ret[i] = fork();
		for(int j = 0; j < 1000; j++) {
			acquire_lock(i);
			set_var(i, get_var(i)+1);
			release_lock(i);
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
		acquire_lock(i);
		int val = get_var(i);
		release_lock(i);
		printf(1,"data[%d] = %d\n", i, val);
	}
	exit();
}

