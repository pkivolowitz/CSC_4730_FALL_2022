# Project 4 Add Guard Page to XV6

## Summary

You’re going to begin modifying how xv6 lays out process memory! And, you must write a user land program to test your work in kernel space. Specifically, you are going to add a guard page in the first 4K of memory (starting at address 0 of process memory). The utility of this is that programs that dereference a null pointer will crash. 

Write the test program first and verify this.

## Current memory layout

XV6 currently lays out process memory like this (starting at address 0 at top):

| Contents |
| --- |
| code |
| stack |
| heap |

Your job is to make programs start beyond address zero (one page to be exact) so that a
dereference of any address in the first page of memory will result in death.

The new layout should be like this:

Like this:

| Contents |
| --- |
| guard page |
| code |
| stack |
| heap |

where the code starts at the first page boundary, not on the zeroth page.

## Suggested steps

### Make a copy of XV6

Do not defile the virgin.

### Test program

The test program is very short. Declare a pointer, initialize it with NULL (must be in C not C++). Dereference the pointer. Boom. At least in Linux. Try this to verify.

Then, move the source code to the right place so that it is included in XV6. Test this.
No crash should occur.

### Figure out how xv6 sets up a process page tables

Look at how ```exec()``` works to better understand how address spaces get filled with code
(loaded from disk) and initialized. That will get you most of the way.

Also look at ```fork()```, in particular the part where the address space of the child is created by copying the address space of the parent. What needs to change (in ```fork()``` itself or a function ```fork()``` calls)?

### Detect and correct any other dependencies

The rest of your task will be completed by looking through the code to figure out where there are checks or assumptions made about the address space. Hint - one of the xv6 makefiles.

### Fun

As soon as you begin making changes, attempting to test can result in an OS crash.

### What to hand in

Zip your cleaned XV6 tree and submit it. Clean the code by doing:

```text
make clean
```

General Note: Sometimes building xv6 gets confused with some old object files and some
new. If really weird things happen, try doing the above `make` and build again. If the
problem persists, it's your problem.

Note the following: You must include a text file in the root of your XV6 tree that contains your name and your partner's name.

Only one partner submits code. The other partner submits the same text file added to XV6.

### Partner rules

Work in pairs.
