# Ecl

Ecl helps to run your Erlang code without making a lot of preparations. It also
can make your code a command line tool.

## Usage

Consider a simple example. Imagine you want to write a function that reverses
a list, but do not want to write anything except the algorithm itself. Also
you want to have a command line tool from your code installed into the system.

### Code

Let's name our project "rev" and edit a module file for it:

```
$ make edit rev
```

This opens "vi" with a file of the following content:

```
-module(ecl_rev).
-export([run/1]).

run(Arg) -> Arg.
```

We can already run this code. Let's save and close the file and run it:

```
$ make run rev [1,2,3,4,5]
[1,2,3,4,5]
```

Well, that did nothing with our list as expected, so let's do the actual job.
Edit file again:

```
$ make edit rev
```

and modify it by adding the reversing code:

```
-module(ecl_rev).
-export([run/1]).

run(Arg) -> lists:reverse(Arg).
```

Save and run again:

```
$ make run rev [1,2,3,4,5]
[5,4,3,2,1]
```

We are done.

### Command line tool

Having the command line tool of our code in the system as simple as:

```
$ make install
```

Now you can run your "reverse" anywhere pretty much the same way:

```
$ ecl run rev [1,2,3,4,5]
[5,4,3,2,1]
```

Just "ecl" instead of "make".

## Uninstall

To uninstall:

```
$ make uninstall
```
