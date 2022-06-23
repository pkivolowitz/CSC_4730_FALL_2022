# Add a system call to xv6

You are going to add a system call to xv6.

## int `count(void)`

The system you will add is named `count()`. It returns an integer which indicates the number of used process table slots. The process table is found within a structure called `ptable`. Consult line 10 of proc.c.

You are reminded that the structure called `proc` contains a field called `state`. This is an `enum` called `procstate`. `procstate` is defined on line 35 of `proc.h`. You will note the first value, `UNUSED`. All other values are "used."

## Unreasonably big hint

The files you will modify are:

* `syscall.h`
* `syscall.c`
* `user.h`
* `usys.S`
* `proc.c` put your main implementation here
* `sysproc.c`
* `Makefile`

## Userland test program

In order to test your new kernel, you must add a userland test program. Call your test program `test_count.c`. `test_count` will become the name of the executable. To include your userland test program in the xv6 build you must modify `Makefile`.

Line 168 of the `Makefile` begins a listing of the names of the userland programs. Add `_test_count` to the list exactly like the other programs. Note the underscore.

Here is the source code to the test program:

```c
#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"

int main() {
    int c = count();
    printf(1, "count returns: %d\n", c);
    exit();
}
```

### `printf`

`printf` in xv6 is a shadow of its Linux self. The first argument is the file descriptor to which to write. The second argument is a template string. The third argument (and any additional arguments) are values to be printed.

Any questions about using `cout` will be responded to with laughter.

### Ending programs with `exit()`

Again, xv6 is not a real Linux. You must exit programs using the `exit()` system call. Ending with the typical `return 0` will produce an error message in the limited shell.

### How to use the test program

```text
$ sh
$ sh
$ sh
$ test_count
count returns: 6
$ ^d $ test_count
count returns: 5
$ ^d $ test_count
count returns: 4
$ ^d $ test_count
count returns: 3
$
```

`^d` means control-d

### Interpreting test program output

The above shows you in a shell, launching another shell, and another and another.

Run the test program and it prints 6. The used process table slots correspond to these programs:

* init
* sh
* test_count
* sh
* sh
* sh

Use `^d` to exit one shell and run the program again. Now you're at 5.

Use `^d` to exit one shell and run the program again. Now you're at 4.

Use `^d` to exit one shell and run the program again. Now you're at 3.

I will award 5 points of extra credit if you record yourself singing a corrupted version of 99 bottles of beer on the wall that instead mimics the above. Post the video to youtube to receive the extra credit.

## Printing debugging output from *inside* the kernel

Use `cprintf` to print from inside the kernel. This is your principal debugging tool. `cprintf` dispenses with the first argument used with `printf`. Here is an example:

```c
cprintf("allocuvm out of memory\n");
```

## Build and launch of xv6

```text
make qemu-nox
```

If the build is successful, you will launch straight into xv6.

## Exiting qemu

```text
^ax
```

## xv6 is **not** Linux

There are very few programs in xv6. Most of the programs you are accustomed to are absent. Those that are present may be mere shadows of their Linux selves. For example, the shell has essentially no features you are accustomed to.

## Work rules

Use a partner.

## What to hand in

The partner who hands in the code will supply a ZIP file to schoology.

You must do this to create your ZIP file:

```text
$ rm -f p1.zip
$ make clean
$ zip p1.zip *
```

I'll award zero points for a project that doesn't build.

The partner that is not handing in code must instead hand in a `.txt` file containing your partner's name.
