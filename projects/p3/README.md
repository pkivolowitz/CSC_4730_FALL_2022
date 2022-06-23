# Summative Synchronization Project

In this project you will build a semaphore from a condition variable and a mutex.

C++ version 20 is supposed to have semaphores built in but Apple happened.

Pthreads has semaphores but Apple happened.

Hence, we have to write them ourselves. Because Apple.

Thankfully, our textbook comes to the
[rescue](https://pages.cs.wisc.edu/~remzi/OSTEP/threads-sema.pdf).

## Idea - Hot Potato

Players gather around a circle and pass something between them as
quickly as possible. Called, Hot Potato, imagine the item being
tossed around is a potato straight out of the fire.

In our game, we will support any number of potatoes simultaneously
from 1 up to the number of players.

## Requirements

We are going to use pthreads threads and synchronization primitives.

The types you'll use include:

* `pthread_mutex_t`

* `pthread_cond_t`

* `pthread_t`

The function calls you must include include:

* `pthread_create`

* `pthread_mutex_lock`

* `pthread_cond_signal`

* `pthread_mutex_unlock`

* `pthread_cond_wait`

You need a mutex for implementing the semaphore and another one
which you must use to ensure no thread's output stomps over
another thread's output.

## Command Line Options

You must support:

`-h` to print help / usage.

`-n` to set the number of players. The value defaults to 4. It cannot
be less than 1 or more than 32.

`-p` to set the number of potatoes. The value defaults to 1. It cannot
be less than 1 nor more than the number of players.

You must handle each of the above and do appropriate error checking
Should any errors be found you must print some reasonable error
messages and quit.

## Data Structures

You will need, perhaps, C++ `vectors` or `arrays` to hold counters,
possession values and pids.

Resize the vectors to match the number of players. In this way,
every thread can update their own values without risk of
overwriting the values of another thread.

The counters vector holds the number of times each player (thread)
has held the potato. The possession vector of `bool` has a `true`
in the i'th position only when the i'th player is in possession of
the potato.

## Discussion

The semaphore must be programmed to allow the number of hot
potatos specified by the user on the command line to be active
at any one time.

### Semaphore Functions

Your implementation of semaphores should follow these
signatures:

```c++
void SemInit(Sem & s, int32_t initial_value);
void SemPost(Sem & s);
int32_t SemWait(Sem & s);
```

### Output During Set Up

You must print status information prior to releasing the
potatos. For example:

```text
Number of children: 4
Number of potatos:  1
Child:  0 has started
Child:  2 has started
Child:  1 has started
Child:  3 has started
Hit return to put potatos in play: 
```

### Sleeping

`sleep()` takes a number of seconds as its parameter. Sleeping
for seconds would make for a very boring demo. Instead use
`usleep()` which takes microseconds as its argument. The main
loop, for example, prints 4 times per second. This equates to
250,000 microseconds.

The "players" must sleep between 1,000 and 50,000 microseconds
while holding a potato and also after releasing the potato. Note
the use of `rand()`.

### Infinite Loops

The players and the main loop should be infinite loops. Terminate
the application by ^c.

### ^s / ^q

Control-s suspends terminal output. Control-q starts it again.
This can be used as a "pause" button while your program is
running. Use this to count asterisks.

### Building Your Program

[Here](./makefile) is a good `makefile` which will build a single
executable out of whatever .cpp files are in the directory while
also building a dependency chain (so that should any .h or .hpp
files be modified, the right files will be rebuilt). There is
also a `clean` target to clean up the directory. The application
will be built with `pthread` linked in. On the Mac this isn't needed
but it doesn't hurt. On Linux, it is necessary.

### Setting Expectations

My implementation, without many comments, but with blank lines
and all self-contained is 168 lines. This is not a challenge. 
Rather it is to set your expectations. If you, for example,
find yourself writing double this number of lines, you should
ask yourself if you aren't either mistaken or are working too
hard.

## Output

Your threads are running asynchronously, updating their own
values in the counter and possession vectors.

Four times per second, the main thread will print out the values.

Here is an example:

```text
*1380 *1322 *1346  1338  1341 *1325  1332  1320 variance: 4.35
```

Notice there are 8 numbers before the word "variance". These
numbers indicated the number of times each thread has hold of
a hot potato.

Notice four numbers are preceded by "\*". These are the players
who are in possession of a hot potato *right now*. **NOTE** that
the numbers of "\*" **might be less** than the number of hot
potatos but **will NEVER** be more. If you see more "\*"
than the number of potatos, you have a bad bad bug.

The "variance" is the largest value minus the smallest value
divided by the largest value times 100. Over time, as the
other numbers are grow, the variance will get smaller. If
it does not get smaller over time, you have a bug.

[Here](https://youtu.be/L8NWEZCKJMk) is a video showing the
output of the project as it runs.

## Work Rules

You may work with a partner on this project. One partner
must turn in the code. The code must contain the names of
both partners. Failure to include your names in the code
will result in a five point deduction.

The other partner must turn in a text
file containing the name of the other partner. Turning
in a non-text file (a file that is text and ends in .text)
will result in a five point deduction.

If you choose not to work with a partner, state this
along with your name in your source code file.
