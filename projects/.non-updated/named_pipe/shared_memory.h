#pragma once
#include <pthread.h>
#include <semaphore.h>
#include <ctime>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>   
#include <string>
#include <errno.h>
#include <stdio.h>
#include <assert.h>

#define	BUFFER_SIZE		4096
#define	SHMEM_NAME		"/p5shmem"

/*	You M U S T use this struct. If you make any changes at all, you
	will not be able to  interoperate with the test driver.   Do NOT
	make any changes to this struct.
*/

struct SharedMemory
{
	time_t csol;						// consumer sign-of-life
	time_t psol;						// producer sign-of-life
	sem_t block;						// Left
	sem_t emptyCount;					//      to the 
	sem_t fillCount;					//             student
	int p_index;						// The head "pointer"
	int c_index;						// The tail "pointer"
	int guard1;							// must always remain -1
	unsigned char buffer[BUFFER_SIZE];	// The data being transferred
	int guard2;							// must always remain -1
};

