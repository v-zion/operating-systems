
_nlocks:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	cond_signal(1);
	release_mutex_spinlock(index);
}

int main()
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
	int ret[10];

	init_counters();

	for (int i = 0; i < 10; i++) {
  11:	31 db                	xor    %ebx,%ebx
	cond_signal(1);
	release_mutex_spinlock(index);
}

int main()
{
  13:	83 ec 38             	sub    $0x38,%esp
	int ret[10];

	init_counters();
  16:	e8 4f 04 00 00       	call   46a <init_counters>
  1b:	90                   	nop
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

	for (int i = 0; i < 10; i++) {
		ret[i] = fork();
  20:	e8 65 03 00 00       	call   38a <fork>
  25:	be e8 03 00 00       	mov    $0x3e8,%esi
  2a:	89 c7                	mov    %eax,%edi
  2c:	89 44 9d c0          	mov    %eax,-0x40(%ebp,%ebx,4)
		for(int j = 0; j < 1000; j++) {
			mutex_lock(i);
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	53                   	push   %ebx
  34:	e8 87 00 00 00       	call   c0 <mutex_lock>
			set_var(i, get_var(i)+1);
  39:	89 1c 24             	mov    %ebx,(%esp)
  3c:	e8 31 04 00 00       	call   472 <get_var>
  41:	5a                   	pop    %edx
  42:	59                   	pop    %ecx
  43:	83 c0 01             	add    $0x1,%eax
  46:	50                   	push   %eax
  47:	53                   	push   %ebx
  48:	e8 2d 04 00 00       	call   47a <set_var>
			mutex_unlock(i);
  4d:	89 1c 24             	mov    %ebx,(%esp)
  50:	e8 bb 00 00 00       	call   110 <mutex_unlock>

	init_counters();

	for (int i = 0; i < 10; i++) {
		ret[i] = fork();
		for(int j = 0; j < 1000; j++) {
  55:	83 c4 10             	add    $0x10,%esp
  58:	83 ee 01             	sub    $0x1,%esi
  5b:	75 d3                	jne    30 <main+0x30>
			mutex_lock(i);
			set_var(i, get_var(i)+1);
			mutex_unlock(i);
		}
		if (ret[i] == 0)
  5d:	85 ff                	test   %edi,%edi
  5f:	74 08                	je     69 <main+0x69>
{
	int ret[10];

	init_counters();

	for (int i = 0; i < 10; i++) {
  61:	83 c3 01             	add    $0x1,%ebx
  64:	83 fb 0a             	cmp    $0xa,%ebx
  67:	75 b7                	jne    20 <main+0x20>
  69:	8d 45 c0             	lea    -0x40(%ebp),%eax
  6c:	8d 55 e8             	lea    -0x18(%ebp),%edx
  6f:	90                   	nop
		if (ret[i] == 0)
			break;
	}

	for (int i = 0; i < 10; i++) {
		if (ret[i] == 0)
  70:	8b 08                	mov    (%eax),%ecx
  72:	85 c9                	test   %ecx,%ecx
  74:	74 43                	je     b9 <main+0xb9>
  76:	83 c0 04             	add    $0x4,%eax
		}
		if (ret[i] == 0)
			break;
	}

	for (int i = 0; i < 10; i++) {
  79:	39 c2                	cmp    %eax,%edx
  7b:	75 f3                	jne    70 <main+0x70>
  7d:	31 db                	xor    %ebx,%ebx
  7f:	90                   	nop
		if (ret[i] == 0)
			exit();
	}

	for (int i = 0; i < 10; i++){
		wait();
  80:	e8 15 03 00 00       	call   39a <wait>
		mutex_lock(i);
  85:	83 ec 0c             	sub    $0xc,%esp
  88:	53                   	push   %ebx
  89:	e8 32 00 00 00       	call   c0 <mutex_lock>
		int val = get_var(i);
  8e:	89 1c 24             	mov    %ebx,(%esp)
  91:	e8 dc 03 00 00       	call   472 <get_var>
  96:	89 c6                	mov    %eax,%esi
		mutex_unlock(i);
  98:	89 1c 24             	mov    %ebx,(%esp)
  9b:	e8 70 00 00 00       	call   110 <mutex_unlock>
		printf(1,"data[%d] = %d\n", i, val);
  a0:	56                   	push   %esi
  a1:	53                   	push   %ebx
	for (int i = 0; i < 10; i++) {
		if (ret[i] == 0)
			exit();
	}

	for (int i = 0; i < 10; i++){
  a2:	83 c3 01             	add    $0x1,%ebx
		wait();
		mutex_lock(i);
		int val = get_var(i);
		mutex_unlock(i);
		printf(1,"data[%d] = %d\n", i, val);
  a5:	68 50 08 00 00       	push   $0x850
  aa:	6a 01                	push   $0x1
  ac:	e8 7f 04 00 00       	call   530 <printf>
	for (int i = 0; i < 10; i++) {
		if (ret[i] == 0)
			exit();
	}

	for (int i = 0; i < 10; i++){
  b1:	83 c4 20             	add    $0x20,%esp
  b4:	83 fb 0a             	cmp    $0xa,%ebx
  b7:	75 c7                	jne    80 <main+0x80>
			break;
	}

	for (int i = 0; i < 10; i++) {
		if (ret[i] == 0)
			exit();
  b9:	e8 d4 02 00 00       	call   392 <exit>
  be:	66 90                	xchg   %ax,%ax

000000c0 <mutex_lock>:
#include "types.h"
#include "stat.h"
#include "user.h"

void mutex_lock(int index)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	83 ec 10             	sub    $0x10,%esp
  c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
  ca:	53                   	push   %ebx
  cb:	e8 62 03 00 00       	call   432 <acquire_mutex_spinlock>
	while(get_mutex_value(index))
  d0:	83 c4 10             	add    $0x10,%esp
  d3:	eb 11                	jmp    e6 <mutex_lock+0x26>
  d5:	8d 76 00             	lea    0x0(%esi),%esi
		cond_wait(1, index);
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	53                   	push   %ebx
  dc:	6a 01                	push   $0x1
  de:	e8 5f 03 00 00       	call   442 <cond_wait>
  e3:	83 c4 10             	add    $0x10,%esp
#include "user.h"

void mutex_lock(int index)
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	53                   	push   %ebx
  ea:	e8 63 03 00 00       	call   452 <get_mutex_value>
  ef:	83 c4 10             	add    $0x10,%esp
  f2:	85 c0                	test   %eax,%eax
  f4:	75 e2                	jne    d8 <mutex_lock+0x18>
		cond_wait(1, index);
	set_mutex_value(index, 1);
  f6:	83 ec 08             	sub    $0x8,%esp
  f9:	6a 01                	push   $0x1
  fb:	53                   	push   %ebx
  fc:	e8 59 03 00 00       	call   45a <set_mutex_value>
	release_mutex_spinlock(index);
 101:	89 5d 08             	mov    %ebx,0x8(%ebp)
 104:	83 c4 10             	add    $0x10,%esp
}
 107:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 10a:	c9                   	leave  
{
	acquire_mutex_spinlock(index);
	while(get_mutex_value(index))
		cond_wait(1, index);
	set_mutex_value(index, 1);
	release_mutex_spinlock(index);
 10b:	e9 2a 03 00 00       	jmp    43a <release_mutex_spinlock>

00000110 <mutex_unlock>:
}

void mutex_unlock(int index)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	83 ec 10             	sub    $0x10,%esp
 117:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire_mutex_spinlock(index);
 11a:	53                   	push   %ebx
 11b:	e8 12 03 00 00       	call   432 <acquire_mutex_spinlock>
	set_mutex_value(index, 0);
 120:	58                   	pop    %eax
 121:	5a                   	pop    %edx
 122:	6a 00                	push   $0x0
 124:	53                   	push   %ebx
 125:	e8 30 03 00 00       	call   45a <set_mutex_value>
	cond_signal(1);
 12a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 131:	e8 14 03 00 00       	call   44a <cond_signal>
	release_mutex_spinlock(index);
 136:	89 5d 08             	mov    %ebx,0x8(%ebp)
 139:	83 c4 10             	add    $0x10,%esp
}
 13c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13f:	c9                   	leave  
void mutex_unlock(int index)
{
	acquire_mutex_spinlock(index);
	set_mutex_value(index, 0);
	cond_signal(1);
	release_mutex_spinlock(index);
 140:	e9 f5 02 00 00       	jmp    43a <release_mutex_spinlock>
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 15a:	89 c2                	mov    %eax,%edx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	83 c1 01             	add    $0x1,%ecx
 163:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 167:	83 c2 01             	add    $0x1,%edx
 16a:	84 db                	test   %bl,%bl
 16c:	88 5a ff             	mov    %bl,-0x1(%edx)
 16f:	75 ef                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 171:	5b                   	pop    %ebx
 172:	5d                   	pop    %ebp
 173:	c3                   	ret    
 174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 17a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
 185:	8b 55 08             	mov    0x8(%ebp),%edx
 188:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 18b:	0f b6 02             	movzbl (%edx),%eax
 18e:	0f b6 19             	movzbl (%ecx),%ebx
 191:	84 c0                	test   %al,%al
 193:	75 1e                	jne    1b3 <strcmp+0x33>
 195:	eb 29                	jmp    1c0 <strcmp+0x40>
 197:	89 f6                	mov    %esi,%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1a0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1a6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1ad:	84 c0                	test   %al,%al
 1af:	74 0f                	je     1c0 <strcmp+0x40>
 1b1:	89 f1                	mov    %esi,%ecx
 1b3:	38 d8                	cmp    %bl,%al
 1b5:	74 e9                	je     1a0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1b7:	29 d8                	sub    %ebx,%eax
}
 1b9:	5b                   	pop    %ebx
 1ba:	5e                   	pop    %esi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1c2:	29 d8                	sub    %ebx,%eax
}
 1c4:	5b                   	pop    %ebx
 1c5:	5e                   	pop    %esi
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <strlen>:

uint
strlen(char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 39 00             	cmpb   $0x0,(%ecx)
 1d9:	74 12                	je     1ed <strlen+0x1d>
 1db:	31 d2                	xor    %edx,%edx
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	83 c2 01             	add    $0x1,%edx
 1e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1e7:	89 d0                	mov    %edx,%eax
 1e9:	75 f5                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1ed:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	eb 0d                	jmp    200 <memset>
 1f3:	90                   	nop
 1f4:	90                   	nop
 1f5:	90                   	nop
 1f6:	90                   	nop
 1f7:	90                   	nop
 1f8:	90                   	nop
 1f9:	90                   	nop
 1fa:	90                   	nop
 1fb:	90                   	nop
 1fc:	90                   	nop
 1fd:	90                   	nop
 1fe:	90                   	nop
 1ff:	90                   	nop

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	89 d0                	mov    %edx,%eax
 214:	5f                   	pop    %edi
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	74 1d                	je     24e <strchr+0x2e>
    if(*s == c)
 231:	38 d3                	cmp    %dl,%bl
 233:	89 d9                	mov    %ebx,%ecx
 235:	75 0d                	jne    244 <strchr+0x24>
 237:	eb 17                	jmp    250 <strchr+0x30>
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 240:	38 ca                	cmp    %cl,%dl
 242:	74 0c                	je     250 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 244:	83 c0 01             	add    $0x1,%eax
 247:	0f b6 10             	movzbl (%eax),%edx
 24a:	84 d2                	test   %dl,%dl
 24c:	75 f2                	jne    240 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 24e:	31 c0                	xor    %eax,%eax
}
 250:	5b                   	pop    %ebx
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    
 253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
 265:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 266:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 268:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 26b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26e:	eb 29                	jmp    299 <gets+0x39>
    cc = read(0, &c, 1);
 270:	83 ec 04             	sub    $0x4,%esp
 273:	6a 01                	push   $0x1
 275:	57                   	push   %edi
 276:	6a 00                	push   $0x0
 278:	e8 2d 01 00 00       	call   3aa <read>
    if(cc < 1)
 27d:	83 c4 10             	add    $0x10,%esp
 280:	85 c0                	test   %eax,%eax
 282:	7e 1d                	jle    2a1 <gets+0x41>
      break;
    buf[i++] = c;
 284:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 288:	8b 55 08             	mov    0x8(%ebp),%edx
 28b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 28d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 28f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 293:	74 1b                	je     2b0 <gets+0x50>
 295:	3c 0d                	cmp    $0xd,%al
 297:	74 17                	je     2b0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 299:	8d 5e 01             	lea    0x1(%esi),%ebx
 29c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 29f:	7c cf                	jl     270 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ab:	5b                   	pop    %ebx
 2ac:	5e                   	pop    %esi
 2ad:	5f                   	pop    %edi
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bc:	5b                   	pop    %ebx
 2bd:	5e                   	pop    %esi
 2be:	5f                   	pop    %edi
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret    
 2c1:	eb 0d                	jmp    2d0 <stat>
 2c3:	90                   	nop
 2c4:	90                   	nop
 2c5:	90                   	nop
 2c6:	90                   	nop
 2c7:	90                   	nop
 2c8:	90                   	nop
 2c9:	90                   	nop
 2ca:	90                   	nop
 2cb:	90                   	nop
 2cc:	90                   	nop
 2cd:	90                   	nop
 2ce:	90                   	nop
 2cf:	90                   	nop

000002d0 <stat>:

int
stat(char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 f0 00 00 00       	call   3d2 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f3 00 00 00       	call   3ea <fstat>
 2f7:	89 c6                	mov    %eax,%esi
  close(fd);
 2f9:	89 1c 24             	mov    %ebx,(%esp)
 2fc:	e8 b9 00 00 00       	call   3ba <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
 304:	89 f0                	mov    %esi,%eax
}
 306:	8d 65 f8             	lea    -0x8(%ebp),%esp
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 315:	eb ef                	jmp    306 <stat+0x36>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 382:	39 da                	cmp    %ebx,%edx
 384:	75 f2                	jne    378 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <acquire_mutex_spinlock>:

SYSCALL(acquire_mutex_spinlock)
 432:	b8 16 00 00 00       	mov    $0x16,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <release_mutex_spinlock>:
SYSCALL(release_mutex_spinlock)
 43a:	b8 17 00 00 00       	mov    $0x17,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <cond_wait>:
SYSCALL(cond_wait)
 442:	b8 18 00 00 00       	mov    $0x18,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <cond_signal>:
SYSCALL(cond_signal)
 44a:	b8 19 00 00 00       	mov    $0x19,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <get_mutex_value>:
SYSCALL(get_mutex_value)
 452:	b8 1a 00 00 00       	mov    $0x1a,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <set_mutex_value>:
SYSCALL(set_mutex_value)
 45a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <init_mutex>:
SYSCALL(init_mutex)
 462:	b8 1c 00 00 00       	mov    $0x1c,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <init_counters>:
SYSCALL(init_counters)
 46a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <get_var>:
SYSCALL(get_var)
 472:	b8 1e 00 00 00       	mov    $0x1e,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <set_var>:
SYSCALL(set_var)
 47a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    
 482:	66 90                	xchg   %ax,%ax
 484:	66 90                	xchg   %ax,%ax
 486:	66 90                	xchg   %ax,%ax
 488:	66 90                	xchg   %ax,%ax
 48a:	66 90                	xchg   %ax,%ax
 48c:	66 90                	xchg   %ax,%ax
 48e:	66 90                	xchg   %ax,%ax

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 c6                	mov    %eax,%esi
 498:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 49b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 49e:	85 db                	test   %ebx,%ebx
 4a0:	74 7e                	je     520 <printint+0x90>
 4a2:	89 d0                	mov    %edx,%eax
 4a4:	c1 e8 1f             	shr    $0x1f,%eax
 4a7:	84 c0                	test   %al,%al
 4a9:	74 75                	je     520 <printint+0x90>
    neg = 1;
    x = -xx;
 4ab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4ad:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 4b4:	f7 d8                	neg    %eax
 4b6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4b9:	31 ff                	xor    %edi,%edi
 4bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4be:	89 ce                	mov    %ecx,%esi
 4c0:	eb 08                	jmp    4ca <printint+0x3a>
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c8:	89 cf                	mov    %ecx,%edi
 4ca:	31 d2                	xor    %edx,%edx
 4cc:	8d 4f 01             	lea    0x1(%edi),%ecx
 4cf:	f7 f6                	div    %esi
 4d1:	0f b6 92 68 08 00 00 	movzbl 0x868(%edx),%edx
  }while((x /= base) != 0);
 4d8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4da:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4dd:	75 e9                	jne    4c8 <printint+0x38>
  if(neg)
 4df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4e2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4e5:	85 c0                	test   %eax,%eax
 4e7:	74 08                	je     4f1 <printint+0x61>
    buf[i++] = '-';
 4e9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 4ee:	8d 4f 02             	lea    0x2(%edi),%ecx
 4f1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
 4f8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	83 ef 01             	sub    $0x1,%edi
 501:	6a 01                	push   $0x1
 503:	53                   	push   %ebx
 504:	56                   	push   %esi
 505:	88 45 d7             	mov    %al,-0x29(%ebp)
 508:	e8 a5 fe ff ff       	call   3b2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 50d:	83 c4 10             	add    $0x10,%esp
 510:	39 df                	cmp    %ebx,%edi
 512:	75 e4                	jne    4f8 <printint+0x68>
    putc(fd, buf[i]);
}
 514:	8d 65 f4             	lea    -0xc(%ebp),%esp
 517:	5b                   	pop    %ebx
 518:	5e                   	pop    %esi
 519:	5f                   	pop    %edi
 51a:	5d                   	pop    %ebp
 51b:	c3                   	ret    
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 520:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 522:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 529:	eb 8b                	jmp    4b6 <printint+0x26>
 52b:	90                   	nop
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 536:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 539:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 53c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 53f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 542:	89 45 d0             	mov    %eax,-0x30(%ebp)
 545:	0f b6 1e             	movzbl (%esi),%ebx
 548:	83 c6 01             	add    $0x1,%esi
 54b:	84 db                	test   %bl,%bl
 54d:	0f 84 b0 00 00 00    	je     603 <printf+0xd3>
 553:	31 d2                	xor    %edx,%edx
 555:	eb 39                	jmp    590 <printf+0x60>
 557:	89 f6                	mov    %esi,%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 560:	83 f8 25             	cmp    $0x25,%eax
 563:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 566:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 56b:	74 18                	je     585 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 570:	83 ec 04             	sub    $0x4,%esp
 573:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 576:	6a 01                	push   $0x1
 578:	50                   	push   %eax
 579:	57                   	push   %edi
 57a:	e8 33 fe ff ff       	call   3b2 <write>
 57f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 582:	83 c4 10             	add    $0x10,%esp
 585:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 588:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 58c:	84 db                	test   %bl,%bl
 58e:	74 73                	je     603 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 590:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 592:	0f be cb             	movsbl %bl,%ecx
 595:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 598:	74 c6                	je     560 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 59a:	83 fa 25             	cmp    $0x25,%edx
 59d:	75 e6                	jne    585 <printf+0x55>
      if(c == 'd'){
 59f:	83 f8 64             	cmp    $0x64,%eax
 5a2:	0f 84 f8 00 00 00    	je     6a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5a8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5ae:	83 f9 70             	cmp    $0x70,%ecx
 5b1:	74 5d                	je     610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5b3:	83 f8 73             	cmp    $0x73,%eax
 5b6:	0f 84 84 00 00 00    	je     640 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bc:	83 f8 63             	cmp    $0x63,%eax
 5bf:	0f 84 ea 00 00 00    	je     6af <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5c5:	83 f8 25             	cmp    $0x25,%eax
 5c8:	0f 84 c2 00 00 00    	je     690 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5d1:	83 ec 04             	sub    $0x4,%esp
 5d4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5d8:	6a 01                	push   $0x1
 5da:	50                   	push   %eax
 5db:	57                   	push   %edi
 5dc:	e8 d1 fd ff ff       	call   3b2 <write>
 5e1:	83 c4 0c             	add    $0xc,%esp
 5e4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5e7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5ea:	6a 01                	push   $0x1
 5ec:	50                   	push   %eax
 5ed:	57                   	push   %edi
 5ee:	83 c6 01             	add    $0x1,%esi
 5f1:	e8 bc fd ff ff       	call   3b2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5fd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ff:	84 db                	test   %bl,%bl
 601:	75 8d                	jne    590 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 603:	8d 65 f4             	lea    -0xc(%ebp),%esp
 606:	5b                   	pop    %ebx
 607:	5e                   	pop    %esi
 608:	5f                   	pop    %edi
 609:	5d                   	pop    %ebp
 60a:	c3                   	ret    
 60b:	90                   	nop
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 10 00 00 00       	mov    $0x10,%ecx
 618:	6a 00                	push   $0x0
 61a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 61d:	89 f8                	mov    %edi,%eax
 61f:	8b 13                	mov    (%ebx),%edx
 621:	e8 6a fe ff ff       	call   490 <printint>
        ap++;
 626:	89 d8                	mov    %ebx,%eax
 628:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 62d:	83 c0 04             	add    $0x4,%eax
 630:	89 45 d0             	mov    %eax,-0x30(%ebp)
 633:	e9 4d ff ff ff       	jmp    585 <printf+0x55>
 638:	90                   	nop
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 640:	8b 45 d0             	mov    -0x30(%ebp),%eax
 643:	8b 18                	mov    (%eax),%ebx
        ap++;
 645:	83 c0 04             	add    $0x4,%eax
 648:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 64b:	b8 5f 08 00 00       	mov    $0x85f,%eax
 650:	85 db                	test   %ebx,%ebx
 652:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 655:	0f b6 03             	movzbl (%ebx),%eax
 658:	84 c0                	test   %al,%al
 65a:	74 23                	je     67f <printf+0x14f>
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 660:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 663:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 666:	83 ec 04             	sub    $0x4,%esp
 669:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 66b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66e:	50                   	push   %eax
 66f:	57                   	push   %edi
 670:	e8 3d fd ff ff       	call   3b2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 675:	0f b6 03             	movzbl (%ebx),%eax
 678:	83 c4 10             	add    $0x10,%esp
 67b:	84 c0                	test   %al,%al
 67d:	75 e1                	jne    660 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 ff fe ff ff       	jmp    585 <printf+0x55>
 686:	8d 76 00             	lea    0x0(%esi),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
 693:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 696:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 699:	6a 01                	push   $0x1
 69b:	e9 4c ff ff ff       	jmp    5ec <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6a0:	83 ec 0c             	sub    $0xc,%esp
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6a8:	6a 01                	push   $0x1
 6aa:	e9 6b ff ff ff       	jmp    61a <printf+0xea>
 6af:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b2:	83 ec 04             	sub    $0x4,%esp
 6b5:	8b 03                	mov    (%ebx),%eax
 6b7:	6a 01                	push   $0x1
 6b9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 6bc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6bf:	50                   	push   %eax
 6c0:	57                   	push   %edi
 6c1:	e8 ec fc ff ff       	call   3b2 <write>
 6c6:	e9 5b ff ff ff       	jmp    626 <printf+0xf6>
 6cb:	66 90                	xchg   %ax,%ax
 6cd:	66 90                	xchg   %ax,%ax
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 54 0b 00 00       	mov    0xb54,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e3:	39 c8                	cmp    %ecx,%eax
 6e5:	73 19                	jae    700 <free+0x30>
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 6f0:	39 d1                	cmp    %edx,%ecx
 6f2:	72 1c                	jb     710 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	39 d0                	cmp    %edx,%eax
 6f6:	73 18                	jae    710 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fe:	72 f0                	jb     6f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 700:	39 d0                	cmp    %edx,%eax
 702:	72 f4                	jb     6f8 <free+0x28>
 704:	39 d1                	cmp    %edx,%ecx
 706:	73 f0                	jae    6f8 <free+0x28>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 716:	39 d7                	cmp    %edx,%edi
 718:	74 19                	je     733 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 71a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 71d:	8b 50 04             	mov    0x4(%eax),%edx
 720:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 723:	39 f1                	cmp    %esi,%ecx
 725:	74 23                	je     74a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 727:	89 08                	mov    %ecx,(%eax)
  freep = p;
 729:	a3 54 0b 00 00       	mov    %eax,0xb54
}
 72e:	5b                   	pop    %ebx
 72f:	5e                   	pop    %esi
 730:	5f                   	pop    %edi
 731:	5d                   	pop    %ebp
 732:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 733:	03 72 04             	add    0x4(%edx),%esi
 736:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 739:	8b 10                	mov    (%eax),%edx
 73b:	8b 12                	mov    (%edx),%edx
 73d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 740:	8b 50 04             	mov    0x4(%eax),%edx
 743:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 746:	39 f1                	cmp    %esi,%ecx
 748:	75 dd                	jne    727 <free+0x57>
    p->s.size += bp->s.size;
 74a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 74d:	a3 54 0b 00 00       	mov    %eax,0xb54
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 752:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 755:	8b 53 f8             	mov    -0x8(%ebx),%edx
 758:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 75a:	5b                   	pop    %ebx
 75b:	5e                   	pop    %esi
 75c:	5f                   	pop    %edi
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    
 75f:	90                   	nop

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 54 0b 00 00    	mov    0xb54,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 a3 00 00 00    	je     826 <malloc+0xc6>
 783:	8b 02                	mov    (%edx),%eax
 785:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 788:	39 cf                	cmp    %ecx,%edi
 78a:	76 74                	jbe    800 <malloc+0xa0>
 78c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 792:	be 00 10 00 00       	mov    $0x1000,%esi
 797:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 79e:	0f 43 f7             	cmovae %edi,%esi
 7a1:	ba 00 80 00 00       	mov    $0x8000,%edx
 7a6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7ac:	0f 46 da             	cmovbe %edx,%ebx
 7af:	eb 10                	jmp    7c1 <malloc+0x61>
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ba:	8b 48 04             	mov    0x4(%eax),%ecx
 7bd:	39 cf                	cmp    %ecx,%edi
 7bf:	76 3f                	jbe    800 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c1:	39 05 54 0b 00 00    	cmp    %eax,0xb54
 7c7:	89 c2                	mov    %eax,%edx
 7c9:	75 ed                	jne    7b8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	53                   	push   %ebx
 7cf:	e8 46 fc ff ff       	call   41a <sbrk>
  if(p == (char*)-1)
 7d4:	83 c4 10             	add    $0x10,%esp
 7d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7da:	74 1c                	je     7f8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7dc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7df:	83 ec 0c             	sub    $0xc,%esp
 7e2:	83 c0 08             	add    $0x8,%eax
 7e5:	50                   	push   %eax
 7e6:	e8 e5 fe ff ff       	call   6d0 <free>
  return freep;
 7eb:	8b 15 54 0b 00 00    	mov    0xb54,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7f1:	83 c4 10             	add    $0x10,%esp
 7f4:	85 d2                	test   %edx,%edx
 7f6:	75 c0                	jne    7b8 <malloc+0x58>
        return 0;
 7f8:	31 c0                	xor    %eax,%eax
 7fa:	eb 1c                	jmp    818 <malloc+0xb8>
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 800:	39 cf                	cmp    %ecx,%edi
 802:	74 1c                	je     820 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 804:	29 f9                	sub    %edi,%ecx
 806:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 809:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 80c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 80f:	89 15 54 0b 00 00    	mov    %edx,0xb54
      return (void*)(p + 1);
 815:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 818:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81b:	5b                   	pop    %ebx
 81c:	5e                   	pop    %esi
 81d:	5f                   	pop    %edi
 81e:	5d                   	pop    %ebp
 81f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb e9                	jmp    80f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 826:	c7 05 54 0b 00 00 58 	movl   $0xb58,0xb54
 82d:	0b 00 00 
 830:	c7 05 58 0b 00 00 58 	movl   $0xb58,0xb58
 837:	0b 00 00 
    base.s.size = 0;
 83a:	b8 58 0b 00 00       	mov    $0xb58,%eax
 83f:	c7 05 5c 0b 00 00 00 	movl   $0x0,0xb5c
 846:	00 00 00 
 849:	e9 3e ff ff ff       	jmp    78c <malloc+0x2c>
