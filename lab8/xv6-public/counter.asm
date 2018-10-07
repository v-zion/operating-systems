
_counter:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	cond_signal(1);
	release_mutex_spinlock(index);
}

int main(int argc, char* argv[])
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
  11:	31 f6                	xor    %esi,%esi
  13:	83 ec 08             	sub    $0x8,%esp
	int ret;
	int with_locks;

	with_locks = 0;
	if(argc == 2 && atoi(argv[1]) == 2 )
  16:	83 39 02             	cmpl   $0x2,(%ecx)
	cond_signal(1);
	release_mutex_spinlock(index);
}

int main(int argc, char* argv[])
{
  19:	8b 41 04             	mov    0x4(%ecx),%eax
	int ret;
	int with_locks;

	with_locks = 0;
	if(argc == 2 && atoi(argv[1]) == 2 )
  1c:	0f 84 c4 00 00 00    	je     e6 <main+0xe6>
		with_locks = 1;

	init_counters();
  22:	e8 93 04 00 00       	call   4ba <init_counters>
	init_mutex();

	ret = fork();				//	Two process update shared counter
  27:	bb 10 27 00 00       	mov    $0x2710,%ebx
	with_locks = 0;
	if(argc == 2 && atoi(argv[1]) == 2 )
		with_locks = 1;

	init_counters();
	init_mutex();
  2c:	e8 81 04 00 00       	call   4b2 <init_mutex>

	ret = fork();				//	Two process update shared counter
  31:	e8 a4 03 00 00       	call   3da <fork>
  36:	89 c7                	mov    %eax,%edi
  38:	eb 25                	jmp    5f <main+0x5f>
  3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for (int j=0; j<10000; j++) 
	{
		if(with_locks)
			mutex_lock(0);

		set_var(0, get_var(0)+1);
  40:	83 ec 0c             	sub    $0xc,%esp
  43:	6a 00                	push   $0x0
  45:	e8 78 04 00 00       	call   4c2 <get_var>
  4a:	5a                   	pop    %edx
  4b:	59                   	pop    %ecx
  4c:	83 c0 01             	add    $0x1,%eax
  4f:	50                   	push   %eax
  50:	6a 00                	push   $0x0
  52:	e8 73 04 00 00       	call   4ca <set_var>
  57:	83 c4 10             	add    $0x10,%esp
	init_counters();
	init_mutex();

	ret = fork();				//	Two process update shared counter

	for (int j=0; j<10000; j++) 
  5a:	83 eb 01             	sub    $0x1,%ebx
  5d:	74 3b                	je     9a <main+0x9a>
	{
		if(with_locks)
  5f:	85 f6                	test   %esi,%esi
  61:	74 dd                	je     40 <main+0x40>
			mutex_lock(0);
  63:	83 ec 0c             	sub    $0xc,%esp
  66:	6a 00                	push   $0x0
  68:	e8 a3 00 00 00       	call   110 <mutex_lock>

		set_var(0, get_var(0)+1);
  6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  74:	e8 49 04 00 00       	call   4c2 <get_var>
  79:	5a                   	pop    %edx
  7a:	59                   	pop    %ecx
  7b:	83 c0 01             	add    $0x1,%eax
  7e:	50                   	push   %eax
  7f:	6a 00                	push   $0x0
  81:	e8 44 04 00 00       	call   4ca <set_var>
		
		if(with_locks)
			mutex_unlock(0);
  86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8d:	e8 ce 00 00 00       	call   160 <mutex_unlock>
  92:	83 c4 10             	add    $0x10,%esp
	init_counters();
	init_mutex();

	ret = fork();				//	Two process update shared counter

	for (int j=0; j<10000; j++) 
  95:	83 eb 01             	sub    $0x1,%ebx
  98:	75 c5                	jne    5f <main+0x5f>
		
		if(with_locks)
			mutex_unlock(0);
	}

	if(ret == 0)
  9a:	85 ff                	test   %edi,%edi
  9c:	75 05                	jne    a3 <main+0xa3>
		exit();
  9e:	e8 3f 03 00 00       	call   3e2 <exit>

	wait();
  a3:	e8 42 03 00 00       	call   3ea <wait>

	printf(1, "\nCounter %s lock \n", with_locks ? "with mutex": "without");
  a8:	85 f6                	test   %esi,%esi
  aa:	ba ab 08 00 00       	mov    $0x8ab,%edx
  af:	b8 a0 08 00 00       	mov    $0x8a0,%eax
  b4:	0f 44 c2             	cmove  %edx,%eax
  b7:	53                   	push   %ebx
  b8:	50                   	push   %eax
  b9:	68 b3 08 00 00       	push   $0x8b3
  be:	6a 01                	push   $0x1
  c0:	e8 bb 04 00 00       	call   580 <printf>
	printf(1, "Data[0] = %d\n\n", get_var(0));
  c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  cc:	e8 f1 03 00 00       	call   4c2 <get_var>
  d1:	83 c4 0c             	add    $0xc,%esp
  d4:	50                   	push   %eax
  d5:	68 c6 08 00 00       	push   $0x8c6
  da:	6a 01                	push   $0x1
  dc:	e8 9f 04 00 00       	call   580 <printf>

	exit();
  e1:	e8 fc 02 00 00       	call   3e2 <exit>
{
	int ret;
	int with_locks;

	with_locks = 0;
	if(argc == 2 && atoi(argv[1]) == 2 )
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	ff 70 04             	pushl  0x4(%eax)
  ec:	e8 7f 02 00 00       	call   370 <atoi>
int main(int argc, char* argv[])
{
	int ret;
	int with_locks;

	with_locks = 0;
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	83 f8 02             	cmp    $0x2,%eax
  f7:	0f 94 c0             	sete   %al
  fa:	0f b6 c0             	movzbl %al,%eax
  fd:	89 c6                	mov    %eax,%esi
  ff:	e9 1e ff ff ff       	jmp    22 <main+0x22>
 104:	66 90                	xchg   %ax,%ax
 106:	66 90                	xchg   %ax,%ax
 108:	66 90                	xchg   %ax,%ax
 10a:	66 90                	xchg   %ax,%ax
 10c:	66 90                	xchg   %ax,%ax
 10e:	66 90                	xchg   %ax,%ax

00000110 <mutex_lock>:
#include "types.h"
#include "stat.h"
#include "user.h"

void mutex_lock(int index)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	83 ec 10             	sub    $0x10,%esp
 117:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
 11a:	53                   	push   %ebx
 11b:	e8 62 03 00 00       	call   482 <acquire_mutex_spinlock>
	while(get_mutex_value(index))
 120:	83 c4 10             	add    $0x10,%esp
 123:	eb 11                	jmp    136 <mutex_lock+0x26>
 125:	8d 76 00             	lea    0x0(%esi),%esi
		cond_wait(1, index);
 128:	83 ec 08             	sub    $0x8,%esp
 12b:	53                   	push   %ebx
 12c:	6a 01                	push   $0x1
 12e:	e8 5f 03 00 00       	call   492 <cond_wait>
 133:	83 c4 10             	add    $0x10,%esp
#include "user.h"

void mutex_lock(int index)
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
 136:	83 ec 0c             	sub    $0xc,%esp
 139:	53                   	push   %ebx
 13a:	e8 63 03 00 00       	call   4a2 <get_mutex_value>
 13f:	83 c4 10             	add    $0x10,%esp
 142:	85 c0                	test   %eax,%eax
 144:	75 e2                	jne    128 <mutex_lock+0x18>
		cond_wait(1, index);
	set_mutex_value(index, 1);
 146:	83 ec 08             	sub    $0x8,%esp
 149:	6a 01                	push   $0x1
 14b:	53                   	push   %ebx
 14c:	e8 59 03 00 00       	call   4aa <set_mutex_value>
	release_mutex_spinlock(index);
 151:	89 5d 08             	mov    %ebx,0x8(%ebp)
 154:	83 c4 10             	add    $0x10,%esp
}
 157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15a:	c9                   	leave  
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
		cond_wait(1, index);
	set_mutex_value(index, 1);
	release_mutex_spinlock(index);
 15b:	e9 2a 03 00 00       	jmp    48a <release_mutex_spinlock>

00000160 <mutex_unlock>:
}

void mutex_unlock(int index)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	83 ec 10             	sub    $0x10,%esp
 167:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
 16a:	53                   	push   %ebx
 16b:	e8 12 03 00 00       	call   482 <acquire_mutex_spinlock>
	set_mutex_value(index, 0);
 170:	58                   	pop    %eax
 171:	5a                   	pop    %edx
 172:	6a 00                	push   $0x0
 174:	53                   	push   %ebx
 175:	e8 30 03 00 00       	call   4aa <set_mutex_value>
	cond_signal(1);
 17a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 181:	e8 14 03 00 00       	call   49a <cond_signal>
	release_mutex_spinlock(index);
 186:	89 5d 08             	mov    %ebx,0x8(%ebp)
 189:	83 c4 10             	add    $0x10,%esp
}
 18c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18f:	c9                   	leave  
void mutex_unlock(int index)
{
	acquire_mutex_spinlock(index);
	set_mutex_value(index, 0);
	cond_signal(1);
	release_mutex_spinlock(index);
 190:	e9 f5 02 00 00       	jmp    48a <release_mutex_spinlock>
 195:	66 90                	xchg   %ax,%ax
 197:	66 90                	xchg   %ax,%ax
 199:	66 90                	xchg   %ax,%ax
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	89 c2                	mov    %eax,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b0:	83 c1 01             	add    $0x1,%ecx
 1b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1b7:	83 c2 01             	add    $0x1,%edx
 1ba:	84 db                	test   %bl,%bl
 1bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1bf:	75 ef                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1c1:	5b                   	pop    %ebx
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    
 1c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 55 08             	mov    0x8(%ebp),%edx
 1d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1db:	0f b6 02             	movzbl (%edx),%eax
 1de:	0f b6 19             	movzbl (%ecx),%ebx
 1e1:	84 c0                	test   %al,%al
 1e3:	75 1e                	jne    203 <strcmp+0x33>
 1e5:	eb 29                	jmp    210 <strcmp+0x40>
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1f0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1f6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1fd:	84 c0                	test   %al,%al
 1ff:	74 0f                	je     210 <strcmp+0x40>
 201:	89 f1                	mov    %esi,%ecx
 203:	38 d8                	cmp    %bl,%al
 205:	74 e9                	je     1f0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 207:	29 d8                	sub    %ebx,%eax
}
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 210:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 212:	29 d8                	sub    %ebx,%eax
}
 214:	5b                   	pop    %ebx
 215:	5e                   	pop    %esi
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	90                   	nop
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000220 <strlen>:

uint
strlen(char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 39 00             	cmpb   $0x0,(%ecx)
 229:	74 12                	je     23d <strlen+0x1d>
 22b:	31 d2                	xor    %edx,%edx
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	83 c2 01             	add    $0x1,%edx
 233:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 237:	89 d0                	mov    %edx,%eax
 239:	75 f5                	jne    230 <strlen+0x10>
    ;
  return n;
}
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 23d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret    
 241:	eb 0d                	jmp    250 <memset>
 243:	90                   	nop
 244:	90                   	nop
 245:	90                   	nop
 246:	90                   	nop
 247:	90                   	nop
 248:	90                   	nop
 249:	90                   	nop
 24a:	90                   	nop
 24b:	90                   	nop
 24c:	90                   	nop
 24d:	90                   	nop
 24e:	90                   	nop
 24f:	90                   	nop

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	89 d0                	mov    %edx,%eax
 264:	5f                   	pop    %edi
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	74 1d                	je     29e <strchr+0x2e>
    if(*s == c)
 281:	38 d3                	cmp    %dl,%bl
 283:	89 d9                	mov    %ebx,%ecx
 285:	75 0d                	jne    294 <strchr+0x24>
 287:	eb 17                	jmp    2a0 <strchr+0x30>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 290:	38 ca                	cmp    %cl,%dl
 292:	74 0c                	je     2a0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 294:	83 c0 01             	add    $0x1,%eax
 297:	0f b6 10             	movzbl (%eax),%edx
 29a:	84 d2                	test   %dl,%dl
 29c:	75 f2                	jne    290 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 29e:	31 c0                	xor    %eax,%eax
}
 2a0:	5b                   	pop    %ebx
 2a1:	5d                   	pop    %ebp
 2a2:	c3                   	ret    
 2a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 2b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 2bb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2be:	eb 29                	jmp    2e9 <gets+0x39>
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	57                   	push   %edi
 2c6:	6a 00                	push   $0x0
 2c8:	e8 2d 01 00 00       	call   3fa <read>
    if(cc < 1)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e 1d                	jle    2f1 <gets+0x41>
      break;
    buf[i++] = c;
 2d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 2dd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2df:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2e3:	74 1b                	je     300 <gets+0x50>
 2e5:	3c 0d                	cmp    $0xd,%al
 2e7:	74 17                	je     300 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e9:	8d 5e 01             	lea    0x1(%esi),%ebx
 2ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2ef:	7c cf                	jl     2c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fb:	5b                   	pop    %ebx
 2fc:	5e                   	pop    %esi
 2fd:	5f                   	pop    %edi
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 300:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 303:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 305:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 309:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30c:	5b                   	pop    %ebx
 30d:	5e                   	pop    %esi
 30e:	5f                   	pop    %edi
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret    
 311:	eb 0d                	jmp    320 <stat>
 313:	90                   	nop
 314:	90                   	nop
 315:	90                   	nop
 316:	90                   	nop
 317:	90                   	nop
 318:	90                   	nop
 319:	90                   	nop
 31a:	90                   	nop
 31b:	90                   	nop
 31c:	90                   	nop
 31d:	90                   	nop
 31e:	90                   	nop
 31f:	90                   	nop

00000320 <stat>:

int
stat(char *n, struct stat *st)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 325:	83 ec 08             	sub    $0x8,%esp
 328:	6a 00                	push   $0x0
 32a:	ff 75 08             	pushl  0x8(%ebp)
 32d:	e8 f0 00 00 00       	call   422 <open>
  if(fd < 0)
 332:	83 c4 10             	add    $0x10,%esp
 335:	85 c0                	test   %eax,%eax
 337:	78 27                	js     360 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	ff 75 0c             	pushl  0xc(%ebp)
 33f:	89 c3                	mov    %eax,%ebx
 341:	50                   	push   %eax
 342:	e8 f3 00 00 00       	call   43a <fstat>
 347:	89 c6                	mov    %eax,%esi
  close(fd);
 349:	89 1c 24             	mov    %ebx,(%esp)
 34c:	e8 b9 00 00 00       	call   40a <close>
  return r;
 351:	83 c4 10             	add    $0x10,%esp
 354:	89 f0                	mov    %esi,%eax
}
 356:	8d 65 f8             	lea    -0x8(%ebp),%esp
 359:	5b                   	pop    %ebx
 35a:	5e                   	pop    %esi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 365:	eb ef                	jmp    356 <stat+0x36>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 11             	movsbl (%ecx),%edx
 37a:	8d 42 d0             	lea    -0x30(%edx),%eax
 37d:	3c 09                	cmp    $0x9,%al
 37f:	b8 00 00 00 00       	mov    $0x0,%eax
 384:	77 1f                	ja     3a5 <atoi+0x35>
 386:	8d 76 00             	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 390:	8d 04 80             	lea    (%eax,%eax,4),%eax
 393:	83 c1 01             	add    $0x1,%ecx
 396:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 39a:	0f be 11             	movsbl (%ecx),%edx
 39d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 3a5:	5b                   	pop    %ebx
 3a6:	5d                   	pop    %ebp
 3a7:	c3                   	ret    
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	56                   	push   %esi
 3b4:	53                   	push   %ebx
 3b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b8:	8b 45 08             	mov    0x8(%ebp),%eax
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 db                	test   %ebx,%ebx
 3c0:	7e 14                	jle    3d6 <memmove+0x26>
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	75 f2                	jne    3c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    

000003da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3da:	b8 01 00 00 00       	mov    $0x1,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <exit>:
SYSCALL(exit)
 3e2:	b8 02 00 00 00       	mov    $0x2,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <wait>:
SYSCALL(wait)
 3ea:	b8 03 00 00 00       	mov    $0x3,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <pipe>:
SYSCALL(pipe)
 3f2:	b8 04 00 00 00       	mov    $0x4,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <read>:
SYSCALL(read)
 3fa:	b8 05 00 00 00       	mov    $0x5,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <write>:
SYSCALL(write)
 402:	b8 10 00 00 00       	mov    $0x10,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <close>:
SYSCALL(close)
 40a:	b8 15 00 00 00       	mov    $0x15,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <kill>:
SYSCALL(kill)
 412:	b8 06 00 00 00       	mov    $0x6,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <exec>:
SYSCALL(exec)
 41a:	b8 07 00 00 00       	mov    $0x7,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <open>:
SYSCALL(open)
 422:	b8 0f 00 00 00       	mov    $0xf,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <mknod>:
SYSCALL(mknod)
 42a:	b8 11 00 00 00       	mov    $0x11,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <unlink>:
SYSCALL(unlink)
 432:	b8 12 00 00 00       	mov    $0x12,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <fstat>:
SYSCALL(fstat)
 43a:	b8 08 00 00 00       	mov    $0x8,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <link>:
SYSCALL(link)
 442:	b8 13 00 00 00       	mov    $0x13,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mkdir>:
SYSCALL(mkdir)
 44a:	b8 14 00 00 00       	mov    $0x14,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <chdir>:
SYSCALL(chdir)
 452:	b8 09 00 00 00       	mov    $0x9,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <dup>:
SYSCALL(dup)
 45a:	b8 0a 00 00 00       	mov    $0xa,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <getpid>:
SYSCALL(getpid)
 462:	b8 0b 00 00 00       	mov    $0xb,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <sbrk>:
SYSCALL(sbrk)
 46a:	b8 0c 00 00 00       	mov    $0xc,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <sleep>:
SYSCALL(sleep)
 472:	b8 0d 00 00 00       	mov    $0xd,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <uptime>:
SYSCALL(uptime)
 47a:	b8 0e 00 00 00       	mov    $0xe,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <acquire_mutex_spinlock>:

SYSCALL(acquire_mutex_spinlock)
 482:	b8 16 00 00 00       	mov    $0x16,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <release_mutex_spinlock>:
SYSCALL(release_mutex_spinlock)
 48a:	b8 17 00 00 00       	mov    $0x17,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <cond_wait>:
SYSCALL(cond_wait)
 492:	b8 18 00 00 00       	mov    $0x18,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <cond_signal>:
SYSCALL(cond_signal)
 49a:	b8 19 00 00 00       	mov    $0x19,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <get_mutex_value>:
SYSCALL(get_mutex_value)
 4a2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <set_mutex_value>:
SYSCALL(set_mutex_value)
 4aa:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <init_mutex>:
SYSCALL(init_mutex)
 4b2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <init_counters>:
SYSCALL(init_counters)
 4ba:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <get_var>:
SYSCALL(get_var)
 4c2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <set_var>:
SYSCALL(set_var)
 4ca:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    
 4d2:	66 90                	xchg   %ax,%ax
 4d4:	66 90                	xchg   %ax,%ax
 4d6:	66 90                	xchg   %ax,%ax
 4d8:	66 90                	xchg   %ax,%ax
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 c6                	mov    %eax,%esi
 4e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ee:	85 db                	test   %ebx,%ebx
 4f0:	74 7e                	je     570 <printint+0x90>
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	c1 e8 1f             	shr    $0x1f,%eax
 4f7:	84 c0                	test   %al,%al
 4f9:	74 75                	je     570 <printint+0x90>
    neg = 1;
    x = -xx;
 4fb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4fd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 504:	f7 d8                	neg    %eax
 506:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 509:	31 ff                	xor    %edi,%edi
 50b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 50e:	89 ce                	mov    %ecx,%esi
 510:	eb 08                	jmp    51a <printint+0x3a>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 518:	89 cf                	mov    %ecx,%edi
 51a:	31 d2                	xor    %edx,%edx
 51c:	8d 4f 01             	lea    0x1(%edi),%ecx
 51f:	f7 f6                	div    %esi
 521:	0f b6 92 dc 08 00 00 	movzbl 0x8dc(%edx),%edx
  }while((x /= base) != 0);
 528:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 52a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 52d:	75 e9                	jne    518 <printint+0x38>
  if(neg)
 52f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 532:	8b 75 c0             	mov    -0x40(%ebp),%esi
 535:	85 c0                	test   %eax,%eax
 537:	74 08                	je     541 <printint+0x61>
    buf[i++] = '-';
 539:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 53e:	8d 4f 02             	lea    0x2(%edi),%ecx
 541:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 545:	8d 76 00             	lea    0x0(%esi),%esi
 548:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54b:	83 ec 04             	sub    $0x4,%esp
 54e:	83 ef 01             	sub    $0x1,%edi
 551:	6a 01                	push   $0x1
 553:	53                   	push   %ebx
 554:	56                   	push   %esi
 555:	88 45 d7             	mov    %al,-0x29(%ebp)
 558:	e8 a5 fe ff ff       	call   402 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 55d:	83 c4 10             	add    $0x10,%esp
 560:	39 df                	cmp    %ebx,%edi
 562:	75 e4                	jne    548 <printint+0x68>
    putc(fd, buf[i]);
}
 564:	8d 65 f4             	lea    -0xc(%ebp),%esp
 567:	5b                   	pop    %ebx
 568:	5e                   	pop    %esi
 569:	5f                   	pop    %edi
 56a:	5d                   	pop    %ebp
 56b:	c3                   	ret    
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 570:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 572:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 579:	eb 8b                	jmp    506 <printint+0x26>
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 586:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 589:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 58c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 58f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 592:	89 45 d0             	mov    %eax,-0x30(%ebp)
 595:	0f b6 1e             	movzbl (%esi),%ebx
 598:	83 c6 01             	add    $0x1,%esi
 59b:	84 db                	test   %bl,%bl
 59d:	0f 84 b0 00 00 00    	je     653 <printf+0xd3>
 5a3:	31 d2                	xor    %edx,%edx
 5a5:	eb 39                	jmp    5e0 <printf+0x60>
 5a7:	89 f6                	mov    %esi,%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b0:	83 f8 25             	cmp    $0x25,%eax
 5b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 5b6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5bb:	74 18                	je     5d5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5bd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5c6:	6a 01                	push   $0x1
 5c8:	50                   	push   %eax
 5c9:	57                   	push   %edi
 5ca:	e8 33 fe ff ff       	call   402 <write>
 5cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5d2:	83 c4 10             	add    $0x10,%esp
 5d5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5dc:	84 db                	test   %bl,%bl
 5de:	74 73                	je     653 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 5e0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5e2:	0f be cb             	movsbl %bl,%ecx
 5e5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5e8:	74 c6                	je     5b0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ea:	83 fa 25             	cmp    $0x25,%edx
 5ed:	75 e6                	jne    5d5 <printf+0x55>
      if(c == 'd'){
 5ef:	83 f8 64             	cmp    $0x64,%eax
 5f2:	0f 84 f8 00 00 00    	je     6f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5f8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5fe:	83 f9 70             	cmp    $0x70,%ecx
 601:	74 5d                	je     660 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 603:	83 f8 73             	cmp    $0x73,%eax
 606:	0f 84 84 00 00 00    	je     690 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60c:	83 f8 63             	cmp    $0x63,%eax
 60f:	0f 84 ea 00 00 00    	je     6ff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 615:	83 f8 25             	cmp    $0x25,%eax
 618:	0f 84 c2 00 00 00    	je     6e0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 621:	83 ec 04             	sub    $0x4,%esp
 624:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 628:	6a 01                	push   $0x1
 62a:	50                   	push   %eax
 62b:	57                   	push   %edi
 62c:	e8 d1 fd ff ff       	call   402 <write>
 631:	83 c4 0c             	add    $0xc,%esp
 634:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 637:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 63a:	6a 01                	push   $0x1
 63c:	50                   	push   %eax
 63d:	57                   	push   %edi
 63e:	83 c6 01             	add    $0x1,%esi
 641:	e8 bc fd ff ff       	call   402 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 646:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 64d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 64f:	84 db                	test   %bl,%bl
 651:	75 8d                	jne    5e0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 653:	8d 65 f4             	lea    -0xc(%ebp),%esp
 656:	5b                   	pop    %ebx
 657:	5e                   	pop    %esi
 658:	5f                   	pop    %edi
 659:	5d                   	pop    %ebp
 65a:	c3                   	ret    
 65b:	90                   	nop
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 10 00 00 00       	mov    $0x10,%ecx
 668:	6a 00                	push   $0x0
 66a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 66d:	89 f8                	mov    %edi,%eax
 66f:	8b 13                	mov    (%ebx),%edx
 671:	e8 6a fe ff ff       	call   4e0 <printint>
        ap++;
 676:	89 d8                	mov    %ebx,%eax
 678:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 67d:	83 c0 04             	add    $0x4,%eax
 680:	89 45 d0             	mov    %eax,-0x30(%ebp)
 683:	e9 4d ff ff ff       	jmp    5d5 <printf+0x55>
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 690:	8b 45 d0             	mov    -0x30(%ebp),%eax
 693:	8b 18                	mov    (%eax),%ebx
        ap++;
 695:	83 c0 04             	add    $0x4,%eax
 698:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 69b:	b8 d5 08 00 00       	mov    $0x8d5,%eax
 6a0:	85 db                	test   %ebx,%ebx
 6a2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 6a5:	0f b6 03             	movzbl (%ebx),%eax
 6a8:	84 c0                	test   %al,%al
 6aa:	74 23                	je     6cf <printf+0x14f>
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6b6:	83 ec 04             	sub    $0x4,%esp
 6b9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6bb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6be:	50                   	push   %eax
 6bf:	57                   	push   %edi
 6c0:	e8 3d fd ff ff       	call   402 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6c5:	0f b6 03             	movzbl (%ebx),%eax
 6c8:	83 c4 10             	add    $0x10,%esp
 6cb:	84 c0                	test   %al,%al
 6cd:	75 e1                	jne    6b0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 ff fe ff ff       	jmp    5d5 <printf+0x55>
 6d6:	8d 76 00             	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6e9:	6a 01                	push   $0x1
 6eb:	e9 4c ff ff ff       	jmp    63c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6f0:	83 ec 0c             	sub    $0xc,%esp
 6f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6f8:	6a 01                	push   $0x1
 6fa:	e9 6b ff ff ff       	jmp    66a <printf+0xea>
 6ff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 702:	83 ec 04             	sub    $0x4,%esp
 705:	8b 03                	mov    (%ebx),%eax
 707:	6a 01                	push   $0x1
 709:	88 45 e4             	mov    %al,-0x1c(%ebp)
 70c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 70f:	50                   	push   %eax
 710:	57                   	push   %edi
 711:	e8 ec fc ff ff       	call   402 <write>
 716:	e9 5b ff ff ff       	jmp    676 <printf+0xf6>
 71b:	66 90                	xchg   %ax,%ax
 71d:	66 90                	xchg   %ax,%ax
 71f:	90                   	nop

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 c8 0b 00 00       	mov    0xbc8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 730:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 733:	39 c8                	cmp    %ecx,%eax
 735:	73 19                	jae    750 <free+0x30>
 737:	89 f6                	mov    %esi,%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 740:	39 d1                	cmp    %edx,%ecx
 742:	72 1c                	jb     760 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	39 d0                	cmp    %edx,%eax
 746:	73 18                	jae    760 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 748:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74e:	72 f0                	jb     740 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 d0                	cmp    %edx,%eax
 752:	72 f4                	jb     748 <free+0x28>
 754:	39 d1                	cmp    %edx,%ecx
 756:	73 f0                	jae    748 <free+0x28>
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 760:	8b 73 fc             	mov    -0x4(%ebx),%esi
 763:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 766:	39 d7                	cmp    %edx,%edi
 768:	74 19                	je     783 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 76a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	74 23                	je     79a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 777:	89 08                	mov    %ecx,(%eax)
  freep = p;
 779:	a3 c8 0b 00 00       	mov    %eax,0xbc8
}
 77e:	5b                   	pop    %ebx
 77f:	5e                   	pop    %esi
 780:	5f                   	pop    %edi
 781:	5d                   	pop    %ebp
 782:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 783:	03 72 04             	add    0x4(%edx),%esi
 786:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 789:	8b 10                	mov    (%eax),%edx
 78b:	8b 12                	mov    (%edx),%edx
 78d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 790:	8b 50 04             	mov    0x4(%eax),%edx
 793:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 796:	39 f1                	cmp    %esi,%ecx
 798:	75 dd                	jne    777 <free+0x57>
    p->s.size += bp->s.size;
 79a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 79d:	a3 c8 0b 00 00       	mov    %eax,0xbc8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7a2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7a8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7aa:	5b                   	pop    %ebx
 7ab:	5e                   	pop    %esi
 7ac:	5f                   	pop    %edi
 7ad:	5d                   	pop    %ebp
 7ae:	c3                   	ret    
 7af:	90                   	nop

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 15 c8 0b 00 00    	mov    0xbc8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	8d 78 07             	lea    0x7(%eax),%edi
 7c5:	c1 ef 03             	shr    $0x3,%edi
 7c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7cb:	85 d2                	test   %edx,%edx
 7cd:	0f 84 a3 00 00 00    	je     876 <malloc+0xc6>
 7d3:	8b 02                	mov    (%edx),%eax
 7d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d8:	39 cf                	cmp    %ecx,%edi
 7da:	76 74                	jbe    850 <malloc+0xa0>
 7dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7e2:	be 00 10 00 00       	mov    $0x1000,%esi
 7e7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 7ee:	0f 43 f7             	cmovae %edi,%esi
 7f1:	ba 00 80 00 00       	mov    $0x8000,%edx
 7f6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7fc:	0f 46 da             	cmovbe %edx,%ebx
 7ff:	eb 10                	jmp    811 <malloc+0x61>
 801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 80a:	8b 48 04             	mov    0x4(%eax),%ecx
 80d:	39 cf                	cmp    %ecx,%edi
 80f:	76 3f                	jbe    850 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 811:	39 05 c8 0b 00 00    	cmp    %eax,0xbc8
 817:	89 c2                	mov    %eax,%edx
 819:	75 ed                	jne    808 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 81b:	83 ec 0c             	sub    $0xc,%esp
 81e:	53                   	push   %ebx
 81f:	e8 46 fc ff ff       	call   46a <sbrk>
  if(p == (char*)-1)
 824:	83 c4 10             	add    $0x10,%esp
 827:	83 f8 ff             	cmp    $0xffffffff,%eax
 82a:	74 1c                	je     848 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 82c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 82f:	83 ec 0c             	sub    $0xc,%esp
 832:	83 c0 08             	add    $0x8,%eax
 835:	50                   	push   %eax
 836:	e8 e5 fe ff ff       	call   720 <free>
  return freep;
 83b:	8b 15 c8 0b 00 00    	mov    0xbc8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 841:	83 c4 10             	add    $0x10,%esp
 844:	85 d2                	test   %edx,%edx
 846:	75 c0                	jne    808 <malloc+0x58>
        return 0;
 848:	31 c0                	xor    %eax,%eax
 84a:	eb 1c                	jmp    868 <malloc+0xb8>
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 850:	39 cf                	cmp    %ecx,%edi
 852:	74 1c                	je     870 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 854:	29 f9                	sub    %edi,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 85f:	89 15 c8 0b 00 00    	mov    %edx,0xbc8
      return (void*)(p + 1);
 865:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 868:	8d 65 f4             	lea    -0xc(%ebp),%esp
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb e9                	jmp    85f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 876:	c7 05 c8 0b 00 00 cc 	movl   $0xbcc,0xbc8
 87d:	0b 00 00 
 880:	c7 05 cc 0b 00 00 cc 	movl   $0xbcc,0xbcc
 887:	0b 00 00 
    base.s.size = 0;
 88a:	b8 cc 0b 00 00       	mov    $0xbcc,%eax
 88f:	c7 05 d0 0b 00 00 00 	movl   $0x0,0xbd0
 896:	00 00 00 
 899:	e9 3e ff ff ff       	jmp    7dc <malloc+0x2c>
