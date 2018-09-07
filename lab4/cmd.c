#include "types.h"
#include "stat.h"
#include "user.h"
// #include "exec.c"
// #include "forktest.c"
// #include "string.h"

int main(int argc, char *argv[])
{
	char* arg[argc -1];
	for (int i=0; i<argc-1; i++)
		arg[i] = argv[i+1];
	int pid = fork();
	if (pid == 0) {
		exec(arg[0], arg);
	}
	else {
		wait();
	}
	exit();
}