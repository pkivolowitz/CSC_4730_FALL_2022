#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <getopt.h>

/* Based on OSTEP.
*/

int done = 0;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER; 
pthread_cond_t c = PTHREAD_COND_INITIALIZER;

void * child0(void *arg) { 
	pthread_mutex_lock(&m); 
	printf("child0\n"); 
	done = 1; 
	pthread_cond_signal(&c); 
	pthread_mutex_unlock(&m);
	return NULL;
}

void * child1(void *arg) { 
	pthread_mutex_lock(&m); 
	printf("child1\n"); 
	pthread_cond_signal(&c); 
	pthread_mutex_unlock(&m);
	return NULL;
}

void thr_join0() 
{
	pthread_mutex_lock(&m); 
	while (done == 0) {
		pthread_cond_wait(&c, &m); 
	}
	pthread_mutex_unlock(&m);
}

void thr_join1() 
{
	pthread_mutex_lock(&m); 
	pthread_cond_wait(&c, &m); 
	pthread_mutex_unlock(&m);
}

int main(int argc, char *argv[]) { 
	int cval;
	int mode = 0;
	int counter = 0;

	while ((cval = getopt(argc, argv, "m:")) != -1) {
		switch (cval) {
			case 'm':
				mode = atoi(optarg);
				break;

			default:
				printf("Bad option -  usage: prog -m MODENUM\n");
				exit(1);
		}
	}
	if (mode < 0 || mode > 1) {
		fprintf(stderr, "Mode %d is not 0 or 1\n", mode);
		exit(1);
	}

	pthread_t p;

	void * (* child[2])(void *) = { child0, child1 };
	void (* joins[2])() = { thr_join0, thr_join1 };

	printf(!mode ? "This version is correct. It will NOT hang.\n" : "This version may hang\n");
	printf("Hit enter to begin.\nHit ^C to terminate.\n");
	getc(stdin);
	while (1) {
		printf("parent: begin - iteration: %d\n", ++counter);
		pthread_create(&p, NULL, child[mode], NULL);
		joins[mode]();
		printf("parent: end\n");
	}

	return 0;
}
