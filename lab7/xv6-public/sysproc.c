#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_init_counters(void)
{
	for (int i = 0; i < 10; i++) {
		mydata[i] = 0;
		mylocks[i] = 0;
	}
	return 1;
}

int
sys_acquire_lock(void)
{
	int lockNum;
	if (argint(0, &lockNum) < 0)
		return -1;
	if (lockNum < 0 || lockNum > 9)
		return -1;
	while (xchg(&mylocks[lockNum], 1) != 0);
	return 1;
}

int
sys_release_lock(void)
{
	int lockNum;
	if (argint(0, &lockNum) < 0)
		return -1;
	if (lockNum < 0 || lockNum > 9)
		return -1;
	xchg(&mylocks[lockNum], 0);
	return 1;
}

int
sys_get_var(void)
{
	int num;
	if (argint(0, &num) < 0)
		return -1;
	if (num < 0 || num > 9)
		return -1;
	return mydata[num];
}

int
sys_set_var(void)
{
	int num;
	if (argint(0, &num) < 0)
		return -1;
	if (num < 0 || num > 9)
		return -1;
	int newVal;
	if (argint(1, &newVal) < 0)
		return -1;
	mydata[num] = newVal;
	return 1;
}

int
sys_fork(void)
{
	return fork();
}

int
sys_exit(void)
{
	exit();
	return 0;  // not reached
}

int
sys_wait(void)
{
	return wait();
}

int
sys_kill(void)
{
	int pid;

	if(argint(0, &pid) < 0)
		return -1;
	return kill(pid);
}

int
sys_getpid(void)
{
	return myproc()->pid;
}

int
sys_sbrk(void)
{
	int addr;
	int n;

	if(argint(0, &n) < 0)
		return -1;
	addr = myproc()->sz;
	if(growproc(n) < 0)
		return -1;
	return addr;
}

int
sys_sleep(void)
{
	int n;
	uint ticks0;

	if(argint(0, &n) < 0)
		return -1;
	acquire(&tickslock);
	ticks0 = ticks;
	while(ticks - ticks0 < n){
		if(myproc()->killed){
			release(&tickslock);
			return -1;
		}
		sleep(&ticks, &tickslock);
	}
	release(&tickslock);
	return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
	uint xticks;

	acquire(&tickslock);
	xticks = ticks;
	release(&tickslock);
	return xticks;
}
