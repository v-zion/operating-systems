#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

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

/****************************************Lab 10****************************************/
int
sys_signal(void)
{
	char *handler;
	if (argptr(0, &handler, sizeof(handler)) < 0)
		return -1;
	return signal(handler);
}

int
sys_signal_send(void)
{
	int pid, sig_type;
	if (argint(0, &pid) < 0 || argint(1, & sig_type) < 0)
		return -1;
	return signal_send(pid, sig_type);
}

int
sys_signal_ret(void)
{
	return signal_ret();	
}

int
sys_setprio(void)
{
	int priority;
	if (argint(0, &priority) < 0)
		return -1;
	if (priority < 0)
		return -1;
	struct proc * p = myproc();
	p->priority = priority;
	return 1;
}

int
sys_getprio(void)
{
	return myproc()->priority;
}

int
sys_fork2(void)
{
	int priority;
	if (argint(0, &priority) < 0)
		return -1;
	if (priority < 0)
		return -1;
	return fork2(priority);
}
/****************************************Lab 10****************************************/