#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

void sys_signal_process(void){
  int pid;
  argint(0, &pid);
  int signal;
  argint(1, &signal);
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid)
      p->signal = signal;
  }
  release(&ptable.lock);
}

int sys_getppid(void)
{
	return myproc()->parent->pid;
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

void sys_pause(void){
  int pid;
  argint(0, &pid);
  int duration;
  argint(1, &duration);
  struct proc *p;
  int pause_duration = uptime();
  // cprintf("%d\n",pause_duration);
  pause_duration = duration + pause_duration;
  // cprintf("%d\n",pause_duration);
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->signal = 2;
      p->pause_duration = pause_duration;
    }
  }
  release(&ptable.lock);
}