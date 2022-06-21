# Named pipe implementation

In this project, you will:

* properly implement a producer / consumer.

* learn how to use SHMOPs - shared memory operations - and SHMEM - shared memory. These features were added to AT&T System V Unix and then later ported to other Unix systems (and finally, Linux).

* learn how to use the semaphore synchronization primitive to allow simultaneous access to the shared memory by two different processes.

* learn how to implement an IPC mechanism called the pipe, or perhaps in this case, better termed "named pipes."

* learn how to use Unix signals.

## You will implement two programs

You will need to implement a producer and consumer. Everything you need to know about the concept is given in Chapter 31 of OSTEP. In particular, a correct solution to the producer consume problem is given in figure 31.12. I admonish you to understand that chapter before you start coding.

### The producer (high level)

The producer adds characters to a shared buffer only when there is space in the buffer.

The buffer is implemented in shared memory and represents the "pipe" between the producer and consumer.

As per the correct producer consumer relationship, the producer goes to sleep when the buffer is full. The producer is awakened when room is made in the buffer.

Additionally, there is a random chance that the producer will go to sleep, just because. This simulates real work conditions where the producer has other work to do or simply doesn't feel the need to produce anything for a bit.

The producer runs forever until it receives a SIGINT (CNTRL-C). When it receives a SIGINT, it terminates gracefully.

One way to check if your producer is correctly responding to receiving a SIGINT is a) to print out when it receives one and b) run `ps` after the monitor exits. If you see your producer, it didn't respond.

### The consumer (high level)

The consumer drains characters from a shared buffer only when there are characters available to be drained (i.e. the buffer is not empty).

The buffer is implemented in shared memory and represents the "pipe" between the producer and consumer.

As per the correct producer consumer relationship, the consumer goes to sleep when the buffer is empty. The consumer is awakened when there is something in the buffer to be consumed.

Additionally, there is a random chance that the consumer will go to sleep, just because. This simulates real work conditions where the consumer has other work to do or simply doesn't feel the need to consume anything for a bit.

The consumer runs forever until it receives a SIGINT (CNTRL-C). When it receives a SIGINT, it terminates gracefully.

One way to check if your consumer is correctly responding to receiving a SIGINT is a) to print out when it receives one and b) run `ps` after the monitor exits. If you see your consumer, it didn't respond.

## Platform

On Windows, you must compile and run on WSL.

On the Mac, you must compile and run on a Linux virtual machine (with more than one processor). Why? Apple. Friggin' Apple.

## The monitor (high level)

I provide the monitor. The monitor

* initializes shared memory - your two programs attach to the shared memory.
* launches your programs - the producer and consumer.
* listens for a CNTRL-C - when it hears one, it terminates gracefully.
* each second prints values it takes from the shared memory to give you a peek into the internal state of the pipe. This window is essential and is used heavily in grading.

Here is a sample output of the monitor:

```text
Producer: Tue May 26 11:51:24 2020 semvalue: 3672 p_index: 1436 Consumer: Tue May 26 11:51:24 2020 semvalue:  423 c_index: 1012
```

Notice that the producer `semvalue` and the consumer `semvalue` sum to one less than `BUFFER_SIZE` defined in "shared_memory.h". This should NEARLY ALWAYS BE THE CASE. The reason that this might not be the case, once in a while, is that the monitor is NOT synchronized to the producer or consumer. The monitor may capture a state which is inconsistent only once in a while since both the producer and consumer will spend most of the time sleeping at a time where they are consistent. The monitor will flag whenever the `semvalues` do not add up. Again, it can happen but should not happen frequently.

The monitor will also flag any buffer over and underruns, i.e. when `guard1` and `guard2` are not both -1. The monitor will set them back to -1 again so you can keep going. This message SHOULD NEVER EVER BE SEEN.

`p_index` and `c_index` should never be less than zero nor should they ever be `BUFFER_SIZE` or larger.

## The shared memory

You are given this in "shared_memory.h":

```c++
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
	int p_index;						// The head index
	int c_index;						// The tail index
	unsigned char buffer[BUFFER_SIZE];			// The data being transferred
};
```

As the comment says, you cannot change this file for any reason. Doing so will likely cause your program to NOT to work.

### Signs of life

The two `time_t` variables end in `sol`. This refers to "signs of life". Every time you process one characters, you should update the appropriate field.

The producer updates `psol`. The consumer updates `csol`. 

You actually know how to do this already, amazingly enough. You've been *almost* doing something like this since CS 1.

```c++
#include <ctime>
...
...srand((unsigned int) time(nullptr));
...
```

Replace `nullptr` with a pointer to the appropriate sign of life.

The monitor will read and print these values once per second. If you see 1969, you aren't doing the update. Look up why 1969.

### The semaphores

These are initialized by the monitor and maintained by you. You will see how in Chapter 31 of OSTEP.

### The indices

You are implementing a certain kind of producer consumer named a ring buffer. Of course, it's not really a ring, you can see `buffer` is simply an array. You will logically treat it as a ring. The producer adds the next payload at `p_index` and the consumer will get the next new payload at `c_index`. The ring is closed simply by resetting these indicies back to zero at the right time. `p_index` and `c_index` chase each other. They should NEVER be less than 0 and NEVER be more than BUFFER_SIZE - 1. If you get a buffer overrun / underrun message from the monitor, it will be because the producer's `p_index` is bad. Why not `c_index`?

### shmops

The documentation of the various shmops can be found [here](https://linux.die.net/man/7/shm_overview).

## First step - catching signals

In each of the producer and consumer, implement a SIGINT catcher. You will need `signal.h`. You will write a catcher - in fact, I'll give it to you as it isn't much:

```c++
void my_handler(int s)
{
	printf("<WHICH PROGRAM HERE> caught signal 0x%x\n",s);
	keep_going = false; 
}
```

`keep_going` is a global - when it turns false, your program should exit gracefully (i.e. close everything it opened).

You'll need to set up the catcher. This I will not give you. But here are some hints:

* You'll need a `struct sigaction`.
* You'll need to initialize it properly.
* You'll need to call `sigaction()`.

The same code will work in both producer and consumer.

I suggest you write a dummy program to develop the few lines the above will take. `main()` will simply do the signal setup then loop on `keep_going`, sleeping for a short while so as not to burn up your CPU. When you hit CNTRL-C, your catcher's message should print and your program exit.

The output might look like this:

```text
$ ./a.out
^CSIGTEST caught signal 0x2
main loop broken - exiting
$
```

Now you're ready to move on.

## Second step - write the shmem handling code

I chose to encapsulate all my shmops in a class. Here is my class definition - I EMPHASIS YOU DO NOT HAVE TO FOLLOW THIS ADVICE. THIS IS FOR ILLUSTRATION ONLY.

```c++
class Shmem
{
public:
	Shmem(std::string name);

	int OpenShMem(bool truncate = false);
	void CloseShMem();
	void * Map();
	void Unmap();

	int fd;
	std::string name;
	SharedMemory * shmem_ptr;
};
```

In my implementation:

* the constructor merely sets some state.
* `OpenShMem()` opens the shared memory region. Your version does not need the boolean `truncate`. That is needed only by the monitor and is used to set the size of the shared memory.
* `CloseShMem()` gracefully shuts down the shared memory region.
* `Map()` arranges for the shared memory region to appear within the address space of the process. Think of this as the `alloc()`.
* `Unmap()` as the name implies, think of this as the `free()`.

Interestingly, when the shared memory region is first attached, a handle to it is returned in the form of a file descriptor, like any open file. In fact, the "file" has a name, that's why we can say we're building a named pipe.

When you have implemented the memory mapping code, you can test it in your two programs by having the producer set `p_index` to a known value. Also, set a different known value to `c_index` in the consumer. Then, launch your code via the monitor. It (the monitor) should report the known values if all things are working.

## Third step - write the producer

Consult OSTEP 31.12 for a skeleton producer. Remember, all the synchronization primitives found in shared memory have been properly initialized in the monitor. If you are successful in writing a producer, it will stop itself after filling the buffer (which it will since there is no consumer to make room in the buffer).

## Last, write the consumer

Consult OSTEP 31.12 for a skeleton consumer. Remember, all the synchronization primitives found in shared memory have been properly initialized in the monitor.

## Producer revisited

The producer should fill the buffer with repetitions of the capital letters in the alphabet. `A` through `Z`. 

Remember to check `keep_going` within your loop producing one character at a time. Also after producing EACH character, there is a TWO (2) percent chance of going to sleep. The minimum time to sleep and maximum time to sleep FOR THE PRODUCER is specified by:

```c++
const int USLEEP_TIME_MAX = 50000;
const int USLEEP_TIME_MIN = 20000;
```

The intention is that a value between `USLEEP_TIME_MIN` and `USLEEP_TIME_MIN + USLEEP_TIME_MAX` will be chosen at random. These numbers are microseconds. Use `usleep()`. It is old fashioned but sufficient for this purpose.

Finally, after producing every character, you must update `p_sol`.

## Consumer revisited

The consumer will drain the buffer one character at a time. It must perform error checking to ensure that the next character is one higher than the previous character (with wrap around at `Z` of course).

Here is what I print:

```text
cout << "Consumer got characters out of order. C: " << c << " C_OLD: " << c_old << endl;
```

Remember to check `keep_going` within your loop consuming one character at a time. Also after consuming EACH character, there is a TWO (2) percent chance of going to sleep. The minimum time to sleep and maximum time to sleep FOR THE CONSUMER is specified by:

```c++
const int USLEEP_TIME_MAX = 40000;
const int USLEEP_TIME_MIN = 20000;
```

The intention is that a value between `USLEEP_TIME_MIN` and `USLEEP_TIME_MIN + USLEEP_TIME_MAX` will be chosen at random. These numbers are microseconds. Use `usleep()`. It is old fashioned but sufficient for this purpose. Notice that the minimum and maximum values are different than the producer. These (smaller) values mean that on average, the pairing will skew to the producer being slower than the consumer.

Finally, after consuming each character, you must update `c_sol`.

## Sample output of the monitor

Your programs, as submitted, should not print anything from their loops.

Here is sample output from the monitor:

```text
$ ./monitor -p ./producer -c ./consumer
Shmem at: 0x7f0428733000
Lock and semaphores initialized.
Consumer launched - PID: 9924
Producer launched - PID: 9925
Producer: Wed Dec 31 18:00:00 1969 semvalue: 4096 p_index:    0 Consumer: Wed Dec 31 18:00:00 1969 semvalue:    0 c_index:    0
Producer
Shmem at: 0x7f1ae0d83000
Consumer
Shmem at: 0x7f44ca09f000
Producer: Tue May 26 15:34:56 2020 semvalue: 4027 p_index:  910 Consumer: Tue May 26 15:34:56 2020 semvalue:   68 c_index:  841
Producer: Tue May 26 15:34:57 2020 semvalue: 3941 p_index: 1974 Consumer: Tue May 26 15:34:57 2020 semvalue:  154 c_index: 1819
Producer: Tue May 26 15:34:58 2020 semvalue: 4064 p_index: 3003 Consumer: Tue May 26 15:34:58 2020 semvalue:   31 c_index: 2971
Producer: Tue May 26 15:34:59 2020 semvalue: 4084 p_index:  395 Consumer: Tue May 26 15:34:59 2020 semvalue:   11 c_index:  383
Producer: Tue May 26 15:35:00 2020 semvalue: 4087 p_index: 1883 Consumer: Tue May 26 15:35:00 2020 semvalue:    8 c_index: 1874
Producer: Tue May 26 15:35:01 2020 semvalue: 3875 p_index: 3123 Consumer: Tue May 26 15:35:01 2020 semvalue:  220 c_index: 2902
Producer: Tue May 26 15:35:02 2020 semvalue: 3130 p_index: 1321 Consumer: Tue May 26 15:35:02 2020 semvalue:  965 c_index:  355
Producer: Tue May 26 15:35:03 2020 semvalue: 3492 p_index: 2536 Consumer: Tue May 26 15:35:03 2020 semvalue:  603 c_index: 1932
^CProducer caught signal 0x2
Consumer caught signal 0x2
Monitor caught signal 0x2
$
```

Notice the result of skewing... the consumer, being faster than the producer, keeps the pipe fairly empty. This is not always the case of course.
