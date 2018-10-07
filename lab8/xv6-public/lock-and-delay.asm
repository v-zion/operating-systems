
_lock-and-delay:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	while(uptime() < endtime);
}


int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
	int ret;
	int lock_type;

	if(argc < 2)
  14:	83 39 01             	cmpl   $0x1,(%ecx)
	while(uptime() < endtime);
}


int main(int argc, char *argv[])
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
	int ret;
	int lock_type;

	if(argc < 2)
  1a:	0f 8e 70 01 00 00    	jle    190 <main+0x190>
	{
		printf(1, "./lock-and-delay <lock-type> \n");
		exit();
	}
	lock_type = atoi(argv[1]);
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	ff 70 04             	pushl  0x4(%eax)
  26:	e8 35 04 00 00       	call   460 <atoi>

	if(lock_type == 1)
  2b:	83 c4 10             	add    $0x10,%esp
  2e:	83 f8 01             	cmp    $0x1,%eax
	if(argc < 2)
	{
		printf(1, "./lock-and-delay <lock-type> \n");
		exit();
	}
	lock_type = atoi(argv[1]);
  31:	89 c7                	mov    %eax,%edi

	if(lock_type == 1)
  33:	0f 84 6a 01 00 00    	je     1a3 <main+0x1a3>
		printf(1, "\nLock-and-dalay with spinlock \n");
	else if(lock_type == 2)
  39:	83 f8 02             	cmp    $0x2,%eax
  3c:	0f 84 77 01 00 00    	je     1b9 <main+0x1b9>
		printf(1, "\nLock-and-dalay with mutex \n");

	init_counters();
  42:	e8 63 05 00 00       	call   5aa <init_counters>
	init_mutex();

	uint starting = uptime();
  47:	bb 1e 00 00 00       	mov    $0x1e,%ebx
		printf(1, "\nLock-and-dalay with spinlock \n");
	else if(lock_type == 2)
		printf(1, "\nLock-and-dalay with mutex \n");

	init_counters();
	init_mutex();
  4c:	e8 51 05 00 00       	call   5a2 <init_mutex>

	uint starting = uptime();
  51:	e8 14 05 00 00       	call   56a <uptime>
  56:	89 c6                	mov    %eax,%esi
  58:	eb 0f                	jmp    69 <main+0x69>
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

	for (int i=0; i<NCHILDREN; i++) 
  60:	83 eb 01             	sub    $0x1,%ebx
  63:	0f 84 d8 00 00 00    	je     141 <main+0x141>
	{
		ret = fork();
  69:	e8 5c 04 00 00       	call   4ca <fork>
		if (ret == 0) 
  6e:	85 c0                	test   %eax,%eax
  70:	75 ee                	jne    60 <main+0x60>
  72:	bb 0a 00 00 00       	mov    $0xa,%ebx
  77:	eb 3b                	jmp    b4 <main+0xb4>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		{
			for (int j=0; j<10; j++) 
			{
				if(lock_type == 1)				
					acquire_mutex_spinlock(0);
				else if(lock_type == 2)
  80:	83 ff 02             	cmp    $0x2,%edi
  83:	74 74                	je     f9 <main+0xf9>
					mutex_lock(0);

				set_var(0, get_var(0)+1);
  85:	83 ec 0c             	sub    $0xc,%esp
  88:	6a 00                	push   $0x0
  8a:	e8 23 05 00 00       	call   5b2 <get_var>
  8f:	5a                   	pop    %edx
  90:	59                   	pop    %ecx
  91:	83 c0 01             	add    $0x1,%eax
  94:	50                   	push   %eax
  95:	6a 00                	push   $0x0
  97:	e8 1e 05 00 00       	call   5ba <set_var>
				delay(10);
  9c:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  a3:	e8 b8 01 00 00       	call   260 <delay>
  a8:	83 c4 10             	add    $0x10,%esp
	for (int i=0; i<NCHILDREN; i++) 
	{
		ret = fork();
		if (ret == 0) 
		{
			for (int j=0; j<10; j++) 
  ab:	83 eb 01             	sub    $0x1,%ebx
  ae:	0f 84 88 00 00 00    	je     13c <main+0x13c>
			{
				if(lock_type == 1)				
  b4:	83 ff 01             	cmp    $0x1,%edi
  b7:	75 c7                	jne    80 <main+0x80>
					acquire_mutex_spinlock(0);
  b9:	83 ec 0c             	sub    $0xc,%esp
  bc:	6a 00                	push   $0x0
  be:	e8 af 04 00 00       	call   572 <acquire_mutex_spinlock>
				else if(lock_type == 2)
					mutex_lock(0);

				set_var(0, get_var(0)+1);
  c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ca:	e8 e3 04 00 00       	call   5b2 <get_var>
  cf:	59                   	pop    %ecx
  d0:	5e                   	pop    %esi
  d1:	83 c0 01             	add    $0x1,%eax
  d4:	50                   	push   %eax
  d5:	6a 00                	push   $0x0
  d7:	e8 de 04 00 00       	call   5ba <set_var>
				delay(10);
  dc:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  e3:	e8 78 01 00 00       	call   260 <delay>

				if(lock_type == 1)				
					release_mutex_spinlock(0);
  e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ef:	e8 86 04 00 00       	call   57a <release_mutex_spinlock>
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	eb b2                	jmp    ab <main+0xab>
			for (int j=0; j<10; j++) 
			{
				if(lock_type == 1)				
					acquire_mutex_spinlock(0);
				else if(lock_type == 2)
					mutex_lock(0);
  f9:	83 ec 0c             	sub    $0xc,%esp
  fc:	6a 00                	push   $0x0
  fe:	e8 cd 00 00 00       	call   1d0 <mutex_lock>

				set_var(0, get_var(0)+1);
 103:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 10a:	e8 a3 04 00 00       	call   5b2 <get_var>
 10f:	5e                   	pop    %esi
 110:	5a                   	pop    %edx
 111:	83 c0 01             	add    $0x1,%eax
 114:	50                   	push   %eax
 115:	6a 00                	push   $0x0
 117:	e8 9e 04 00 00       	call   5ba <set_var>
				delay(10);
 11c:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 123:	e8 38 01 00 00       	call   260 <delay>

				if(lock_type == 1)				
					release_mutex_spinlock(0);
				else if(lock_type == 2)
					mutex_unlock(0);
 128:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 12f:	e8 ec 00 00 00       	call   220 <mutex_unlock>
 134:	83 c4 10             	add    $0x10,%esp
 137:	e9 6f ff ff ff       	jmp    ab <main+0xab>
			}

			exit();		
 13c:	e8 91 03 00 00       	call   4d2 <exit>
 141:	bb 1e 00 00 00       	mov    $0x1e,%ebx
 146:	8d 76 00             	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		}
	}

	for (int i=0; i<NCHILDREN; i++) 
		wait();
 150:	e8 85 03 00 00       	call   4da <wait>

			exit();		
		}
	}

	for (int i=0; i<NCHILDREN; i++) 
 155:	83 eb 01             	sub    $0x1,%ebx
 158:	75 f6                	jne    150 <main+0x150>
		wait();

	printf(1, "Data[0] = %d\n", get_var(0));
 15a:	83 ec 0c             	sub    $0xc,%esp
 15d:	6a 00                	push   $0x0
 15f:	e8 4e 04 00 00       	call   5b2 <get_var>
 164:	83 c4 0c             	add    $0xc,%esp
 167:	50                   	push   %eax
 168:	68 ed 09 00 00       	push   $0x9ed
 16d:	6a 01                	push   $0x1
 16f:	e8 fc 04 00 00       	call   670 <printf>
	printf(1, "Duration: %d ticks \n\n", uptime() - starting);
 174:	e8 f1 03 00 00       	call   56a <uptime>
 179:	83 c4 0c             	add    $0xc,%esp
 17c:	29 f0                	sub    %esi,%eax
 17e:	50                   	push   %eax
 17f:	68 fb 09 00 00       	push   $0x9fb
 184:	6a 01                	push   $0x1
 186:	e8 e5 04 00 00       	call   670 <printf>

	exit();
 18b:	e8 42 03 00 00       	call   4d2 <exit>
	int ret;
	int lock_type;

	if(argc < 2)
	{
		printf(1, "./lock-and-delay <lock-type> \n");
 190:	50                   	push   %eax
 191:	50                   	push   %eax
 192:	68 90 09 00 00       	push   $0x990
 197:	6a 01                	push   $0x1
 199:	e8 d2 04 00 00       	call   670 <printf>
		exit();
 19e:	e8 2f 03 00 00       	call   4d2 <exit>
	}
	lock_type = atoi(argv[1]);

	if(lock_type == 1)
		printf(1, "\nLock-and-dalay with spinlock \n");
 1a3:	50                   	push   %eax
 1a4:	50                   	push   %eax
 1a5:	68 b0 09 00 00       	push   $0x9b0
 1aa:	6a 01                	push   $0x1
 1ac:	e8 bf 04 00 00       	call   670 <printf>
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	e9 89 fe ff ff       	jmp    42 <main+0x42>
	else if(lock_type == 2)
		printf(1, "\nLock-and-dalay with mutex \n");
 1b9:	50                   	push   %eax
 1ba:	50                   	push   %eax
 1bb:	68 d0 09 00 00       	push   $0x9d0
 1c0:	6a 01                	push   $0x1
 1c2:	e8 a9 04 00 00       	call   670 <printf>
 1c7:	83 c4 10             	add    $0x10,%esp
 1ca:	e9 73 fe ff ff       	jmp    42 <main+0x42>
 1cf:	90                   	nop

000001d0 <mutex_lock>:
#include "user.h"

#define NCHILDREN 30

void mutex_lock(int index)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	83 ec 10             	sub    $0x10,%esp
 1d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
 1da:	53                   	push   %ebx
 1db:	e8 92 03 00 00       	call   572 <acquire_mutex_spinlock>
	while(get_mutex_value(index))
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	eb 11                	jmp    1f6 <mutex_lock+0x26>
 1e5:	8d 76 00             	lea    0x0(%esi),%esi
		cond_wait(1, index);
 1e8:	83 ec 08             	sub    $0x8,%esp
 1eb:	53                   	push   %ebx
 1ec:	6a 01                	push   $0x1
 1ee:	e8 8f 03 00 00       	call   582 <cond_wait>
 1f3:	83 c4 10             	add    $0x10,%esp
#define NCHILDREN 30

void mutex_lock(int index)
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
 1f6:	83 ec 0c             	sub    $0xc,%esp
 1f9:	53                   	push   %ebx
 1fa:	e8 93 03 00 00       	call   592 <get_mutex_value>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	85 c0                	test   %eax,%eax
 204:	75 e2                	jne    1e8 <mutex_lock+0x18>
		cond_wait(1, index);
	set_mutex_value(index, 1);
 206:	83 ec 08             	sub    $0x8,%esp
 209:	6a 01                	push   $0x1
 20b:	53                   	push   %ebx
 20c:	e8 89 03 00 00       	call   59a <set_mutex_value>
	release_mutex_spinlock(index);
 211:	89 5d 08             	mov    %ebx,0x8(%ebp)
 214:	83 c4 10             	add    $0x10,%esp
}
 217:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 21a:	c9                   	leave  
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
		cond_wait(1, index);
	set_mutex_value(index, 1);
	release_mutex_spinlock(index);
 21b:	e9 5a 03 00 00       	jmp    57a <release_mutex_spinlock>

00000220 <mutex_unlock>:
}

void mutex_unlock(int index)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	83 ec 10             	sub    $0x10,%esp
 227:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
 22a:	53                   	push   %ebx
 22b:	e8 42 03 00 00       	call   572 <acquire_mutex_spinlock>
	set_mutex_value(index, 0);
 230:	58                   	pop    %eax
 231:	5a                   	pop    %edx
 232:	6a 00                	push   $0x0
 234:	53                   	push   %ebx
 235:	e8 60 03 00 00       	call   59a <set_mutex_value>
	cond_signal(1);
 23a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 241:	e8 44 03 00 00       	call   58a <cond_signal>
	release_mutex_spinlock(index);
 246:	89 5d 08             	mov    %ebx,0x8(%ebp)
 249:	83 c4 10             	add    $0x10,%esp
}
 24c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 24f:	c9                   	leave  
void mutex_unlock(int index)
{
	acquire_mutex_spinlock(index);
	set_mutex_value(index, 0);
	cond_signal(1);
	release_mutex_spinlock(index);
 250:	e9 25 03 00 00       	jmp    57a <release_mutex_spinlock>
 255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <delay>:
}

void delay(int ticks)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	83 ec 04             	sub    $0x4,%esp
	uint endtime = uptime() + ticks;
 267:	e8 fe 02 00 00       	call   56a <uptime>
 26c:	03 45 08             	add    0x8(%ebp),%eax
 26f:	89 c3                	mov    %eax,%ebx
 271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

	while(uptime() < endtime);
 278:	e8 ed 02 00 00       	call   56a <uptime>
 27d:	39 c3                	cmp    %eax,%ebx
 27f:	77 f7                	ja     278 <delay+0x18>
}
 281:	83 c4 04             	add    $0x4,%esp
 284:	5b                   	pop    %ebx
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	66 90                	xchg   %ax,%ax
 289:	66 90                	xchg   %ax,%ax
 28b:	66 90                	xchg   %ax,%ax
 28d:	66 90                	xchg   %ax,%ax
 28f:	90                   	nop

00000290 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	53                   	push   %ebx
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 29a:	89 c2                	mov    %eax,%edx
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a0:	83 c1 01             	add    $0x1,%ecx
 2a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2a7:	83 c2 01             	add    $0x1,%edx
 2aa:	84 db                	test   %bl,%bl
 2ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 2af:	75 ef                	jne    2a0 <strcpy+0x10>
    ;
  return os;
}
 2b1:	5b                   	pop    %ebx
 2b2:	5d                   	pop    %ebp
 2b3:	c3                   	ret    
 2b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	56                   	push   %esi
 2c4:	53                   	push   %ebx
 2c5:	8b 55 08             	mov    0x8(%ebp),%edx
 2c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2cb:	0f b6 02             	movzbl (%edx),%eax
 2ce:	0f b6 19             	movzbl (%ecx),%ebx
 2d1:	84 c0                	test   %al,%al
 2d3:	75 1e                	jne    2f3 <strcmp+0x33>
 2d5:	eb 29                	jmp    300 <strcmp+0x40>
 2d7:	89 f6                	mov    %esi,%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2e0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2e6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2e9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2ed:	84 c0                	test   %al,%al
 2ef:	74 0f                	je     300 <strcmp+0x40>
 2f1:	89 f1                	mov    %esi,%ecx
 2f3:	38 d8                	cmp    %bl,%al
 2f5:	74 e9                	je     2e0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2f7:	29 d8                	sub    %ebx,%eax
}
 2f9:	5b                   	pop    %ebx
 2fa:	5e                   	pop    %esi
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 300:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 302:	29 d8                	sub    %ebx,%eax
}
 304:	5b                   	pop    %ebx
 305:	5e                   	pop    %esi
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <strlen>:

uint
strlen(char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 316:	80 39 00             	cmpb   $0x0,(%ecx)
 319:	74 12                	je     32d <strlen+0x1d>
 31b:	31 d2                	xor    %edx,%edx
 31d:	8d 76 00             	lea    0x0(%esi),%esi
 320:	83 c2 01             	add    $0x1,%edx
 323:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 327:	89 d0                	mov    %edx,%eax
 329:	75 f5                	jne    320 <strlen+0x10>
    ;
  return n;
}
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 32d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 32f:	5d                   	pop    %ebp
 330:	c3                   	ret    
 331:	eb 0d                	jmp    340 <memset>
 333:	90                   	nop
 334:	90                   	nop
 335:	90                   	nop
 336:	90                   	nop
 337:	90                   	nop
 338:	90                   	nop
 339:	90                   	nop
 33a:	90                   	nop
 33b:	90                   	nop
 33c:	90                   	nop
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <memset>:

void*
memset(void *dst, int c, uint n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 347:	8b 4d 10             	mov    0x10(%ebp),%ecx
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	89 d7                	mov    %edx,%edi
 34f:	fc                   	cld    
 350:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 352:	89 d0                	mov    %edx,%eax
 354:	5f                   	pop    %edi
 355:	5d                   	pop    %ebp
 356:	c3                   	ret    
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 36a:	0f b6 10             	movzbl (%eax),%edx
 36d:	84 d2                	test   %dl,%dl
 36f:	74 1d                	je     38e <strchr+0x2e>
    if(*s == c)
 371:	38 d3                	cmp    %dl,%bl
 373:	89 d9                	mov    %ebx,%ecx
 375:	75 0d                	jne    384 <strchr+0x24>
 377:	eb 17                	jmp    390 <strchr+0x30>
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 380:	38 ca                	cmp    %cl,%dl
 382:	74 0c                	je     390 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 384:	83 c0 01             	add    $0x1,%eax
 387:	0f b6 10             	movzbl (%eax),%edx
 38a:	84 d2                	test   %dl,%dl
 38c:	75 f2                	jne    380 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 38e:	31 c0                	xor    %eax,%eax
}
 390:	5b                   	pop    %ebx
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <gets>:

char*
gets(char *buf, int max)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3ab:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3ae:	eb 29                	jmp    3d9 <gets+0x39>
    cc = read(0, &c, 1);
 3b0:	83 ec 04             	sub    $0x4,%esp
 3b3:	6a 01                	push   $0x1
 3b5:	57                   	push   %edi
 3b6:	6a 00                	push   $0x0
 3b8:	e8 2d 01 00 00       	call   4ea <read>
    if(cc < 1)
 3bd:	83 c4 10             	add    $0x10,%esp
 3c0:	85 c0                	test   %eax,%eax
 3c2:	7e 1d                	jle    3e1 <gets+0x41>
      break;
    buf[i++] = c;
 3c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3c8:	8b 55 08             	mov    0x8(%ebp),%edx
 3cb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3cd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3cf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3d3:	74 1b                	je     3f0 <gets+0x50>
 3d5:	3c 0d                	cmp    $0xd,%al
 3d7:	74 17                	je     3f0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3df:	7c cf                	jl     3b0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3e1:	8b 45 08             	mov    0x8(%ebp),%eax
 3e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3eb:	5b                   	pop    %ebx
 3ec:	5e                   	pop    %esi
 3ed:	5f                   	pop    %edi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3f0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fc:	5b                   	pop    %ebx
 3fd:	5e                   	pop    %esi
 3fe:	5f                   	pop    %edi
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret    
 401:	eb 0d                	jmp    410 <stat>
 403:	90                   	nop
 404:	90                   	nop
 405:	90                   	nop
 406:	90                   	nop
 407:	90                   	nop
 408:	90                   	nop
 409:	90                   	nop
 40a:	90                   	nop
 40b:	90                   	nop
 40c:	90                   	nop
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <stat>:

int
stat(char *n, struct stat *st)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	pushl  0x8(%ebp)
 41d:	e8 f0 00 00 00       	call   512 <open>
  if(fd < 0)
 422:	83 c4 10             	add    $0x10,%esp
 425:	85 c0                	test   %eax,%eax
 427:	78 27                	js     450 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	ff 75 0c             	pushl  0xc(%ebp)
 42f:	89 c3                	mov    %eax,%ebx
 431:	50                   	push   %eax
 432:	e8 f3 00 00 00       	call   52a <fstat>
 437:	89 c6                	mov    %eax,%esi
  close(fd);
 439:	89 1c 24             	mov    %ebx,(%esp)
 43c:	e8 b9 00 00 00       	call   4fa <close>
  return r;
 441:	83 c4 10             	add    $0x10,%esp
 444:	89 f0                	mov    %esi,%eax
}
 446:	8d 65 f8             	lea    -0x8(%ebp),%esp
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 455:	eb ef                	jmp    446 <stat+0x36>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 467:	0f be 11             	movsbl (%ecx),%edx
 46a:	8d 42 d0             	lea    -0x30(%edx),%eax
 46d:	3c 09                	cmp    $0x9,%al
 46f:	b8 00 00 00 00       	mov    $0x0,%eax
 474:	77 1f                	ja     495 <atoi+0x35>
 476:	8d 76 00             	lea    0x0(%esi),%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 480:	8d 04 80             	lea    (%eax,%eax,4),%eax
 483:	83 c1 01             	add    $0x1,%ecx
 486:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 48a:	0f be 11             	movsbl (%ecx),%edx
 48d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 490:	80 fb 09             	cmp    $0x9,%bl
 493:	76 eb                	jbe    480 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 495:	5b                   	pop    %ebx
 496:	5d                   	pop    %ebp
 497:	c3                   	ret    
 498:	90                   	nop
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
 4a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ae:	85 db                	test   %ebx,%ebx
 4b0:	7e 14                	jle    4c6 <memmove+0x26>
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4c2:	39 da                	cmp    %ebx,%edx
 4c4:	75 f2                	jne    4b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    

000004ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ca:	b8 01 00 00 00       	mov    $0x1,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <exit>:
SYSCALL(exit)
 4d2:	b8 02 00 00 00       	mov    $0x2,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <wait>:
SYSCALL(wait)
 4da:	b8 03 00 00 00       	mov    $0x3,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <pipe>:
SYSCALL(pipe)
 4e2:	b8 04 00 00 00       	mov    $0x4,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <read>:
SYSCALL(read)
 4ea:	b8 05 00 00 00       	mov    $0x5,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <write>:
SYSCALL(write)
 4f2:	b8 10 00 00 00       	mov    $0x10,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <close>:
SYSCALL(close)
 4fa:	b8 15 00 00 00       	mov    $0x15,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kill>:
SYSCALL(kill)
 502:	b8 06 00 00 00       	mov    $0x6,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <exec>:
SYSCALL(exec)
 50a:	b8 07 00 00 00       	mov    $0x7,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <open>:
SYSCALL(open)
 512:	b8 0f 00 00 00       	mov    $0xf,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <mknod>:
SYSCALL(mknod)
 51a:	b8 11 00 00 00       	mov    $0x11,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <unlink>:
SYSCALL(unlink)
 522:	b8 12 00 00 00       	mov    $0x12,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <fstat>:
SYSCALL(fstat)
 52a:	b8 08 00 00 00       	mov    $0x8,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <link>:
SYSCALL(link)
 532:	b8 13 00 00 00       	mov    $0x13,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mkdir>:
SYSCALL(mkdir)
 53a:	b8 14 00 00 00       	mov    $0x14,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <chdir>:
SYSCALL(chdir)
 542:	b8 09 00 00 00       	mov    $0x9,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <dup>:
SYSCALL(dup)
 54a:	b8 0a 00 00 00       	mov    $0xa,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <getpid>:
SYSCALL(getpid)
 552:	b8 0b 00 00 00       	mov    $0xb,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <sbrk>:
SYSCALL(sbrk)
 55a:	b8 0c 00 00 00       	mov    $0xc,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <sleep>:
SYSCALL(sleep)
 562:	b8 0d 00 00 00       	mov    $0xd,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <uptime>:
SYSCALL(uptime)
 56a:	b8 0e 00 00 00       	mov    $0xe,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <acquire_mutex_spinlock>:

SYSCALL(acquire_mutex_spinlock)
 572:	b8 16 00 00 00       	mov    $0x16,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <release_mutex_spinlock>:
SYSCALL(release_mutex_spinlock)
 57a:	b8 17 00 00 00       	mov    $0x17,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <cond_wait>:
SYSCALL(cond_wait)
 582:	b8 18 00 00 00       	mov    $0x18,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <cond_signal>:
SYSCALL(cond_signal)
 58a:	b8 19 00 00 00       	mov    $0x19,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <get_mutex_value>:
SYSCALL(get_mutex_value)
 592:	b8 1a 00 00 00       	mov    $0x1a,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <set_mutex_value>:
SYSCALL(set_mutex_value)
 59a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <init_mutex>:
SYSCALL(init_mutex)
 5a2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <init_counters>:
SYSCALL(init_counters)
 5aa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <get_var>:
SYSCALL(get_var)
 5b2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <set_var>:
SYSCALL(set_var)
 5ba:	b8 1f 00 00 00       	mov    $0x1f,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    
 5c2:	66 90                	xchg   %ax,%ax
 5c4:	66 90                	xchg   %ax,%ax
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	89 c6                	mov    %eax,%esi
 5d8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5de:	85 db                	test   %ebx,%ebx
 5e0:	74 7e                	je     660 <printint+0x90>
 5e2:	89 d0                	mov    %edx,%eax
 5e4:	c1 e8 1f             	shr    $0x1f,%eax
 5e7:	84 c0                	test   %al,%al
 5e9:	74 75                	je     660 <printint+0x90>
    neg = 1;
    x = -xx;
 5eb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5ed:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5f4:	f7 d8                	neg    %eax
 5f6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5f9:	31 ff                	xor    %edi,%edi
 5fb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5fe:	89 ce                	mov    %ecx,%esi
 600:	eb 08                	jmp    60a <printint+0x3a>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 608:	89 cf                	mov    %ecx,%edi
 60a:	31 d2                	xor    %edx,%edx
 60c:	8d 4f 01             	lea    0x1(%edi),%ecx
 60f:	f7 f6                	div    %esi
 611:	0f b6 92 18 0a 00 00 	movzbl 0xa18(%edx),%edx
  }while((x /= base) != 0);
 618:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 61a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 61d:	75 e9                	jne    608 <printint+0x38>
  if(neg)
 61f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 622:	8b 75 c0             	mov    -0x40(%ebp),%esi
 625:	85 c0                	test   %eax,%eax
 627:	74 08                	je     631 <printint+0x61>
    buf[i++] = '-';
 629:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 62e:	8d 4f 02             	lea    0x2(%edi),%ecx
 631:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 635:	8d 76 00             	lea    0x0(%esi),%esi
 638:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63b:	83 ec 04             	sub    $0x4,%esp
 63e:	83 ef 01             	sub    $0x1,%edi
 641:	6a 01                	push   $0x1
 643:	53                   	push   %ebx
 644:	56                   	push   %esi
 645:	88 45 d7             	mov    %al,-0x29(%ebp)
 648:	e8 a5 fe ff ff       	call   4f2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 64d:	83 c4 10             	add    $0x10,%esp
 650:	39 df                	cmp    %ebx,%edi
 652:	75 e4                	jne    638 <printint+0x68>
    putc(fd, buf[i]);
}
 654:	8d 65 f4             	lea    -0xc(%ebp),%esp
 657:	5b                   	pop    %ebx
 658:	5e                   	pop    %esi
 659:	5f                   	pop    %edi
 65a:	5d                   	pop    %ebp
 65b:	c3                   	ret    
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 660:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 662:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 669:	eb 8b                	jmp    5f6 <printint+0x26>
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 676:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 679:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 67c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 67f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 682:	89 45 d0             	mov    %eax,-0x30(%ebp)
 685:	0f b6 1e             	movzbl (%esi),%ebx
 688:	83 c6 01             	add    $0x1,%esi
 68b:	84 db                	test   %bl,%bl
 68d:	0f 84 b0 00 00 00    	je     743 <printf+0xd3>
 693:	31 d2                	xor    %edx,%edx
 695:	eb 39                	jmp    6d0 <printf+0x60>
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6a0:	83 f8 25             	cmp    $0x25,%eax
 6a3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6a6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6ab:	74 18                	je     6c5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ad:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6b6:	6a 01                	push   $0x1
 6b8:	50                   	push   %eax
 6b9:	57                   	push   %edi
 6ba:	e8 33 fe ff ff       	call   4f2 <write>
 6bf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6cc:	84 db                	test   %bl,%bl
 6ce:	74 73                	je     743 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6d0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6d2:	0f be cb             	movsbl %bl,%ecx
 6d5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6d8:	74 c6                	je     6a0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6da:	83 fa 25             	cmp    $0x25,%edx
 6dd:	75 e6                	jne    6c5 <printf+0x55>
      if(c == 'd'){
 6df:	83 f8 64             	cmp    $0x64,%eax
 6e2:	0f 84 f8 00 00 00    	je     7e0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6e8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6ee:	83 f9 70             	cmp    $0x70,%ecx
 6f1:	74 5d                	je     750 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6f3:	83 f8 73             	cmp    $0x73,%eax
 6f6:	0f 84 84 00 00 00    	je     780 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6fc:	83 f8 63             	cmp    $0x63,%eax
 6ff:	0f 84 ea 00 00 00    	je     7ef <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 705:	83 f8 25             	cmp    $0x25,%eax
 708:	0f 84 c2 00 00 00    	je     7d0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 711:	83 ec 04             	sub    $0x4,%esp
 714:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 718:	6a 01                	push   $0x1
 71a:	50                   	push   %eax
 71b:	57                   	push   %edi
 71c:	e8 d1 fd ff ff       	call   4f2 <write>
 721:	83 c4 0c             	add    $0xc,%esp
 724:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 727:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 72a:	6a 01                	push   $0x1
 72c:	50                   	push   %eax
 72d:	57                   	push   %edi
 72e:	83 c6 01             	add    $0x1,%esi
 731:	e8 bc fd ff ff       	call   4f2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 736:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 73d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 73f:	84 db                	test   %bl,%bl
 741:	75 8d                	jne    6d0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 743:	8d 65 f4             	lea    -0xc(%ebp),%esp
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 10 00 00 00       	mov    $0x10,%ecx
 758:	6a 00                	push   $0x0
 75a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 75d:	89 f8                	mov    %edi,%eax
 75f:	8b 13                	mov    (%ebx),%edx
 761:	e8 6a fe ff ff       	call   5d0 <printint>
        ap++;
 766:	89 d8                	mov    %ebx,%eax
 768:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 76b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 76d:	83 c0 04             	add    $0x4,%eax
 770:	89 45 d0             	mov    %eax,-0x30(%ebp)
 773:	e9 4d ff ff ff       	jmp    6c5 <printf+0x55>
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 780:	8b 45 d0             	mov    -0x30(%ebp),%eax
 783:	8b 18                	mov    (%eax),%ebx
        ap++;
 785:	83 c0 04             	add    $0x4,%eax
 788:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 78b:	b8 11 0a 00 00       	mov    $0xa11,%eax
 790:	85 db                	test   %ebx,%ebx
 792:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 795:	0f b6 03             	movzbl (%ebx),%eax
 798:	84 c0                	test   %al,%al
 79a:	74 23                	je     7bf <printf+0x14f>
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7a3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7a6:	83 ec 04             	sub    $0x4,%esp
 7a9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7ab:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ae:	50                   	push   %eax
 7af:	57                   	push   %edi
 7b0:	e8 3d fd ff ff       	call   4f2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7b5:	0f b6 03             	movzbl (%ebx),%eax
 7b8:	83 c4 10             	add    $0x10,%esp
 7bb:	84 c0                	test   %al,%al
 7bd:	75 e1                	jne    7a0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7bf:	31 d2                	xor    %edx,%edx
 7c1:	e9 ff fe ff ff       	jmp    6c5 <printf+0x55>
 7c6:	8d 76 00             	lea    0x0(%esi),%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7d9:	6a 01                	push   $0x1
 7db:	e9 4c ff ff ff       	jmp    72c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7e0:	83 ec 0c             	sub    $0xc,%esp
 7e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7e8:	6a 01                	push   $0x1
 7ea:	e9 6b ff ff ff       	jmp    75a <printf+0xea>
 7ef:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7f2:	83 ec 04             	sub    $0x4,%esp
 7f5:	8b 03                	mov    (%ebx),%eax
 7f7:	6a 01                	push   $0x1
 7f9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 7fc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ff:	50                   	push   %eax
 800:	57                   	push   %edi
 801:	e8 ec fc ff ff       	call   4f2 <write>
 806:	e9 5b ff ff ff       	jmp    766 <printf+0xf6>
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	a1 28 0d 00 00       	mov    0xd28,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 816:	89 e5                	mov    %esp,%ebp
 818:	57                   	push   %edi
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
 81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 820:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 823:	39 c8                	cmp    %ecx,%eax
 825:	73 19                	jae    840 <free+0x30>
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 830:	39 d1                	cmp    %edx,%ecx
 832:	72 1c                	jb     850 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	39 d0                	cmp    %edx,%eax
 836:	73 18                	jae    850 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 838:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	72 f0                	jb     830 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 840:	39 d0                	cmp    %edx,%eax
 842:	72 f4                	jb     838 <free+0x28>
 844:	39 d1                	cmp    %edx,%ecx
 846:	73 f0                	jae    838 <free+0x28>
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 850:	8b 73 fc             	mov    -0x4(%ebx),%esi
 853:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 856:	39 d7                	cmp    %edx,%edi
 858:	74 19                	je     873 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 85a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 85d:	8b 50 04             	mov    0x4(%eax),%edx
 860:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 863:	39 f1                	cmp    %esi,%ecx
 865:	74 23                	je     88a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 867:	89 08                	mov    %ecx,(%eax)
  freep = p;
 869:	a3 28 0d 00 00       	mov    %eax,0xd28
}
 86e:	5b                   	pop    %ebx
 86f:	5e                   	pop    %esi
 870:	5f                   	pop    %edi
 871:	5d                   	pop    %ebp
 872:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 873:	03 72 04             	add    0x4(%edx),%esi
 876:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 879:	8b 10                	mov    (%eax),%edx
 87b:	8b 12                	mov    (%edx),%edx
 87d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 880:	8b 50 04             	mov    0x4(%eax),%edx
 883:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 886:	39 f1                	cmp    %esi,%ecx
 888:	75 dd                	jne    867 <free+0x57>
    p->s.size += bp->s.size;
 88a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 88d:	a3 28 0d 00 00       	mov    %eax,0xd28
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 892:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 895:	8b 53 f8             	mov    -0x8(%ebx),%edx
 898:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 89a:	5b                   	pop    %ebx
 89b:	5e                   	pop    %esi
 89c:	5f                   	pop    %edi
 89d:	5d                   	pop    %ebp
 89e:	c3                   	ret    
 89f:	90                   	nop

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 15 28 0d 00 00    	mov    0xd28,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 78 07             	lea    0x7(%eax),%edi
 8b5:	c1 ef 03             	shr    $0x3,%edi
 8b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8bb:	85 d2                	test   %edx,%edx
 8bd:	0f 84 a3 00 00 00    	je     966 <malloc+0xc6>
 8c3:	8b 02                	mov    (%edx),%eax
 8c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c8:	39 cf                	cmp    %ecx,%edi
 8ca:	76 74                	jbe    940 <malloc+0xa0>
 8cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8d2:	be 00 10 00 00       	mov    $0x1000,%esi
 8d7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8de:	0f 43 f7             	cmovae %edi,%esi
 8e1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8e6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8ec:	0f 46 da             	cmovbe %edx,%ebx
 8ef:	eb 10                	jmp    901 <malloc+0x61>
 8f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8fa:	8b 48 04             	mov    0x4(%eax),%ecx
 8fd:	39 cf                	cmp    %ecx,%edi
 8ff:	76 3f                	jbe    940 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 901:	39 05 28 0d 00 00    	cmp    %eax,0xd28
 907:	89 c2                	mov    %eax,%edx
 909:	75 ed                	jne    8f8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 90b:	83 ec 0c             	sub    $0xc,%esp
 90e:	53                   	push   %ebx
 90f:	e8 46 fc ff ff       	call   55a <sbrk>
  if(p == (char*)-1)
 914:	83 c4 10             	add    $0x10,%esp
 917:	83 f8 ff             	cmp    $0xffffffff,%eax
 91a:	74 1c                	je     938 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 91c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 91f:	83 ec 0c             	sub    $0xc,%esp
 922:	83 c0 08             	add    $0x8,%eax
 925:	50                   	push   %eax
 926:	e8 e5 fe ff ff       	call   810 <free>
  return freep;
 92b:	8b 15 28 0d 00 00    	mov    0xd28,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 931:	83 c4 10             	add    $0x10,%esp
 934:	85 d2                	test   %edx,%edx
 936:	75 c0                	jne    8f8 <malloc+0x58>
        return 0;
 938:	31 c0                	xor    %eax,%eax
 93a:	eb 1c                	jmp    958 <malloc+0xb8>
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 940:	39 cf                	cmp    %ecx,%edi
 942:	74 1c                	je     960 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 944:	29 f9                	sub    %edi,%ecx
 946:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 949:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 94c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 94f:	89 15 28 0d 00 00    	mov    %edx,0xd28
      return (void*)(p + 1);
 955:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 958:	8d 65 f4             	lea    -0xc(%ebp),%esp
 95b:	5b                   	pop    %ebx
 95c:	5e                   	pop    %esi
 95d:	5f                   	pop    %edi
 95e:	5d                   	pop    %ebp
 95f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 960:	8b 08                	mov    (%eax),%ecx
 962:	89 0a                	mov    %ecx,(%edx)
 964:	eb e9                	jmp    94f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 966:	c7 05 28 0d 00 00 2c 	movl   $0xd2c,0xd28
 96d:	0d 00 00 
 970:	c7 05 2c 0d 00 00 2c 	movl   $0xd2c,0xd2c
 977:	0d 00 00 
    base.s.size = 0;
 97a:	b8 2c 0d 00 00       	mov    $0xd2c,%eax
 97f:	c7 05 30 0d 00 00 00 	movl   $0x0,0xd30
 986:	00 00 00 
 989:	e9 3e ff ff ff       	jmp    8cc <malloc+0x2c>
