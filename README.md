If you don't like standard "find" program than this utility is for you!

It allows you to do recursive search in current directory of files that match Perl m// regexp that you specify.

You can add similar alias to your .bashrc (that leads to this script):
```shell
alias gitls="perl ~/scripts/myfind.pl"
```
Then you can just write:
```shell
myfind whateveryouwant
```
And it will output you the list of files in current directory which filenames match m/whateveryouwant/ regexp.

Here's an example output of this utility: 

![Example output of myfind utility](/myfind.png?raw=true "Example output")

Tested:
- in roxterm on Ubuntu 14.04
