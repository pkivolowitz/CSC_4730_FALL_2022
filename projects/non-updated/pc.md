# Fleegman's Dillema

This is a variation on a very famous computer science problem. My variation is called Fleegman's Dillema named for the famous philosopher Guy Fleegman.

Guy invites four of his friends to play his favorite flugelhorn quintet. What makes this quintet unique is that each player must be in possession
of two flugelhorns in order to play. Guy and each of his friends bring but one flugelhorn so that there are five horns for five players. 

Guy's idea is to
arrange the players around a circular table with a flugelhorn between each player. When a player wants to play, Guy suggests a player picks up the flugelhorn
to their left and then the flugelhorn to their right. Only when the player has both flugelhorns can they play. They will play for a while, and then put both
flugelhorns down.

You are to write a program that simulates Guy's quintet. Instead of players, you will have five threads. Instead of flugelhorns, you will have five mutexes.

First, you are to implement Guy's algorithm exactly. When thread *n* wants to play, it must acquire lock *n* and then lock *n + 1* (with you accounting for wrap around).

If you do this correctly, you will deadlock. This is Fleegman's Dilemma. You must demonstrate that you can deadlock using Guy's algorithm.

You are then tasked solving Fleegman's dilemma in two different ways.

1. One solution must use `try_lock`. This solution cannot deadlock.

2. The other solution must acquire the same two locks as before but you are not required to use Fleegman's algorithm (thread *n* acquires lock *n* and then lock *n + 1* with you accounting for wrap around). This solution cannot deadlock.

You must be able to demonstrate all three in the same program, albiet one at a time. Do this with command line arguments.

| argument | algorithm |
| -------- | --------- |
| g | Fleegman's Algorithm |
| t | `try_lock` based solution |
| o | *other* lock based solution |

Also support `-h` to print some help text.

## C++ 11

You are to use C++ 11 mutexes and not pthreads directly.

## Yield after playing

After putting down both flugelhorns, each player voluntarily yields the CPU using `sched_yield()`.

## Exiting the program

The program has no exit. To stop your program using ^C or other means to kill the program.

## Protect `cout`

Protect `cout` with a `mutex` so that no output will overlay any other output.

## Guy and his friends are greedy

Each player will play only long enough to print that they are playing and then will yield and immediately try to play again.

## Work Rules

Work is to be done solo. No partners this time.

## Setting expectations

My solution is 110 lines. This is not a contest. I provide this information only to set your expectations. If you write 124,215,623 give-or-take lines of code, you know you've written too much.