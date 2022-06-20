# CSC 4730 - Project 5

In this project you will take xv6 where you left off (you added a guard page) and rearrange a process' address space to conform to the more typical layout. In the image below on the left, is where you left things at the end of the guard page project. On the right is how it will look when you are done with this project.

![xv6_move_stack](./xv6_move_stack.png)

Note: in the xv6 kernel what I labeled as ```HIMEM``` will be a user defined value in `param.h` named `USERTOP`.

**This `define` does net yet exist. You must set it at `0xA0000`.**

## Start from previous xv6 project

Copy your previous working xv6 project (with the guard page added at address 0).

## Before starting your changes

Here is your first test program, called `stack`.

```c
#include "types.h"
#include "user.h"

#define	STACK_GULP	(1 << 10)

void Foo(int counter) {
	unsigned char a[STACK_GULP];
	printf(1, "Iteration: %d - %d bytes added to stack - 0x%d\n", ++counter, STACK_GULP, a);
	Foo(counter);
}

int main(int argc, char ** argv) {
	int heap_amount;
	void * p;
	if (argc > 1) {
		heap_amount = atoi(argv[1]);
		printf(1, "Attempting to allocate: %d bytes from the heap\n", heap_amount);
		p = malloc(heap_amount);
		printf(1, "malloc() returns: 0x%x\n", p);
		if (p == 0) {
			exit();
		}
	} 
	printf(1, "Starting descent into stack space\n");
	Foo(0);
	exit();
}
```

Here is what it will produce when run it on xv6 before you start your changes. Confirm this.


```text
$ stack
Starting descent into stack space
Iteration: 1 - 1024 bytes added to stack - 0x15280
Iteration: 2 - 1024 bytes added to stack - 0x14224
Iteration: 3 - 1024 bytes added to stack - 0x13168
pid 6 stack: trap 14 err 7 on cpu 1 eip 0x105a addr 0x2f40--kill proc
$ 
```

This program will keep allocating a little more than 1K to the stack. Notice the program:

* crashes in its fourth 1K pull on the stack.
* the stack addresses decrease.

When your project is finished, `stack` should produce:

```text
...lines deleted...
Iteration: 607 - 1024 bytes added to stack - 0x14320
Iteration: 608 - 1024 bytes added to stack - 0x13264
pid 8 stack: trap 14 err 6 on cpu 0 eip 0x105a addr 0x2fa0--kill proc
$
```

The test program takes an optional number of bytes to allocate on the heap. Here is a sample run using that feature:

```text
$ stack 635000
Attempting to allocate: 635000 bytes from the heap
malloc() returns: 0x2008
Starting descent into stack space
Iteration: 1 - 1024 bytes added to stack - 0x654240
Iteration: 2 - 1024 bytes added to stack - 0x653184
Iteration: 3 - 1024 bytes added to stack - 0x652128
pid 12 stack: trap 14 err 6 on cpu 0 eip 0x109a addr 0x9ef30--kill proc
$
```

Notice how, as the `brk` moves, the amount of stack space that is available changes. It is your job to enforce a single page gap between the heap and stack.

## Discussion

You saw in ```fork()``` how a new process's address space is initialized with a copy of the parent process. You figured out that you had to avoid copying any pages full of dragons. You'll definitely need pay to attention to how address spaces are copied in this project as well. Stay away from dragons.

When you added the guard page in ```exec()``` you did so by starting ```sz``` at 0x1000 instead of 0. You also saw that ```sz``` continually got bumped down into higher memory as the address space was initialized. Ultimately, ```sz``` came to represent the place where the heap stopped and dragons started (in the diagram above on the left).

To create the stack, note the existing code in `exec.c` says this:

```c
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - PGSIZE));
```

This code is no longer correct as you'll be moving the stack to near `USERTOP` (see above for definition of `USERTOP`). Pay attention to the comment appearing before the code above in deciding what to do with the  code.

By moving the stack to the top of memory the heap will start immediately after the code / globals. You still need to keep track of where the heap ends and the dragons begin, which is what ```sz``` is designed to do.

But now, the stack will *also* be allowed to grow so you'll need to keep track of it as well.  Find where `sz` is stored per process and make something similar to keep track of the amount of memory allocated for the stack.

You might think heap growth is all done. But. No.

There is some additional work for growing the heap (and later, growing the stack). **You must ensure that the heap and stack do not collide.**

You do this by keeping the two at least one page apart. You will have to check for this during heap growth and stack growth. Start by figuring out ```sys_sbrk()``` in sysproc.c and ```growproc()``` in proc.c. Then when you understand how the heap grows (and how to check for collision with the stack) you will be better able to implement stack growth (and how to check for collision with the heap). This checking is not as straightforward as it seems.

What about stack growth? It DOESN’T HAPPEN ON PURPOSE – rather it just happens as code is executed. Rather than knowing ahead of time that you want to add memory you’ll have to wait for a SEGFAULT. Ow. Somebody poked a dragon! 

Better look up SEGFAULT which is called ```T_PGFLT``` in xv6. ```T_PGFLT``` is of course, *a trap*.

But not just any SEGFAULT. If it happens within the TWO pages that’s just above your stack then it might have happened because the stack needed to grow. If it happens anywhere else in unallocated space – unleash the dragons (that’s what happens now). 

Again, make sure you leave a page between the lowest stack page and the highest heap page.

Damn you Perry. By now you have figured out there doesn't seem to be any code implemented to handle page faults. Maybe you need to implement this code. Where? I keep saying *it is a trap*.

Also, think about what happens when you pass a parameter into the kernel, for example; if passing a pointer, the kernel needs to be very careful with it, to ensure you haven't passed it a bad pointer.

## Unreasonable hint

I'll take the unusual step of listing the files that will need to change.

* param.h
* proc.h
* proc.c
* syscall.c
* exec.c
* vm.c
* trap.c
* defs.h
* and of course, add stack.c and heap.c (see below). Add them to the Makefile

I believe the above is correct as I tried to document my changes as I made them. Apologies if I forgot any files (this is genuine, not a hint).


### Does the heap collide with the stack?

The previous program runs the stack into the heap. This program runs the heap into the stack. This is `heap.c`, your second test program.

```c
#include "types.h"
#include "user.h"

#define	HEAP_GULP	(1 << 14)

int main(int argc, char ** argv) {
	void * p;
	int counter = 0;
	printf(1, "Address of a stack variable: 0x%x\n", &counter);
	printf(1, "Starting descent into heap space\n");
	while ((p = malloc(HEAP_GULP)) != 0) {
		printf(1, "Iteration: %d - %d bytes added to heap - 0x%x\n", ++counter, HEAP_GULP, p);
	}
	exit();
}
```

Here is sample output:

```text
$ heap
Address of a stack variable: 0x9FFCC
Starting descent into heap space
Iteration: 1 - 16384 bytes added to heap - 0x6000
Iteration: 2 - 16384 bytes added to heap - 0xE000
Iteration: 3 - 16384 bytes added to heap - 0x16000
Iteration: 4 - 16384 bytes added to heap - 0x1E000
Iteration: 5 - 16384 bytes added to heap - 0x26000
Iteration: 6 - 16384 bytes added to heap - 0x2E000
Iteration: 7 - 16384 bytes added to heap - 0x36000
Iteration: 8 - 16384 bytes added to heap - 0x3E000
Iteration: 9 - 16384 bytes added to heap - 0x46000
Iteration: 10 - 16384 bytes added to heap - 0x4E000
Iteration: 11 - 16384 bytes added to heap - 0x56000
Iteration: 12 - 16384 bytes added to heap - 0x5E000
Iteration: 13 - 16384 bytes added to heap - 0x66000
Iteration: 14 - 16384 bytes added to heap - 0x6E000
Iteration: 15 - 16384 bytes added to heap - 0x76000
Iteration: 16 - 16384 bytes added to heap - 0x7E000
Iteration: 17 - 16384 bytes added to heap - 0x86000
Iteration: 18 - 16384 bytes added to heap - 0x8E000
Iteration: 19 - 16384 bytes added to heap - 0x96000
$
```

## What do hand in?

**MAKE CLEAN**

Zip up your whole xv6, clean, folder and submit to schoology.

## Partner rules

Have a partner. Only one partner submits code. The other submits a text file saying who the other partner is. The submitting partner must also name the non-submitting partner.
