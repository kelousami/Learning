# Theory

## What is shell ?
It's a _user interface_ for access to an operating system's services.
It may be a _command line interface_ __CLI__ or a _graphical user interface_
__GUI__.

It's a layer around the operating system _kernel_.

## Unix shell
Is a _commmand line interpreter (CLI)_
Is both an __interactive command language__ as well as a __scripting
programming language__.

## History
The first Unix shell was written by _Ken Thompson_, between 1971 and 1975.
It was modeled after _Multics_ shell, itself modeled after _RUNCOM_ program.
The _"rc"_ suffix on some Unix configuration files is derived from _RUNCOM_.
For example Vim editor still uses .vimrc file to determine its initial
configuration.
_RUNCOM_ (say RUN COMmands) was made by Louis Pouzin (a french computer
scientist) and may be considered the first shell.

## Variants of Shell
Almost all shells fall within two classes: those derived from Bourne Shell
__sh__ and those derived from C Shell __csh__.

Nerly evey Unix system has these two shells installed, but may have several
others: bash, ksh, zsh or dash.

    $ cat /etc/shells
    # /etc/shells: valid login shells
    /bin/sh
    /bin/dash
    /bin/bash
    /bin/rbash

### Bourne shell __sh__
Developed by _Stephen R. Bourne_.

#### Korn shell __ksh__
Developed by _David Korn_.
It's based on the original Bourne shell source code.

#### Bourne again shell __bash__ 
_POSIX_ compliant shell, mainly based on _sh_ (_sh_ compatible) but uses 
features from _ksh_ and _csh_ as well.

_POSIX_ stands for __Portable Operating System Interface__. It aims to provide
a set of standards and APIs for operating systems programs compliance.

#### Debian Almquist shell __dash__
_Kenneth Almquist_ developed a clone of the Bourne shell, mainly to overcome
copyright issues surrounding it.

### C shell __csh__
Developed by _Bill Joy_.
Criticizes _sh_ to be less suitable for interactive use. Thus _csh_ is
superior in that matter, even Stephen Bourne acknowledge superiority of _csh_
in inetractive use cases. But he also stated that _sh_ is superior 

# __bash__ scripting

## Basics & variables

_#!/bin/bash_ is placed in the first line to specify which shell to use.

_Variables_ are declared _x=value_ and used _$x_ to get the value. 
No declared types and no space between _x_ and _=_.

_read_ is used to get _stdin_ from the user.
For example:
    #!/bin/bash
    echo "Enter x"
    read x
    echo "You enterd $x"

_$?_ gets the previous command's return value: 0 for success and !0 for error.

_Backticks_ `` are used to hold expression to be evaluated before used.
For example:
    $ echo ls
    ls
    $ echo `ls`
    file1 file2 ..

_$(command)_ works the same as backticks.
    $ echo ls
    ls
    $ echo $(ls)
    file1 file2 ..

_let_ is used for integer arithmetic. It only calculates integers (division is
integer division).
For example:
    $ x=2;y=2;let "z = $x + $y"; echo $z
    4 
    $ x=1;y=2;let z=$x/$y; echo $z
    0

_bc_ is used as command line calculator, it calculates decimals.
_scale_ is used to specify the floating point precision.
For example:
    $ echo 2 + 2 | bc
    4
    $ echo 1 / 2 | bc
    0
    $ echo "scale=3; 1 / 2" | bc
    .500

## Conditionals

### Conditional operators
#### Relational operators (on numeric values)
    _-eq_ is equivalent to logical _==_
    _-ne_ is equivalent to logical _!=_  
    _-gt_ is equivalent to logical _>_
    _-lt_ is equivalent to logical _<_
    _-ge_ is equivalent to logical _>=_
    _-le_ is equivalent to logical _<=_




### _if_ statement
#### Basic syntax

    if [condition]; then
     command
     ...
    fi


































