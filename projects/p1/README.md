# CSC 4730 Project 1 - Fork, exec, pipes and redirection

## Objectives

You will master several key operating systems services. These are:

• fork - how new processes are created

• exec - how new programs are loaded

• pipe - a means of interprocess communication

• redirection - how input and output can be manipulated with the
knowledge of an application

## Deadlines

You have one week to complete this assignment.

One grace day is available. Use it as a last resort. Using the grace day
may lead to you falling behind.

Beyond the grace day, projects will not be accepted.

## Overview

Rather than build a simple shell utilizing a shell-like command syntax,
you will use command line options. For example:

```$ myshell -d /bin -1 ls -2 wc -o /tmp/output.txt```

This command line will run the program `ls` ('-1') piping its output to
`wc` (`-2`) which writes its standard output into /tmp/output.txt
(`-o`). The directory in which these commands should execute is /bin
(`-d`).

In a real shell the above command line would look like this:

```$ pushd /bin; ls | wc > /tmp/output.txt; popd```

Coding this project using real shell syntax would mean many hours of
your time would be devoted to parsing  the shell syntax and not learning
operating system goodness.

## Required command line options

Command line options can occur in any order. You must *implement* the
following:

`-d` followed by a path to a directory - the command or sequence of
commands should start in the named directory. It is an error if the
directory does not exist or the path does not lead to a directory. If
this option is not present, the current working directory is unchanged.
This is the real shell equivalent of `pushd` followed later by a `popd`.

`-i` followed by a path to a file - this file will be wired into the
standard input of the first program in the sequence. This is optional.
If not given, the standard input is left alone. It is an error if the
file path is not valid or the file fails to open. This is the real shell
equivalent of ‘<’.

`-o` followed by a path to a file - this file will be wired into the
standard output of whatever program is last in the sequence. This is
optional. If not given, the standard output is left alone. It is an
error if the file path is not valid or the file fails to open. The file
is opened in overwrite mode. Be careful. This is the real shell
equivalent of ‘>’.

`-a`	followed by a path to a file - this file will be wired into the
standard output of whatever program is last in the sequence. This is
optional. If not given, the standard output is left alone. It is an
error if the file path is not valid or the file fails to open. This
differs from -o in that the file is to be opened in append mode. This is
the real shell equivalent of ‘>>’.

*NOTE: if both -o and -a are given, whichever comes last takes
precedence.*

`-1`	followed by a path of a program to run. This **must** be
provided. It is an error if the path does not lead to an executable
program.

`-2`	followed by a path of a program to run. This is optional. If
given, it receives its input from a pipe from the preceding program. It
is an error if the path does not lead to an executable program.

`-p`	this command line option does not take an argument. It is
optional. If given, it prints the current working directory. See the
`getcwd()` function.

## Optional command line options

`-v`	this command line option does not take an argument. It is
optional. If given, it turns on any additional debugging print out you
might want. I will not test this and you are not required to implement
it. Make sure debugging output is NOT present if this option is NOT
given.

## Mode of operation

If more than one executable program is specified, your program must use
the `pipe()` system call to wire together standard out of the first
program to the standard in of the second.

Your program must use `fork()` and some variety of `exec` (specifically
`execvp()`) appropriately either one or two times.

Your program must correctly wire up the standard input of the first
executable program if requested.

Your program must correctly wire up the standard output of the last
executable program if requested.

Your program must wait for the programs you’ve run to exit and print
their return codes.

## Sample output

```text
$ ./a.out
Missing required command line option -1
$

$ ./a.out -1 ls
a.out  main.cpp  main.d  main.o  makefile  README.md  foo.code-workspace
Child 1: 12191 returns: 0
$

$./a.out -1 ls -2 wc
      7       7      69
Child 2: 12194 returns: 0
Child 1: 12193 returns: 0
$

$ ./a.out -i main.cpp -1 wc
 196  653 4860
Child 1: 12252 returns: 0
$

$ # Notice difference between -a and -o.
$ # The -o and -a options are dangerous. Who among you 
$ # will be first to lose their source code? We'll see
$ ./a.out -i main.cpp -1 wc -2 wc -o danger.txt
Child 2: 12656 returns: 0
Child 1: 12655 returns: 0
$ cat danger.txt 
      1       3      15
$ ./a.out -i main.cpp -1 wc -2 wc -a danger.txt
Child 2: 12672 returns: 0
Child 1: 12671 returns: 0
$ cat danger.txt 
      1       3      15
      1       3      15
$ ./a.out -i main.cpp -1 wc -2 wc -o danger.txt
Child 2: 12686 returns: 0
Child 1: 12685 returns: 0
$ cat danger.txt 
      1       3      15
$

$ ./a.out -1 ls
a.out  danger.txt  main.cpp  main.d  main.o  makefile  README.md  foo.code-workspace
Child 1: 12755 returns: 0
$ ./a.out -1 ls -d ~
courses  Desktop  Documents  Downloads	Music  Pictures  Public  src  Templates  Videos
Child 1: 12758 returns: 0
$

$ # some errors
$ ./a.out -1 does_not_exist
Prog 1 exec failed.
Child 1: 12760 returns: 1
$ ./a.out -i does_not_exist -1 wc
Could not open redirected input file: No such file or directory
Child 1: 12762 returns: 1
$ 
```

Nothing in this specification says you must pass custom command line
arguments to either program 1 or program 2. You are not to do so however
you must correctly pass a minimal argc and argv.

## Hint

In a standard shell, execute

```sleep 1 | sleep 1 | sleep 1 | sleep 1 | ps -l```

(the last command is `ps` dash lowercase L).

Examine the process ID columns and parent process ID columns. This may
suggest to you how to structure your code governing who forks who. *To
put the potato on the fork, this is wrong: parent forks child 1 - child
1 forks child 2.*

## Hint

You'll need to use at least these system calls:

```text
fork()
execvp()
pipe()
dup() and / or dup2()
close()
open()
getcwd()
```

You will need to use:

```text
getopt()
```

A tutorial on how to use `getopt()` if you don't already know how, is
located [here](./getopt.cpp).

## What to Hand In

Zip your makefile and all of your .c and / or .cpp source files and any
header files into a single zip file containing NO sub-folders. If your
zip file contains a subfolder, I will remove 5 points.

## Partners

Only 1 person should hand in code. The code should clearly state who the
partners are in a comment at the top of the main source file.

The non-code-submitting partner must submit a text file “partner.txt”
that states who the partners are. Not a Word file. Not an HTML file. Not
a PDF file. A text file.

Failure to list partners correctly as described above removes 5 points
from your grade.

Every semester in every class I have ever taught that allowed partners
on projects, there have been partnerships that didn't work. For example:

* One partner ends up doing all the work, or

* One partner doesn't do what they committed to and the project is
unfinished or broken because of this

Both partners get the same grade without exception.

**It is up to YOU to hold your partners to their commitments.**

Further, if you have a partner in this project who doesn't pull
their weight, please do not choose them again for future projects.
If you do, you're just asking to be let down again. And, this will be
entirely ON YOU.
