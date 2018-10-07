
_prodcon:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
		release_mutex_spinlock(0);
	}
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
  11:	81 ec e8 00 00 00    	sub    $0xe8,%esp
	int  pid;
	int count;
	int sleep_times[40];
	char action[40];

	if(argc < 3)
  17:	83 39 02             	cmpl   $0x2,(%ecx)
		release_mutex_spinlock(0);
	}
}

int main(int argc, char *argv[])
{
  1a:	8b 59 04             	mov    0x4(%ecx),%ebx
	int  pid;
	int count;
	int sleep_times[40];
	char action[40];

	if(argc < 3)
  1d:	7f 13                	jg     32 <main+0x32>
	{
		printf(1, "./prodcon <input1.txt> <input2.txt> \n");
  1f:	51                   	push   %ecx
  20:	51                   	push   %ecx
  21:	68 18 0b 00 00       	push   $0xb18
  26:	6a 01                	push   $0x1
  28:	e8 63 07 00 00       	call   790 <printf>
		exit();    
  2d:	e8 c0 05 00 00       	call   5f2 <exit>
	}

	init_mutex();
  32:	e8 8b 06 00 00       	call   6c2 <init_mutex>
	pid = fork();
  37:	e8 ae 05 00 00       	call   5ea <fork>

	if(pid == 0)
  3c:	85 c0                	test   %eax,%eax
		printf(1, "./prodcon <input1.txt> <input2.txt> \n");
		exit();    
	}

	init_mutex();
	pid = fork();
  3e:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)

	if(pid == 0)
  44:	75 56                	jne    9c <main+0x9c>
	{
		count = read_inputfile(argv[1], action, sleep_times);
  46:	8d b5 48 ff ff ff    	lea    -0xb8(%ebp),%esi
  4c:	8d bd 20 ff ff ff    	lea    -0xe0(%ebp),%edi
  52:	52                   	push   %edx
  53:	56                   	push   %esi
  54:	57                   	push   %edi
  55:	ff 73 04             	pushl  0x4(%ebx)
  58:	e8 93 00 00 00       	call   f0 <read_inputfile>
	{
		count = read_inputfile(argv[2], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  5d:	83 c4 10             	add    $0x10,%esp
  60:	85 c0                	test   %eax,%eax
	init_mutex();
	pid = fork();

	if(pid == 0)
	{
		count = read_inputfile(argv[1], action, sleep_times);
  62:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
	{
		count = read_inputfile(argv[2], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  68:	7e 5b                	jle    c5 <main+0xc5>
		release_mutex_spinlock(0);
	}
}

int main(int argc, char *argv[])
{
  6a:	31 db                	xor    %ebx,%ebx
  6c:	eb 1f                	jmp    8d <main+0x8d>
  6e:	66 90                	xchg   %ax,%ax

	for(int i=0; i < count; i++)
	{
		if(action[i] == 'P')
			produce();
		else if(action[i] == 'C')
  70:	3c 43                	cmp    $0x43,%al
  72:	74 5c                	je     d0 <main+0xd0>
			consume();

		sleep(sleep_times[i]);
  74:	83 ec 0c             	sub    $0xc,%esp
  77:	ff 34 9e             	pushl  (%esi,%ebx,4)
	{
		count = read_inputfile(argv[2], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  7a:	83 c3 01             	add    $0x1,%ebx
		if(action[i] == 'P')
			produce();
		else if(action[i] == 'C')
			consume();

		sleep(sleep_times[i]);
  7d:	e8 00 06 00 00       	call   682 <sleep>
	{
		count = read_inputfile(argv[2], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  82:	83 c4 10             	add    $0x10,%esp
  85:	3b 9d 14 ff ff ff    	cmp    -0xec(%ebp),%ebx
  8b:	7d 4a                	jge    d7 <main+0xd7>
	{
		if(action[i] == 'P')
  8d:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
  91:	3c 50                	cmp    $0x50,%al
  93:	75 db                	jne    70 <main+0x70>
			produce();
  95:	e8 96 01 00 00       	call   230 <produce>
  9a:	eb d8                	jmp    74 <main+0x74>
		count = read_inputfile(argv[1], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}
	else
	{
		count = read_inputfile(argv[2], action, sleep_times);
  9c:	8d b5 48 ff ff ff    	lea    -0xb8(%ebp),%esi
  a2:	8d bd 20 ff ff ff    	lea    -0xe0(%ebp),%edi
  a8:	50                   	push   %eax
  a9:	56                   	push   %esi
  aa:	57                   	push   %edi
  ab:	ff 73 08             	pushl  0x8(%ebx)
  ae:	e8 3d 00 00 00       	call   f0 <read_inputfile>
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  b3:	83 c4 10             	add    $0x10,%esp
  b6:	85 c0                	test   %eax,%eax
		count = read_inputfile(argv[1], action, sleep_times);
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}
	else
	{
		count = read_inputfile(argv[2], action, sleep_times);
  b8:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
		// printf(1, "[%d]: Number of operation: %d \n", getpid(), count);
	}

	for(int i=0; i < count; i++)
  be:	7f aa                	jg     6a <main+0x6a>
	}

	if(pid == 0)
		exit();

	wait();
  c0:	e8 35 05 00 00       	call   5fa <wait>
	exit();
  c5:	e8 28 05 00 00       	call   5f2 <exit>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	for(int i=0; i < count; i++)
	{
		if(action[i] == 'P')
			produce();
		else if(action[i] == 'C')
			consume();
  d0:	e8 1b 02 00 00       	call   2f0 <consume>
  d5:	eb 9d                	jmp    74 <main+0x74>

		sleep(sleep_times[i]);
	}

	if(pid == 0)
  d7:	83 bd 10 ff ff ff 00 	cmpl   $0x0,-0xf0(%ebp)
  de:	74 e5                	je     c5 <main+0xc5>
  e0:	eb de                	jmp    c0 <main+0xc0>
  e2:	66 90                	xchg   %ax,%ax
  e4:	66 90                	xchg   %ax,%ax
  e6:	66 90                	xchg   %ax,%ax
  e8:	66 90                	xchg   %ax,%ax
  ea:	66 90                	xchg   %ax,%ax
  ec:	66 90                	xchg   %ax,%ax
  ee:	66 90                	xchg   %ax,%ax

000000f0 <read_inputfile>:
#include "user.h"

int MAX_LIMIT = 10;

int read_inputfile(char *filename, char *actions, int *sleeptimes)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	56                   	push   %esi
  f5:	53                   	push   %ebx
  f6:	81 ec 1c 04 00 00    	sub    $0x41c,%esp
	int fd;
	int bufferSize = 1024;
	int bytesRead;
	char buffer[bufferSize];
  fc:	89 e6                	mov    %esp,%esi

	fd = open(filename, 0);
  fe:	83 ec 08             	sub    $0x8,%esp
 101:	6a 00                	push   $0x0
 103:	ff 75 08             	pushl  0x8(%ebp)
 106:	e8 27 05 00 00       	call   632 <open>
	bytesRead = read(fd, buffer, bufferSize);
 10b:	83 c4 0c             	add    $0xc,%esp
 10e:	68 00 04 00 00       	push   $0x400
 113:	56                   	push   %esi
 114:	50                   	push   %eax
 115:	e8 f0 04 00 00       	call   60a <read>

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 11a:	83 c4 10             	add    $0x10,%esp
 11d:	85 c0                	test   %eax,%eax
	int bufferSize = 1024;
	int bytesRead;
	char buffer[bufferSize];

	fd = open(filename, 0);
	bytesRead = read(fd, buffer, bufferSize);
 11f:	89 c7                	mov    %eax,%edi
 121:	89 45 e0             	mov    %eax,-0x20(%ebp)

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 124:	b8 00 00 00 00       	mov    $0x0,%eax
 129:	0f 8e dc 00 00 00    	jle    20b <read_inputfile+0x11b>
 12f:	31 d2                	xor    %edx,%edx
	{
		if (buffer[i] == '\n')
		{
			line_count++;
		}
		else if (i == bytesRead - 1)
 131:	8d 4f ff             	lea    -0x1(%edi),%ecx
 134:	eb 1a                	jmp    150 <read_inputfile+0x60>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		{
			line_count++;
 140:	31 db                	xor    %ebx,%ebx
 142:	39 c1                	cmp    %eax,%ecx
 144:	0f 94 c3             	sete   %bl
	fd = open(filename, 0);
	bytesRead = read(fd, buffer, bufferSize);

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 147:	83 c0 01             	add    $0x1,%eax
		{
			line_count++;
		}
		else if (i == bytesRead - 1)
		{
			line_count++;
 14a:	01 da                	add    %ebx,%edx
	fd = open(filename, 0);
	bytesRead = read(fd, buffer, bufferSize);

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 14c:	39 c7                	cmp    %eax,%edi
 14e:	74 10                	je     160 <read_inputfile+0x70>
	{
		if (buffer[i] == '\n')
 150:	80 3c 06 0a          	cmpb   $0xa,(%esi,%eax,1)
 154:	75 ea                	jne    140 <read_inputfile+0x50>
	fd = open(filename, 0);
	bytesRead = read(fd, buffer, bufferSize);

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 156:	83 c0 01             	add    $0x1,%eax
	{
		if (buffer[i] == '\n')
		{
			line_count++;
 159:	83 c2 01             	add    $0x1,%edx
	fd = open(filename, 0);
	bytesRead = read(fd, buffer, bufferSize);

	// find number of lines
	int line_count = 0;
	for (int i = 0; i < bytesRead; i++)
 15c:	39 c7                	cmp    %eax,%edi
 15e:	75 f0                	jne    150 <read_inputfile+0x60>

	int index = 0;
	int prev = 0;
	for (int i = 0; i < bytesRead; i++)
	{
		if (buffer[i] == '\n' || (buffer[i] != '\n' && i == bytesRead - 1))
 160:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 163:	89 55 d8             	mov    %edx,-0x28(%ebp)
 166:	bf 01 00 00 00       	mov    $0x1,%edi
 16b:	31 c0                	xor    %eax,%eax
 16d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 174:	83 eb 01             	sub    $0x1,%ebx
 177:	89 5d dc             	mov    %ebx,-0x24(%ebp)
 17a:	eb 16                	jmp    192 <read_inputfile+0xa2>
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	8d 57 ff             	lea    -0x1(%edi),%edx
 183:	39 55 dc             	cmp    %edx,-0x24(%ebp)
 186:	74 11                	je     199 <read_inputfile+0xa9>
				temp += buffer[prev] - '0';
				prev++;
			}
			sleeptimes[index] = temp;
			index++;
			prev = i + 1;
 188:	89 fa                	mov    %edi,%edx
 18a:	83 c7 01             	add    $0x1,%edi
		}
	}

	int index = 0;
	int prev = 0;
	for (int i = 0; i < bytesRead; i++)
 18d:	39 55 e0             	cmp    %edx,-0x20(%ebp)
 190:	7e 76                	jle    208 <read_inputfile+0x118>
	{
		if (buffer[i] == '\n' || (buffer[i] != '\n' && i == bytesRead - 1))
 192:	80 7c 3e ff 0a       	cmpb   $0xa,-0x1(%esi,%edi,1)
 197:	75 e7                	jne    180 <read_inputfile+0x90>
		{
			if (buffer[prev] == 'P' || buffer[prev] == 'C')
 199:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 19d:	80 fa 50             	cmp    $0x50,%dl
 1a0:	74 05                	je     1a7 <read_inputfile+0xb7>
 1a2:	80 fa 43             	cmp    $0x43,%dl
 1a5:	75 6c                	jne    213 <read_inputfile+0x123>
			{
				actions[index] = buffer[prev];
 1a7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 1aa:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ad:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
			else
			{
				printf(1, "incorrect format of input file [No extra newlines]\n");
				return 0;
			}
			prev++;
 1b0:	8d 50 01             	lea    0x1(%eax),%edx
			while (buffer[prev] > '9' || buffer[prev] < '0')
 1b3:	0f be 44 06 01       	movsbl 0x1(%esi,%eax,1),%eax
 1b8:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1bb:	80 f9 09             	cmp    $0x9,%cl
 1be:	76 0f                	jbe    1cf <read_inputfile+0xdf>
				prev++;
 1c0:	83 c2 01             	add    $0x1,%edx
			{
				printf(1, "incorrect format of input file [No extra newlines]\n");
				return 0;
			}
			prev++;
			while (buffer[prev] > '9' || buffer[prev] < '0')
 1c3:	0f be 04 16          	movsbl (%esi,%edx,1),%eax
 1c7:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1ca:	80 f9 09             	cmp    $0x9,%cl
 1cd:	77 f1                	ja     1c0 <read_inputfile+0xd0>
 1cf:	01 f2                	add    %esi,%edx
 1d1:	31 c9                	xor    %ecx,%ecx
 1d3:	90                   	nop
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				prev++;
			int temp = 0;
			while (buffer[prev] <= '9' && buffer[prev] >= '0')
			{
				temp *= 10;
 1d8:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 1db:	83 c2 01             	add    $0x1,%edx
				temp += buffer[prev] - '0';
 1de:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
			}
			prev++;
			while (buffer[prev] > '9' || buffer[prev] < '0')
				prev++;
			int temp = 0;
			while (buffer[prev] <= '9' && buffer[prev] >= '0')
 1e2:	0f be 02             	movsbl (%edx),%eax
 1e5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1e8:	80 fb 09             	cmp    $0x9,%bl
 1eb:	76 eb                	jbe    1d8 <read_inputfile+0xe8>
			{
				temp *= 10;
				temp += buffer[prev] - '0';
				prev++;
			}
			sleeptimes[index] = temp;
 1ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1f0:	8b 5d 10             	mov    0x10(%ebp),%ebx
			index++;
			prev = i + 1;
 1f3:	89 fa                	mov    %edi,%edx
			{
				temp *= 10;
				temp += buffer[prev] - '0';
				prev++;
			}
			sleeptimes[index] = temp;
 1f5:	89 0c 83             	mov    %ecx,(%ebx,%eax,4)
			index++;
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			prev = i + 1;
 1fe:	89 f8                	mov    %edi,%eax
 200:	83 c7 01             	add    $0x1,%edi
		}
	}

	int index = 0;
	int prev = 0;
	for (int i = 0; i < bytesRead; i++)
 203:	39 55 e0             	cmp    %edx,-0x20(%ebp)
 206:	7f 8a                	jg     192 <read_inputfile+0xa2>
 208:	8b 45 d8             	mov    -0x28(%ebp),%eax
			index++;
			prev = i + 1;
		}
	}
	return line_count;
}
 20b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 20e:	5b                   	pop    %ebx
 20f:	5e                   	pop    %esi
 210:	5f                   	pop    %edi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
			{
				actions[index] = buffer[prev];
			}
			else
			{
				printf(1, "incorrect format of input file [No extra newlines]\n");
 213:	83 ec 08             	sub    $0x8,%esp
 216:	68 b0 0a 00 00       	push   $0xab0
 21b:	6a 01                	push   $0x1
 21d:	e8 6e 05 00 00       	call   790 <printf>
				return 0;
 222:	83 c4 10             	add    $0x10,%esp
			index++;
			prev = i + 1;
		}
	}
	return line_count;
}
 225:	8d 65 f4             	lea    -0xc(%ebp),%esp
				actions[index] = buffer[prev];
			}
			else
			{
				printf(1, "incorrect format of input file [No extra newlines]\n");
				return 0;
 228:	31 c0                	xor    %eax,%eax
			index++;
			prev = i + 1;
		}
	}
	return line_count;
}
 22a:	5b                   	pop    %ebx
 22b:	5e                   	pop    %esi
 22c:	5f                   	pop    %edi
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop

00000230 <produce>:

void produce(void)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	83 ec 10             	sub    $0x10,%esp
	acquire_mutex_spinlock(0);
 237:	6a 00                	push   $0x0
 239:	e8 54 04 00 00       	call   692 <acquire_mutex_spinlock>
	while (get_mutex_value(0) == MAX_LIMIT)
 23e:	83 c4 10             	add    $0x10,%esp
 241:	eb 14                	jmp    257 <produce+0x27>
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		cond_wait(1, 0);
 248:	83 ec 08             	sub    $0x8,%esp
 24b:	6a 00                	push   $0x0
 24d:	6a 01                	push   $0x1
 24f:	e8 4e 04 00 00       	call   6a2 <cond_wait>
 254:	83 c4 10             	add    $0x10,%esp
}

void produce(void)
{
	acquire_mutex_spinlock(0);
	while (get_mutex_value(0) == MAX_LIMIT)
 257:	83 ec 0c             	sub    $0xc,%esp
 25a:	6a 00                	push   $0x0
 25c:	e8 51 04 00 00       	call   6b2 <get_mutex_value>
 261:	83 c4 10             	add    $0x10,%esp
 264:	3b 05 88 0e 00 00    	cmp    0xe88,%eax
 26a:	74 dc                	je     248 <produce+0x18>
		cond_wait(1, 0);

	if (get_mutex_value(0) < 10 && get_mutex_value(0) >= 0) {
 26c:	83 ec 0c             	sub    $0xc,%esp
 26f:	6a 00                	push   $0x0
 271:	e8 3c 04 00 00       	call   6b2 <get_mutex_value>
 276:	83 c4 10             	add    $0x10,%esp
 279:	83 f8 09             	cmp    $0x9,%eax
 27c:	7e 0a                	jle    288 <produce+0x58>
		set_mutex_value(0, get_mutex_value(0) + 1);
		printf(1, "[%d]: Produced an item. Curernt buffer size: %d\n", getpid(), get_mutex_value(0));
		cond_signal(1);
		release_mutex_spinlock(0);
	}
}
 27e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 281:	c9                   	leave  
 282:	c3                   	ret    
 283:	90                   	nop
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
	acquire_mutex_spinlock(0);
	while (get_mutex_value(0) == MAX_LIMIT)
		cond_wait(1, 0);

	if (get_mutex_value(0) < 10 && get_mutex_value(0) >= 0) {
 288:	83 ec 0c             	sub    $0xc,%esp
 28b:	6a 00                	push   $0x0
 28d:	e8 20 04 00 00       	call   6b2 <get_mutex_value>
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 e5                	js     27e <produce+0x4e>
		set_mutex_value(0, get_mutex_value(0) + 1);
 299:	83 ec 0c             	sub    $0xc,%esp
 29c:	6a 00                	push   $0x0
 29e:	e8 0f 04 00 00       	call   6b2 <get_mutex_value>
 2a3:	5a                   	pop    %edx
 2a4:	59                   	pop    %ecx
 2a5:	83 c0 01             	add    $0x1,%eax
 2a8:	50                   	push   %eax
 2a9:	6a 00                	push   $0x0
 2ab:	e8 0a 04 00 00       	call   6ba <set_mutex_value>
		printf(1, "[%d]: Produced an item. Curernt buffer size: %d\n", getpid(), get_mutex_value(0));
 2b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2b7:	e8 f6 03 00 00       	call   6b2 <get_mutex_value>
 2bc:	89 c3                	mov    %eax,%ebx
 2be:	e8 af 03 00 00       	call   672 <getpid>
 2c3:	53                   	push   %ebx
 2c4:	50                   	push   %eax
 2c5:	68 e4 0a 00 00       	push   $0xae4
 2ca:	6a 01                	push   $0x1
 2cc:	e8 bf 04 00 00       	call   790 <printf>
		cond_signal(1);
 2d1:	83 c4 14             	add    $0x14,%esp
 2d4:	6a 01                	push   $0x1
 2d6:	e8 cf 03 00 00       	call   6aa <cond_signal>
		release_mutex_spinlock(0);
 2db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2e2:	e8 b3 03 00 00       	call   69a <release_mutex_spinlock>
 2e7:	83 c4 10             	add    $0x10,%esp
	}
}
 2ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    
 2ef:	90                   	nop

000002f0 <consume>:

void consume(void)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	83 ec 10             	sub    $0x10,%esp
	acquire_mutex_spinlock(0);
 2f7:	6a 00                	push   $0x0
 2f9:	e8 94 03 00 00       	call   692 <acquire_mutex_spinlock>
	while (get_mutex_value(0) == MAX_LIMIT)
 2fe:	83 c4 10             	add    $0x10,%esp
 301:	eb 14                	jmp    317 <consume+0x27>
 303:	90                   	nop
 304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		cond_wait(1, 0);
 308:	83 ec 08             	sub    $0x8,%esp
 30b:	6a 00                	push   $0x0
 30d:	6a 01                	push   $0x1
 30f:	e8 8e 03 00 00       	call   6a2 <cond_wait>
 314:	83 c4 10             	add    $0x10,%esp
}

void consume(void)
{
	acquire_mutex_spinlock(0);
	while (get_mutex_value(0) == MAX_LIMIT)
 317:	83 ec 0c             	sub    $0xc,%esp
 31a:	6a 00                	push   $0x0
 31c:	e8 91 03 00 00       	call   6b2 <get_mutex_value>
 321:	83 c4 10             	add    $0x10,%esp
 324:	3b 05 88 0e 00 00    	cmp    0xe88,%eax
 32a:	74 dc                	je     308 <consume+0x18>
		cond_wait(1, 0);
	if (get_mutex_value(0) <= 10 && get_mutex_value(0) > 0) {
 32c:	83 ec 0c             	sub    $0xc,%esp
 32f:	6a 00                	push   $0x0
 331:	e8 7c 03 00 00       	call   6b2 <get_mutex_value>
 336:	83 c4 10             	add    $0x10,%esp
 339:	83 f8 0a             	cmp    $0xa,%eax
 33c:	7e 0a                	jle    348 <consume+0x58>
		set_mutex_value(0, get_mutex_value(0) - 1);
		printf(1, "[%d]: Produced an item. Curernt buffer size: %d\n", getpid(), get_mutex_value(0));
		cond_signal(1);
		release_mutex_spinlock(0);
	}
}
 33e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 341:	c9                   	leave  
 342:	c3                   	ret    
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void consume(void)
{
	acquire_mutex_spinlock(0);
	while (get_mutex_value(0) == MAX_LIMIT)
		cond_wait(1, 0);
	if (get_mutex_value(0) <= 10 && get_mutex_value(0) > 0) {
 348:	83 ec 0c             	sub    $0xc,%esp
 34b:	6a 00                	push   $0x0
 34d:	e8 60 03 00 00       	call   6b2 <get_mutex_value>
 352:	83 c4 10             	add    $0x10,%esp
 355:	85 c0                	test   %eax,%eax
 357:	7e e5                	jle    33e <consume+0x4e>
		set_mutex_value(0, get_mutex_value(0) - 1);
 359:	83 ec 0c             	sub    $0xc,%esp
 35c:	6a 00                	push   $0x0
 35e:	e8 4f 03 00 00       	call   6b2 <get_mutex_value>
 363:	5a                   	pop    %edx
 364:	59                   	pop    %ecx
 365:	83 e8 01             	sub    $0x1,%eax
 368:	50                   	push   %eax
 369:	6a 00                	push   $0x0
 36b:	e8 4a 03 00 00       	call   6ba <set_mutex_value>
		printf(1, "[%d]: Produced an item. Curernt buffer size: %d\n", getpid(), get_mutex_value(0));
 370:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 377:	e8 36 03 00 00       	call   6b2 <get_mutex_value>
 37c:	89 c3                	mov    %eax,%ebx
 37e:	e8 ef 02 00 00       	call   672 <getpid>
 383:	53                   	push   %ebx
 384:	50                   	push   %eax
 385:	68 e4 0a 00 00       	push   $0xae4
 38a:	6a 01                	push   $0x1
 38c:	e8 ff 03 00 00       	call   790 <printf>
		cond_signal(1);
 391:	83 c4 14             	add    $0x14,%esp
 394:	6a 01                	push   $0x1
 396:	e8 0f 03 00 00       	call   6aa <cond_signal>
		release_mutex_spinlock(0);
 39b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3a2:	e8 f3 02 00 00       	call   69a <release_mutex_spinlock>
 3a7:	83 c4 10             	add    $0x10,%esp
	}
}
 3aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ad:	c9                   	leave  
 3ae:	c3                   	ret    
 3af:	90                   	nop

000003b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
 3b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3ba:	89 c2                	mov    %eax,%edx
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c0:	83 c1 01             	add    $0x1,%ecx
 3c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3c7:	83 c2 01             	add    $0x1,%edx
 3ca:	84 db                	test   %bl,%bl
 3cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 3cf:	75 ef                	jne    3c0 <strcpy+0x10>
    ;
  return os;
}
 3d1:	5b                   	pop    %ebx
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
 3e5:	8b 55 08             	mov    0x8(%ebp),%edx
 3e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3eb:	0f b6 02             	movzbl (%edx),%eax
 3ee:	0f b6 19             	movzbl (%ecx),%ebx
 3f1:	84 c0                	test   %al,%al
 3f3:	75 1e                	jne    413 <strcmp+0x33>
 3f5:	eb 29                	jmp    420 <strcmp+0x40>
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 400:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 403:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 406:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 409:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 40d:	84 c0                	test   %al,%al
 40f:	74 0f                	je     420 <strcmp+0x40>
 411:	89 f1                	mov    %esi,%ecx
 413:	38 d8                	cmp    %bl,%al
 415:	74 e9                	je     400 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 417:	29 d8                	sub    %ebx,%eax
}
 419:	5b                   	pop    %ebx
 41a:	5e                   	pop    %esi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 420:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 422:	29 d8                	sub    %ebx,%eax
}
 424:	5b                   	pop    %ebx
 425:	5e                   	pop    %esi
 426:	5d                   	pop    %ebp
 427:	c3                   	ret    
 428:	90                   	nop
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <strlen>:

uint
strlen(char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 436:	80 39 00             	cmpb   $0x0,(%ecx)
 439:	74 12                	je     44d <strlen+0x1d>
 43b:	31 d2                	xor    %edx,%edx
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 c2 01             	add    $0x1,%edx
 443:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 447:	89 d0                	mov    %edx,%eax
 449:	75 f5                	jne    440 <strlen+0x10>
    ;
  return n;
}
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 44d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	eb 0d                	jmp    460 <memset>
 453:	90                   	nop
 454:	90                   	nop
 455:	90                   	nop
 456:	90                   	nop
 457:	90                   	nop
 458:	90                   	nop
 459:	90                   	nop
 45a:	90                   	nop
 45b:	90                   	nop
 45c:	90                   	nop
 45d:	90                   	nop
 45e:	90                   	nop
 45f:	90                   	nop

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 467:	8b 4d 10             	mov    0x10(%ebp),%ecx
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 d7                	mov    %edx,%edi
 46f:	fc                   	cld    
 470:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 472:	89 d0                	mov    %edx,%eax
 474:	5f                   	pop    %edi
 475:	5d                   	pop    %ebp
 476:	c3                   	ret    
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	8b 45 08             	mov    0x8(%ebp),%eax
 487:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 48a:	0f b6 10             	movzbl (%eax),%edx
 48d:	84 d2                	test   %dl,%dl
 48f:	74 1d                	je     4ae <strchr+0x2e>
    if(*s == c)
 491:	38 d3                	cmp    %dl,%bl
 493:	89 d9                	mov    %ebx,%ecx
 495:	75 0d                	jne    4a4 <strchr+0x24>
 497:	eb 17                	jmp    4b0 <strchr+0x30>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	38 ca                	cmp    %cl,%dl
 4a2:	74 0c                	je     4b0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 4a4:	83 c0 01             	add    $0x1,%eax
 4a7:	0f b6 10             	movzbl (%eax),%edx
 4aa:	84 d2                	test   %dl,%dl
 4ac:	75 f2                	jne    4a0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 4ae:	31 c0                	xor    %eax,%eax
}
 4b0:	5b                   	pop    %ebx
 4b1:	5d                   	pop    %ebp
 4b2:	c3                   	ret    
 4b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <gets>:

char*
gets(char *buf, int max)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 4c8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 4cb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ce:	eb 29                	jmp    4f9 <gets+0x39>
    cc = read(0, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	6a 00                	push   $0x0
 4d8:	e8 2d 01 00 00       	call   60a <read>
    if(cc < 1)
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	85 c0                	test   %eax,%eax
 4e2:	7e 1d                	jle    501 <gets+0x41>
      break;
    buf[i++] = c;
 4e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4e8:	8b 55 08             	mov    0x8(%ebp),%edx
 4eb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 4ed:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 4ef:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4f3:	74 1b                	je     510 <gets+0x50>
 4f5:	3c 0d                	cmp    $0xd,%al
 4f7:	74 17                	je     510 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4f9:	8d 5e 01             	lea    0x1(%esi),%ebx
 4fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4ff:	7c cf                	jl     4d0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 501:	8b 45 08             	mov    0x8(%ebp),%eax
 504:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 508:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50b:	5b                   	pop    %ebx
 50c:	5e                   	pop    %esi
 50d:	5f                   	pop    %edi
 50e:	5d                   	pop    %ebp
 50f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 510:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 513:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 515:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 519:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5f                   	pop    %edi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret    
 521:	eb 0d                	jmp    530 <stat>
 523:	90                   	nop
 524:	90                   	nop
 525:	90                   	nop
 526:	90                   	nop
 527:	90                   	nop
 528:	90                   	nop
 529:	90                   	nop
 52a:	90                   	nop
 52b:	90                   	nop
 52c:	90                   	nop
 52d:	90                   	nop
 52e:	90                   	nop
 52f:	90                   	nop

00000530 <stat>:

int
stat(char *n, struct stat *st)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	56                   	push   %esi
 534:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 535:	83 ec 08             	sub    $0x8,%esp
 538:	6a 00                	push   $0x0
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 f0 00 00 00       	call   632 <open>
  if(fd < 0)
 542:	83 c4 10             	add    $0x10,%esp
 545:	85 c0                	test   %eax,%eax
 547:	78 27                	js     570 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	ff 75 0c             	pushl  0xc(%ebp)
 54f:	89 c3                	mov    %eax,%ebx
 551:	50                   	push   %eax
 552:	e8 f3 00 00 00       	call   64a <fstat>
 557:	89 c6                	mov    %eax,%esi
  close(fd);
 559:	89 1c 24             	mov    %ebx,(%esp)
 55c:	e8 b9 00 00 00       	call   61a <close>
  return r;
 561:	83 c4 10             	add    $0x10,%esp
 564:	89 f0                	mov    %esi,%eax
}
 566:	8d 65 f8             	lea    -0x8(%ebp),%esp
 569:	5b                   	pop    %ebx
 56a:	5e                   	pop    %esi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret    
 56d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 575:	eb ef                	jmp    566 <stat+0x36>
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 587:	0f be 11             	movsbl (%ecx),%edx
 58a:	8d 42 d0             	lea    -0x30(%edx),%eax
 58d:	3c 09                	cmp    $0x9,%al
 58f:	b8 00 00 00 00       	mov    $0x0,%eax
 594:	77 1f                	ja     5b5 <atoi+0x35>
 596:	8d 76 00             	lea    0x0(%esi),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 5a0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5a3:	83 c1 01             	add    $0x1,%ecx
 5a6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5aa:	0f be 11             	movsbl (%ecx),%edx
 5ad:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5b0:	80 fb 09             	cmp    $0x9,%bl
 5b3:	76 eb                	jbe    5a0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 5b5:	5b                   	pop    %ebx
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret    
 5b8:	90                   	nop
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	56                   	push   %esi
 5c4:	53                   	push   %ebx
 5c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5c8:	8b 45 08             	mov    0x8(%ebp),%eax
 5cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5ce:	85 db                	test   %ebx,%ebx
 5d0:	7e 14                	jle    5e6 <memmove+0x26>
 5d2:	31 d2                	xor    %edx,%edx
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 5d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5e2:	39 da                	cmp    %ebx,%edx
 5e4:	75 f2                	jne    5d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 5e6:	5b                   	pop    %ebx
 5e7:	5e                   	pop    %esi
 5e8:	5d                   	pop    %ebp
 5e9:	c3                   	ret    

000005ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ea:	b8 01 00 00 00       	mov    $0x1,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <exit>:
SYSCALL(exit)
 5f2:	b8 02 00 00 00       	mov    $0x2,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <wait>:
SYSCALL(wait)
 5fa:	b8 03 00 00 00       	mov    $0x3,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <pipe>:
SYSCALL(pipe)
 602:	b8 04 00 00 00       	mov    $0x4,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <read>:
SYSCALL(read)
 60a:	b8 05 00 00 00       	mov    $0x5,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <write>:
SYSCALL(write)
 612:	b8 10 00 00 00       	mov    $0x10,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <close>:
SYSCALL(close)
 61a:	b8 15 00 00 00       	mov    $0x15,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <kill>:
SYSCALL(kill)
 622:	b8 06 00 00 00       	mov    $0x6,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <exec>:
SYSCALL(exec)
 62a:	b8 07 00 00 00       	mov    $0x7,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <open>:
SYSCALL(open)
 632:	b8 0f 00 00 00       	mov    $0xf,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <mknod>:
SYSCALL(mknod)
 63a:	b8 11 00 00 00       	mov    $0x11,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <unlink>:
SYSCALL(unlink)
 642:	b8 12 00 00 00       	mov    $0x12,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <fstat>:
SYSCALL(fstat)
 64a:	b8 08 00 00 00       	mov    $0x8,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <link>:
SYSCALL(link)
 652:	b8 13 00 00 00       	mov    $0x13,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <mkdir>:
SYSCALL(mkdir)
 65a:	b8 14 00 00 00       	mov    $0x14,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <chdir>:
SYSCALL(chdir)
 662:	b8 09 00 00 00       	mov    $0x9,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <dup>:
SYSCALL(dup)
 66a:	b8 0a 00 00 00       	mov    $0xa,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <getpid>:
SYSCALL(getpid)
 672:	b8 0b 00 00 00       	mov    $0xb,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <sbrk>:
SYSCALL(sbrk)
 67a:	b8 0c 00 00 00       	mov    $0xc,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <sleep>:
SYSCALL(sleep)
 682:	b8 0d 00 00 00       	mov    $0xd,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <uptime>:
SYSCALL(uptime)
 68a:	b8 0e 00 00 00       	mov    $0xe,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <acquire_mutex_spinlock>:

SYSCALL(acquire_mutex_spinlock)
 692:	b8 16 00 00 00       	mov    $0x16,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <release_mutex_spinlock>:
SYSCALL(release_mutex_spinlock)
 69a:	b8 17 00 00 00       	mov    $0x17,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <cond_wait>:
SYSCALL(cond_wait)
 6a2:	b8 18 00 00 00       	mov    $0x18,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <cond_signal>:
SYSCALL(cond_signal)
 6aa:	b8 19 00 00 00       	mov    $0x19,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <get_mutex_value>:
SYSCALL(get_mutex_value)
 6b2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <set_mutex_value>:
SYSCALL(set_mutex_value)
 6ba:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <init_mutex>:
SYSCALL(init_mutex)
 6c2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <init_counters>:
SYSCALL(init_counters)
 6ca:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <get_var>:
SYSCALL(get_var)
 6d2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <set_var>:
SYSCALL(set_var)
 6da:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    
 6e2:	66 90                	xchg   %ax,%ax
 6e4:	66 90                	xchg   %ax,%ax
 6e6:	66 90                	xchg   %ax,%ax
 6e8:	66 90                	xchg   %ax,%ax
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	89 c6                	mov    %eax,%esi
 6f8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6fe:	85 db                	test   %ebx,%ebx
 700:	74 7e                	je     780 <printint+0x90>
 702:	89 d0                	mov    %edx,%eax
 704:	c1 e8 1f             	shr    $0x1f,%eax
 707:	84 c0                	test   %al,%al
 709:	74 75                	je     780 <printint+0x90>
    neg = 1;
    x = -xx;
 70b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 70d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 714:	f7 d8                	neg    %eax
 716:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 719:	31 ff                	xor    %edi,%edi
 71b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 71e:	89 ce                	mov    %ecx,%esi
 720:	eb 08                	jmp    72a <printint+0x3a>
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 728:	89 cf                	mov    %ecx,%edi
 72a:	31 d2                	xor    %edx,%edx
 72c:	8d 4f 01             	lea    0x1(%edi),%ecx
 72f:	f7 f6                	div    %esi
 731:	0f b6 92 48 0b 00 00 	movzbl 0xb48(%edx),%edx
  }while((x /= base) != 0);
 738:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 73a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 73d:	75 e9                	jne    728 <printint+0x38>
  if(neg)
 73f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 742:	8b 75 c0             	mov    -0x40(%ebp),%esi
 745:	85 c0                	test   %eax,%eax
 747:	74 08                	je     751 <printint+0x61>
    buf[i++] = '-';
 749:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 74e:	8d 4f 02             	lea    0x2(%edi),%ecx
 751:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 755:	8d 76 00             	lea    0x0(%esi),%esi
 758:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 75b:	83 ec 04             	sub    $0x4,%esp
 75e:	83 ef 01             	sub    $0x1,%edi
 761:	6a 01                	push   $0x1
 763:	53                   	push   %ebx
 764:	56                   	push   %esi
 765:	88 45 d7             	mov    %al,-0x29(%ebp)
 768:	e8 a5 fe ff ff       	call   612 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 76d:	83 c4 10             	add    $0x10,%esp
 770:	39 df                	cmp    %ebx,%edi
 772:	75 e4                	jne    758 <printint+0x68>
    putc(fd, buf[i]);
}
 774:	8d 65 f4             	lea    -0xc(%ebp),%esp
 777:	5b                   	pop    %ebx
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 780:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 782:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 789:	eb 8b                	jmp    716 <printint+0x26>
 78b:	90                   	nop
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 796:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 799:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 79c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 79f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7a5:	0f b6 1e             	movzbl (%esi),%ebx
 7a8:	83 c6 01             	add    $0x1,%esi
 7ab:	84 db                	test   %bl,%bl
 7ad:	0f 84 b0 00 00 00    	je     863 <printf+0xd3>
 7b3:	31 d2                	xor    %edx,%edx
 7b5:	eb 39                	jmp    7f0 <printf+0x60>
 7b7:	89 f6                	mov    %esi,%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7c0:	83 f8 25             	cmp    $0x25,%eax
 7c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 7c6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7cb:	74 18                	je     7e5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7cd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 7d6:	6a 01                	push   $0x1
 7d8:	50                   	push   %eax
 7d9:	57                   	push   %edi
 7da:	e8 33 fe ff ff       	call   612 <write>
 7df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7e2:	83 c4 10             	add    $0x10,%esp
 7e5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 7ec:	84 db                	test   %bl,%bl
 7ee:	74 73                	je     863 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 7f0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 7f2:	0f be cb             	movsbl %bl,%ecx
 7f5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7f8:	74 c6                	je     7c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7fa:	83 fa 25             	cmp    $0x25,%edx
 7fd:	75 e6                	jne    7e5 <printf+0x55>
      if(c == 'd'){
 7ff:	83 f8 64             	cmp    $0x64,%eax
 802:	0f 84 f8 00 00 00    	je     900 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 808:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 80e:	83 f9 70             	cmp    $0x70,%ecx
 811:	74 5d                	je     870 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 813:	83 f8 73             	cmp    $0x73,%eax
 816:	0f 84 84 00 00 00    	je     8a0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 81c:	83 f8 63             	cmp    $0x63,%eax
 81f:	0f 84 ea 00 00 00    	je     90f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 825:	83 f8 25             	cmp    $0x25,%eax
 828:	0f 84 c2 00 00 00    	je     8f0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 82e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 831:	83 ec 04             	sub    $0x4,%esp
 834:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 838:	6a 01                	push   $0x1
 83a:	50                   	push   %eax
 83b:	57                   	push   %edi
 83c:	e8 d1 fd ff ff       	call   612 <write>
 841:	83 c4 0c             	add    $0xc,%esp
 844:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 847:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 84a:	6a 01                	push   $0x1
 84c:	50                   	push   %eax
 84d:	57                   	push   %edi
 84e:	83 c6 01             	add    $0x1,%esi
 851:	e8 bc fd ff ff       	call   612 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 856:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 85a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 85d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 85f:	84 db                	test   %bl,%bl
 861:	75 8d                	jne    7f0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 863:	8d 65 f4             	lea    -0xc(%ebp),%esp
 866:	5b                   	pop    %ebx
 867:	5e                   	pop    %esi
 868:	5f                   	pop    %edi
 869:	5d                   	pop    %ebp
 86a:	c3                   	ret    
 86b:	90                   	nop
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 870:	83 ec 0c             	sub    $0xc,%esp
 873:	b9 10 00 00 00       	mov    $0x10,%ecx
 878:	6a 00                	push   $0x0
 87a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 87d:	89 f8                	mov    %edi,%eax
 87f:	8b 13                	mov    (%ebx),%edx
 881:	e8 6a fe ff ff       	call   6f0 <printint>
        ap++;
 886:	89 d8                	mov    %ebx,%eax
 888:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 88b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 88d:	83 c0 04             	add    $0x4,%eax
 890:	89 45 d0             	mov    %eax,-0x30(%ebp)
 893:	e9 4d ff ff ff       	jmp    7e5 <printf+0x55>
 898:	90                   	nop
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 8a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8a5:	83 c0 04             	add    $0x4,%eax
 8a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 8ab:	b8 40 0b 00 00       	mov    $0xb40,%eax
 8b0:	85 db                	test   %ebx,%ebx
 8b2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 8b5:	0f b6 03             	movzbl (%ebx),%eax
 8b8:	84 c0                	test   %al,%al
 8ba:	74 23                	je     8df <printf+0x14f>
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8c3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 8c6:	83 ec 04             	sub    $0x4,%esp
 8c9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 8cb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8ce:	50                   	push   %eax
 8cf:	57                   	push   %edi
 8d0:	e8 3d fd ff ff       	call   612 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8d5:	0f b6 03             	movzbl (%ebx),%eax
 8d8:	83 c4 10             	add    $0x10,%esp
 8db:	84 c0                	test   %al,%al
 8dd:	75 e1                	jne    8c0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8df:	31 d2                	xor    %edx,%edx
 8e1:	e9 ff fe ff ff       	jmp    7e5 <printf+0x55>
 8e6:	8d 76 00             	lea    0x0(%esi),%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8f9:	6a 01                	push   $0x1
 8fb:	e9 4c ff ff ff       	jmp    84c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 900:	83 ec 0c             	sub    $0xc,%esp
 903:	b9 0a 00 00 00       	mov    $0xa,%ecx
 908:	6a 01                	push   $0x1
 90a:	e9 6b ff ff ff       	jmp    87a <printf+0xea>
 90f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 912:	83 ec 04             	sub    $0x4,%esp
 915:	8b 03                	mov    (%ebx),%eax
 917:	6a 01                	push   $0x1
 919:	88 45 e4             	mov    %al,-0x1c(%ebp)
 91c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 91f:	50                   	push   %eax
 920:	57                   	push   %edi
 921:	e8 ec fc ff ff       	call   612 <write>
 926:	e9 5b ff ff ff       	jmp    886 <printf+0xf6>
 92b:	66 90                	xchg   %ax,%ax
 92d:	66 90                	xchg   %ax,%ax
 92f:	90                   	nop

00000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	a1 8c 0e 00 00       	mov    0xe8c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 936:	89 e5                	mov    %esp,%ebp
 938:	57                   	push   %edi
 939:	56                   	push   %esi
 93a:	53                   	push   %ebx
 93b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 940:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 943:	39 c8                	cmp    %ecx,%eax
 945:	73 19                	jae    960 <free+0x30>
 947:	89 f6                	mov    %esi,%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 950:	39 d1                	cmp    %edx,%ecx
 952:	72 1c                	jb     970 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	39 d0                	cmp    %edx,%eax
 956:	73 18                	jae    970 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 958:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95e:	72 f0                	jb     950 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	39 d0                	cmp    %edx,%eax
 962:	72 f4                	jb     958 <free+0x28>
 964:	39 d1                	cmp    %edx,%ecx
 966:	73 f0                	jae    958 <free+0x28>
 968:	90                   	nop
 969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 970:	8b 73 fc             	mov    -0x4(%ebx),%esi
 973:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 976:	39 d7                	cmp    %edx,%edi
 978:	74 19                	je     993 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 97a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 97d:	8b 50 04             	mov    0x4(%eax),%edx
 980:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 983:	39 f1                	cmp    %esi,%ecx
 985:	74 23                	je     9aa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 987:	89 08                	mov    %ecx,(%eax)
  freep = p;
 989:	a3 8c 0e 00 00       	mov    %eax,0xe8c
}
 98e:	5b                   	pop    %ebx
 98f:	5e                   	pop    %esi
 990:	5f                   	pop    %edi
 991:	5d                   	pop    %ebp
 992:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 993:	03 72 04             	add    0x4(%edx),%esi
 996:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 999:	8b 10                	mov    (%eax),%edx
 99b:	8b 12                	mov    (%edx),%edx
 99d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9a0:	8b 50 04             	mov    0x4(%eax),%edx
 9a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a6:	39 f1                	cmp    %esi,%ecx
 9a8:	75 dd                	jne    987 <free+0x57>
    p->s.size += bp->s.size;
 9aa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 9ad:	a3 8c 0e 00 00       	mov    %eax,0xe8c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9b5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9b8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9ba:	5b                   	pop    %ebx
 9bb:	5e                   	pop    %esi
 9bc:	5f                   	pop    %edi
 9bd:	5d                   	pop    %ebp
 9be:	c3                   	ret    
 9bf:	90                   	nop

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9cc:	8b 15 8c 0e 00 00    	mov    0xe8c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	8d 78 07             	lea    0x7(%eax),%edi
 9d5:	c1 ef 03             	shr    $0x3,%edi
 9d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9db:	85 d2                	test   %edx,%edx
 9dd:	0f 84 a3 00 00 00    	je     a86 <malloc+0xc6>
 9e3:	8b 02                	mov    (%edx),%eax
 9e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9e8:	39 cf                	cmp    %ecx,%edi
 9ea:	76 74                	jbe    a60 <malloc+0xa0>
 9ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9f2:	be 00 10 00 00       	mov    $0x1000,%esi
 9f7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 9fe:	0f 43 f7             	cmovae %edi,%esi
 a01:	ba 00 80 00 00       	mov    $0x8000,%edx
 a06:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 a0c:	0f 46 da             	cmovbe %edx,%ebx
 a0f:	eb 10                	jmp    a21 <malloc+0x61>
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a1a:	8b 48 04             	mov    0x4(%eax),%ecx
 a1d:	39 cf                	cmp    %ecx,%edi
 a1f:	76 3f                	jbe    a60 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a21:	39 05 8c 0e 00 00    	cmp    %eax,0xe8c
 a27:	89 c2                	mov    %eax,%edx
 a29:	75 ed                	jne    a18 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a2b:	83 ec 0c             	sub    $0xc,%esp
 a2e:	53                   	push   %ebx
 a2f:	e8 46 fc ff ff       	call   67a <sbrk>
  if(p == (char*)-1)
 a34:	83 c4 10             	add    $0x10,%esp
 a37:	83 f8 ff             	cmp    $0xffffffff,%eax
 a3a:	74 1c                	je     a58 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a3c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 a3f:	83 ec 0c             	sub    $0xc,%esp
 a42:	83 c0 08             	add    $0x8,%eax
 a45:	50                   	push   %eax
 a46:	e8 e5 fe ff ff       	call   930 <free>
  return freep;
 a4b:	8b 15 8c 0e 00 00    	mov    0xe8c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a51:	83 c4 10             	add    $0x10,%esp
 a54:	85 d2                	test   %edx,%edx
 a56:	75 c0                	jne    a18 <malloc+0x58>
        return 0;
 a58:	31 c0                	xor    %eax,%eax
 a5a:	eb 1c                	jmp    a78 <malloc+0xb8>
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a60:	39 cf                	cmp    %ecx,%edi
 a62:	74 1c                	je     a80 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a64:	29 f9                	sub    %edi,%ecx
 a66:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a69:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a6c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a6f:	89 15 8c 0e 00 00    	mov    %edx,0xe8c
      return (void*)(p + 1);
 a75:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a7b:	5b                   	pop    %ebx
 a7c:	5e                   	pop    %esi
 a7d:	5f                   	pop    %edi
 a7e:	5d                   	pop    %ebp
 a7f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a80:	8b 08                	mov    (%eax),%ecx
 a82:	89 0a                	mov    %ecx,(%edx)
 a84:	eb e9                	jmp    a6f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a86:	c7 05 8c 0e 00 00 90 	movl   $0xe90,0xe8c
 a8d:	0e 00 00 
 a90:	c7 05 90 0e 00 00 90 	movl   $0xe90,0xe90
 a97:	0e 00 00 
    base.s.size = 0;
 a9a:	b8 90 0e 00 00       	mov    $0xe90,%eax
 a9f:	c7 05 94 0e 00 00 00 	movl   $0x0,0xe94
 aa6:	00 00 00 
 aa9:	e9 3e ff ff ff       	jmp    9ec <malloc+0x2c>
