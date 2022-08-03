# CSC 4730 Project 5

This is a simulation of a simple machine with limited memory and small
virtual address spaces. You will simulate a linear page table plus
a Translation Lookaside Buffer.

## Setting expectations

Including all, here is how my code broke down:

```text
     255    1151    7263 project.cpp
      53     147    1319 pmme.cpp
      43     154     971 include/arch.hpp
      31      71     583 include/pmme.hpp
     382    1523   10136 total
```

This is not a challenge. Your solution may vary significantly from this.
I provide this data only to set your expectations. If you find yourself
writing twice as many lines, you're doing it wrong.

## Difficulty and correspondence to OSTEP

You might find this project quite demanding. Read an internalize the
lessons in these chapters: 18, 19, 21 and 22.

## Work rules

You may work with a partner on this project. The usually rules apply:

* Your code must be submitted only by one person and must include the
names of both partners.

* The non-code-submitting partner must submit a **text** file including
the names of both partners.

## Comments about the above

You will recognize that the above sections about expectations and work
rules typically comes at the end of my specifications. This time they
appear at the beginning. This is because this project *can* be hard. If
you don't do the readings, very carefully, you will find this project
very hard.

## Your output

Your output must match mine letter for letter, right down to the `setw`
values (which I will indicate where appropriate). Any discrepancies from
my supplied output will result in massive penalties.

## How I will build you code

You must use C or C++.  These are the `g++` options I will use when
building your code:

| Option | Meaning |
| ------ | ------- |
| `-g` | enable debugging |
| `-std=c++11` | Using C++ 11 |
| `-Wall` | flag "all" warnings |
| `--pedantic` | flag *even more than "all"* warnings |

You must use these options as well or risk being blindsided by points
off for missing any warnings that might be generated.

Note the use of `--pedantic`.

## The simulated machine

[Here](./include/arch.hpp) are all the details you need to know about
the machine you're simulating:

```text
#pragma once                                                        // 1 
                                                                    // 2 
/*    Machine Architecture                                          // 3 
                                                                    // 4 
    Pages are 2048 bytes long         --- 11 bits                   // 5 
    VA Space is 32 pages              ---  5 bits                   // 6 
    Virtual Addresses are therefore   --- 16 bits                   // 7 
                                                                    // 8 
    Physical memory can fit           ---  8 pages                  // 9 
    PFN in bits                       ---  3 bits                   // 10 
*/                                                                  // 11 
                                                                    // 12 
const uint32_t PAGE_BITS    = 11;                                   // 13 
const uint32_t PAGE_SIZE    = (1 << PAGE_BITS);                     // 14 
const uint32_t PFN_BITS     = 3;                                    // 15 
const uint32_t VPN_BITS     = 5;                                    // 16 
const uint32_t VRT_PAGES    = (1 << VPN_BITS);                      // 17 
const uint32_t PHYS_PAGES   = (1 << PFN_BITS);                      // 18 
const uint32_t PHYS_SIZE    = PHYS_PAGES * PAGE_SIZE;               // 19 
                                                                    // 20 
const uint32_t VA_SIZE_BITS = VPN_BITS + PAGE_BITS;                 // 21 
const uint32_t VA_SIZE      = 1 << (VA_SIZE_BITS);                  // 22 
                                                                    // 23 
struct PTE {                                                        // 24 
    uint32_t dirty : 1;                                             // 25 
    uint32_t referenced : 1;        // UNUSED                       // 26 
    uint32_t present : 1;                                           // 27 
    uint32_t valid : 1;                                             // 28 
    uint32_t rw : 1;                // UNUSED                       // 29 
    uint32_t pfn : PFN_BITS;                                        // 30 
};                                                                  // 31 
                                                                    // 32 
struct _VA {                                                        // 33 
    uint16_t offset : PAGE_BITS;                                    // 34 
    uint16_t vpn : VPN_BITS;                                        // 35 
};                                                                  // 36 
                                                                    // 37 
struct VRT_Address {                                                // 38 
    union {                                                         // 39 
        uint16_t value;                                             // 40 
        _VA virtual_address;                                        // 41 
    };                                                              // 42 
};                                                                  // 43 
```

### Print a description of the machine

The first things you must output is a description of the machine. You
must compute any of the following values which might be derived from
other values. Your output must match:

```text
Machine Architecture:
Page Size (bits):           11
Page Size (bytes):          2048
VA Size (bits):             16
VA Size (bytes):            65536
Physical Memory (bytes):    16384
Physical Pages:             8
```

I used `setw()` for the first column with a value of 28.

There can be no magic numbers in your code other than the most obvious
of values (like 0).

## Required command line options

You must support the **required** option `-f` which has a **required**
parameter. The parameter to the `-f` option is the name of the data
file from which your program will receive input.

For example:

```text
$ ./a.out -f test0.txt
Machine Architecture:
Page Size (bits):           11
Page Size (bytes):          2048
VA Size (bits):             16
VA Size (bytes):            65536
Physical Memory (bytes):    16384
Physical Pages:             8
```

`test0.txt` is an empty file so only the machine description is printed.

Here is what you must print if the file specified by the `-f` option
cannot be opened:

```text
$ ./a.out -f foo      
Failed to open: foo
Cause: No such file or directory
```

The text following "Cause:" comes from `perror()`.

Here is what you must print if the `-f` option is missing:

```text
$ ./a.out       
Must specify file name with -f
```

All of the above will be tested by me. If there are any deviations,
points will be deducted.

## All error messages must go to `cerr` and program return code set

Any error message you print must go to `cerr`. Should you print anything
to `cerr`, your program's return code must be set to something other
than 0. Check your program's return code with:

```text
echo $?
```

## Opcodes

The data files consist of lines bearing opcodes along with an argument
(for "Read" and "Write") or an opcode with no argument. I suggest you
read the data file using `getline()` and turn each line into a
`stringstream` to pick the line apart.

Any characters beyond was is expected is to be considered a comment.
Thus, these are each OK:

```text
Read 0                     // all of this is ignored
DUMP_MMU                   // and this too
Write 10
Read 0
```

### Opcode DUMP_MMU

You are simulating an MMU (memory management unit) along with
implementing a page table for a single process. Specifically,
you're simulating a translation lookaside buffer (TLB) inside the
MMU.

The architecture of the machine tells you how many TLB entries you
need to have. Our TLB's are not as complex as real ones.

Here is the TLB structure I used - it is the minimum you need for
this program:

```c++
struct PMME {
	PMME() = default;
	bool in_use;
	uint32_t VPN;
	uint32_t PFN;
};
```

You must arrange the *right* number of these, according to the machine
definition, into a table. You will need some methods that work on the
table. In my implementation I defined 5 methods. Your solution may be
different.

When you encounter a `DUMP_MMU` you must print the contents of your
MMU's TLB matching the following format exactly:

```text
MMU:
[  0] USED VPN:    7
[  1] USED VPN:   23
[  2] USED VPN:   16
[  3] USED VPN:   28
[  4] USED VPN:   22
[  5] USED VPN:   13
[  6] USED VPN:   15
[  7] USED VPN:    9
```

Formatting:

* The first column is in a field of 3 spaces.

* The Virtual Page Number is printed in a field of 4 spaces, right
justified.

If an entry is unused, print "FREE" rather than "USED".

### Opcode DUMP_PT

When you encounter a `DUMP_PT` command, you must print the contents
of your simulated linear page table, like so:

```text
PAGE TABLE:
[  7] CLEAN PRES IN PFN:    0 
[  9] CLEAN PRES IN PFN:    7 
[ 13] CLEAN PRES IN PFN:    5 
[ 15] DIRTY PRES IN PFN:    6 
[ 16] CLEAN PRES IN PFN:    2 
[ 22] CLEAN PRES IN PFN:    4 
[ 23] CLEAN PRES IN PFN:    1 
[ 28] CLEAN PRES IN PFN:    3 
```

**Notice that only PTEs that are marked present are printed.**

Formatting:

* The first column is in a field of 3 spaces.

* The final value is printed in a field of 4 spaces, right
justified.

The second column may contain only "CLEAN" or "DIRTY".

All lines will list "PRES" since only PTE's that are marked present
are printed.

The final number represents the Physical Frame Number holding the
present page.

Notice:

```text
[  5] USED VPN:   13
```

from the MMU and

```text
[ 13] CLEAN PRES IN PFN:    5 
```

from the Page Table. Notice how they refer to each other. This
agreement must always be true.

### Opcode Read

The Read opcode specifies a virtual address.

### Opcode Write

The Write opcode specifies a virtual address.

## The "swap device"

Assume all virtual pages are already loaded on a "swap device." The
swap device doesn't really exist **but** you still have to deal with
in in two ways:

A page which is not already in memory must be swapped in.

A page selected for ejection that is dirty, must be "written back" to
the swap device.

## For both Read and Write

Your job is to perform a mock address translation given the virtual
address in the Read or Write to a physical address.

Given:

```text
Read 0
Read 1
```

The correct output (after printing the machine description) is:

```text
Read 0                                                              // 1 
VPN: 0 VA: 0 PAGE FAULT                                             // 2 
VPN: 0 VA: 0 ASSIGNING TO PFN: 0                                    // 3 
VPN: 0 VA: 0 SWAPPING IN TO PFN: 0                                  // 4 
Read 1                                                              // 5 
VPN: 0 VA: 1 SUCCESSFUL TRANSLATION TO PFN: 0                       // 6 
```

**NOTE the line numbers are not part of the output.**

Line numbers 1, 5 and 7 let us know what command has been read.

Addresses 0, 1 and 2 are all on VPN 0. Notice VPN 0 is the only virtual
page number referenced.

Line 2 says virtual address 0 is found on virtual page number 0 and
this access has caused a page fault because VPN 0 is not already
resident in memory.

Physical memory is empty right now, so the faulting page will be put
into physical frame number 0 (line 3).

Line 4 says VPN 0 is brought in from the swap device into PFN 0.

Line 5 is a read of VA 1. VA 1 is also on VPN 0.

Line 6 says that VPN 0 was found to be already in memory at PFN 0.

## Differentiating "NEWLY DIRTY" from "REPEAT WRITE"

Given:

```text
Read 0			// Page faults and gets loaded into PFN 0
Write 100		// Emits a NEWLY DIRTY
Write 200		// Emits a REPEAT WRITE
Read 300		// Emits a simple successful translation
Write 3000		// Page faults, gets loaded into PFN 1 and made dirty
```

The correct output (after the machine description) is:

```text
Read 0                                                              // 1
VPN: 0 VA: 0 PAGE FAULT                                             // 2
VPN: 0 VA: 0 ASSIGNING TO PFN: 0                                    // 3
VPN: 0 VA: 0 SWAPPING IN TO PFN: 0                                  // 4
Write 100                                                           // 5
VPN: 0 VA: 100 SUCCESSFUL TRANSLATION TO PFN: 0 NEWLY DIRTY         // 6
Write 200                                                           // 7
VPN: 0 VA: 200 SUCCESSFUL TRANSLATION TO PFN: 0 REPEAT WRITE        // 8
Read 300                                                            // 9
VPN: 0 VA: 300 SUCCESSFUL TRANSLATION TO PFN: 0                     // 10
Write 3000                                                          // 11
VPN: 1 VA: 3000 PAGE FAULT                                          // 12
VPN: 1 VA: 3000 ASSIGNING TO PFN: 1                                 // 13
VPN: 1 VA: 3000 SWAPPING IN TO PFN: 1 NEWLY DIRTY                   // 14
```

Again, the line numbers are not part of the output.

Lines 1 to 4 show a read to VPN 0 which gets loaded into memory in PFN 0.

Compare the output caused by the writes on lines 5 and 7 to the same
page. "NEWLY DIRTY" is printed when a page is first marked dirty.
"REPEAT WRITE" is printed when you notice a write to a page that is
already dirty.

Printing this information is actually a debugging aid for you.

```text
pk_paging_tlb % grep Write test3.txt | wc
       3      27     135
pk_paging_tlb % ./a.out -f test3.txt | grep NEWLY | wc
       2      22     110
pk_paging_tlb % ./a.out -f test3.txt | grep REPEAT | wc
       1      11      61
```

The "Write" opcode appears 3 times in test3.txt.

You can confirm you marked pages dirty appropriately by adding together
the number of NEWLY (2) and the number of REPEAT (1) lines.

## Page replacement algorithm

At some point, memory will become full - i.e. after some number of
different pages are references by either read or write. Additional
page references for pages not already in memory will require some
page to be kicked out of memory so that the newly references page can
be loaded in.

You must select a page in physical memory to eject.

The project uses a trivial page replacement algorithm. It simply goes
in sequence with no regard for choosing clean pages first and no regard
for pages that have been referenced recently.

[test10.txt](./test10.txt) demonstrates this.

```text
Machine Architecture:                                               // 1 
Page Size (bits):           11                                      // 2 
Page Size (bytes):          2048                                    // 3 
VA Size (bits):             16                                      // 4 
VA Size (bytes):            65536                                   // 5 
Physical Memory (bytes):    16384                                   // 6 
Physical Pages:             8                                       // 7 
Write 0                                                             // 8 
VPN: 0 VA: 0 PAGE FAULT                                             // 9 
VPN: 0 VA: 0 ASSIGNING TO PFN: 0                                    // 10 
VPN: 0 VA: 0 SWAPPING IN TO PFN: 0 NEWLY DIRTY                      // 11 
Read 2048                                                           // 12 
VPN: 1 VA: 2048 PAGE FAULT                                          // 13 
VPN: 1 VA: 2048 ASSIGNING TO PFN: 1                                 // 14 
VPN: 1 VA: 2048 SWAPPING IN TO PFN: 1                               // 15 
Read 4096                                                           // 16 
VPN: 2 VA: 4096 PAGE FAULT                                          // 17 
VPN: 2 VA: 4096 ASSIGNING TO PFN: 2                                 // 18 
VPN: 2 VA: 4096 SWAPPING IN TO PFN: 2                               // 19 
Read 6144                                                           // 20 
VPN: 3 VA: 6144 PAGE FAULT                                          // 21 
VPN: 3 VA: 6144 ASSIGNING TO PFN: 3                                 // 22 
VPN: 3 VA: 6144 SWAPPING IN TO PFN: 3                               // 23 
Read 8192                                                           // 24 
VPN: 4 VA: 8192 PAGE FAULT                                          // 25 
VPN: 4 VA: 8192 ASSIGNING TO PFN: 4                                 // 26 
VPN: 4 VA: 8192 SWAPPING IN TO PFN: 4                               // 27 
Read 10240                                                          // 28 
VPN: 5 VA: 10240 PAGE FAULT                                         // 29 
VPN: 5 VA: 10240 ASSIGNING TO PFN: 5                                // 30 
VPN: 5 VA: 10240 SWAPPING IN TO PFN: 5                              // 31 
Read 12288                                                          // 32 
VPN: 6 VA: 12288 PAGE FAULT                                         // 33 
VPN: 6 VA: 12288 ASSIGNING TO PFN: 6                                // 34 
VPN: 6 VA: 12288 SWAPPING IN TO PFN: 6                              // 35 
Read 14336                                                          // 36 
VPN: 7 VA: 14336 PAGE FAULT                                         // 37 
VPN: 7 VA: 14336 ASSIGNING TO PFN: 7                                // 38 
VPN: 7 VA: 14336 SWAPPING IN TO PFN: 7                              // 39 
Read 16384                                                          // 40 
VPN: 8 VA: 16384 PAGE FAULT                                         // 41 
VPN: 0 SELECTED TO EJECT DIRTY                                      // 42 
VPN: 0 WRITING BACK                                                 // 43 
VPN: 8 VA: 16384 ASSIGNING TO: 0                                    // 44 
VPN: 8 VA: 16384 SWAPPING IN TO PHYSICAL FRAME: 0                   // 45 
Read 2048                                                           // 46 
VPN: 1 VA: 2048 SUCCESSFUL TRANSLATION TO PFN: 1                    // 47 
Read 0                                                              // 48 
VPN: 0 VA: 0 PAGE FAULT                                             // 49 
VPN: 1 SELECTED TO EJECT                                            // 50 
VPN: 0 VA: 0 ASSIGNING TO: 1                                        // 51 
VPN: 0 VA: 0 SWAPPING IN TO PHYSICAL FRAME: 1                       // 52 
Read 18432                                                          // 53 
VPN: 9 VA: 18432 PAGE FAULT                                         // 54 
VPN: 2 SELECTED TO EJECT                                            // 55 
VPN: 9 VA: 18432 ASSIGNING TO: 2                                    // 56 
VPN: 9 VA: 18432 SWAPPING IN TO PHYSICAL FRAME: 2                   // 57 
Write 6144                                                          // 58 
VPN: 3 VA: 6144 SUCCESSFUL TRANSLATION TO PFN: 3 NEWLY DIRTY        // 59 
PAGE TABLE:                                                         // 60 
[  0] CLEAN PRES IN PFN:    1                                       // 61 
[  3] DIRTY PRES IN PFN:    3                                       // 62 
[  4] CLEAN PRES IN PFN:    4                                       // 63 
[  5] CLEAN PRES IN PFN:    5                                       // 64 
[  6] CLEAN PRES IN PFN:    6                                       // 65 
[  7] CLEAN PRES IN PFN:    7                                       // 66 
[  8] CLEAN PRES IN PFN:    0                                       // 67 
[  9] CLEAN PRES IN PFN:    2                                       // 68 
MMU:                                                                // 69 
[  0] USED VPN:    8                                                // 70 
[  1] USED VPN:    0                                                // 71 
[  2] USED VPN:    9                                                // 72 
[  3] USED VPN:    3                                                // 73 
[  4] USED VPN:    4                                                // 74 
[  5] USED VPN:    5                                                // 75 
[  6] USED VPN:    6                                                // 76 
[  7] USED VPN:    7                                                // 77 
```

Lines 8 through 39 show the first 8 pages being loaded into memory.
Memory is now full. 

Line 40 references the 9th page. Lines 42 and 43 report that PFN 0 has
been selected for ejection and that the page found there was dirty so
has to be written back to the swap device.

Compare this to lines 50 and 51 where the page being ejected was clean.

## Self validation

You are responsible for writing code to sanity check your machine state.

For example, you must write a number of checks including this one:

* You read an opcode that refers to VPN *n*.

* You check the page table to discover that VPN *n* is not marked
present.

* You better check the MMU to confirm that VPN *n* is not in memory
since it is not present.

How about the opposite? A VPN is marked present in the page table but
isn't found in memory?

How about you finding a VPN is marked present and in PFN *x* but when
you check physical memory, you find the page is loaded into PFN *y*?

If you trip any of these conditions, you have a bug. These conditions
should never ever happen if your code is working properly.

## Running my tests

```text
$ cd tests
$ ./expected_output_test.bash -i test_10 -a ../a.out
-lots of output-
Differences:
PASSED
Test finished
```

## Writing your own tests

**Professor K sez:**

![sez](./professor_k_sez.jpg)

**As you implement a feature, you should write your own test that tests
that feature.**

**Write a little. Test a little.**
