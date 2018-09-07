#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

void
head(int fd, int num_lines)
{
	int n, count = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0 && count < num_lines) {
		for (int i=0; i<n; i++){
			if (buf[i] == '\n'){
				count++;
				if (count == num_lines){
					printf(1, "\n");
					break;
				}
			}
			printf(1, "%c", buf[i]);
		}
	}
	if(n < 0){
		printf(1, "head: read error\n");
		exit();
	}
}

int
main(int argc, char *argv[])
{
	int fd, i;

	if(argc <= 1){
		head(0, 1024);
		exit();
	}

	int num_lines = atoi(argv[1]);

	for(i = 2; i < argc; i++){
		if((fd = open(argv[i], 0)) < 0){
			printf(1, "head: cannot open %s\n", argv[i]);
			exit();
		}
		head(fd, num_lines);
		close(fd);
	}
	exit();
}
