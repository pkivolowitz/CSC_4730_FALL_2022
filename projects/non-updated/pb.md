# Mutex Project (Lite)

This specification describes a project which just *barely* uses a `mutex`. Rather than concentrating on a difficult synchronization problem, this project is more of a summative challenge in using C++ threads, `getopt` and writing robust code. It is intended to be relatively straight forward, a gentle start in our learning about concurrency.

## Command line arguments

You are expected to support and implement *all* of these command line options.

### -h

Prints program usage. Your text should include any defaults and limitations on values, printed nicely.

### -z size

Specifies the size of a vector of `uint32_t`. The minimum is `(1 << 8)`. The default for this parameter (and also its maximum allowable value) is `(1 << 20)`.

### -s seed

Specifies the value of the random number generator seed. The default is to use the time-of-day. If this command line argument is given, use its value as the seed instead.

### -t threads

Specifies the number of threads to create. The minimum value (and also the default value) is 4. The maximum value is 30.

### Vetting options

You will be expected to ensure various command line option combinations make sense. Specifically, any minimums or maximums specied above must be enforced. Any violation of these should produce an error message and stop the program.

## The idea

### Big picture

This is kind of like the card game `spit`.

Some number of threads each have a list of numbers they will respond to. They each are looking at the "pile" initialized to 0. The thread that has the current value of the "pile" in its list, increments the "pile" to the next number.

Clearly, the "pile" is the shared resource that must be protected.

When a thread has "played" every number in its list, it ends.

### Dealing

Your program will create a large vector of `uint32_t`. The integers will run the range of 0 to the size of the vector - 1. In other words, something like this to start with:

```c++
for (uint32_t i = 0; i < size; i++)
    v[i] = i;
```

**After initializing the vector, you are to `shuffle` it so that the numbers are no longer consecutive. It is absoltely critical that each value from 0 to `size - 1` be in the vector only once.**

Think of this large list as a shuffled deck of cards.

Divy the vector up into nearly equal size subranges and give each subrange to one of the threads. By way of example, imagine the following scenario (using a vector size far below the minimum size of the actual program):

```text
size = 13
vector = { 11, 4, 7, 2, 9, 3, 6, 1, 10, 0, 5, 8, 12 }
threads = 4
thread[0] gets { 11, 4 and 7 }
thread[1] gets { 2, 9 and 3 }
thread[3] gets { 6, 1 and 10 }
thread[4] gets { 0, 5, 8 and 12 }
```

Notice all the threads got a roughly equal hand size for its own work. The last thread gets any strays.

### Play

Once the hands have been dealth, launch all the threads. As each thread plays a number, print out that fact. For example:

```text
$ ./a.out -t 8 -z 300
Thread:   5 hit on:        0
Thread:   7 hit on:        1
Thread:   3 hit on:        2
Thread:   0 hit on:        3
Thread:   2 hit on:        4
Thread:   3 hit on:        5
Thread:   0 hit on:        6
Thread:   0 hit on:        7
Thread:   3 hit on:        8
Thread:   5 hit on:        9
...  
Thread:   1 hit on:        294
Thread:   0 hit on:        295
Thread:   4 hit on:        296
Thread:   0 hit on:        297
Thread:   2 hit on:        298
Thread:   7 hit on:        299
$
```

Notice, the output will come out in order and with no string stomping on any other string. Also, use `iomanip` to space the strings out so as to allow for numbers with different numbers of digits to print lined up nicely.

### Ending the game

The main program will simply attempt to `join` all the threads it launched. If the program is correctly written, all threads *will* end and become joinable. When the main program has joined all the threads it launched, it will end.

## Setting expecations

My version is about 130 lines without any meaningful comments. This is stated only to set expectations, not to pose a challenge.

## Grading criteria

Grading for this project includes your meaningful commenting and a beautiful code design leveraging C++ classes, and `vector` / `iterators`.

For example, here's my `main()`:

```c++
int main(int argc, char **argv) {
	uint64_t size;
	uint32_t nthreads;
	uint64_t seed;
	IntVec numbers;

	HandleOptions(argc, argv, size, seed, nthreads);
	InitializeNumbers(numbers, seed, size);
	LaunchThreads(numbers, nthreads, size);
	JoinThreads();
	return 0;
}
```

`IntVec` is a `typedef` for `vector<uint32_t>` or more precisely, the updated C++ version of `typedef`. You don't have to do this but if you don't, you will find yourself typing `vector<uint32_t>` over and over again.

```c++
using IntVec = vector<uint32_t>;
```

You don't have to follow this outline above, of course. However, your code must be well designed. **Be specific about your types (i.e. use `cinttypes`)**.

I will be grading on MacOS command line (not `xcode`)

There can be *no* warnings generated by your code. This is the command line I will use to build your program:

```text
g++ -Wall -std=c++11 -O3 yourprog.cpp -lpthread
```

Rather than deducting 10 points, any warnings will result in a grade of 0.
