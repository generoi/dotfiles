Welcome!
========

To get git working correctly you should add `~./.gitconfig.local` where you
configure your `user.email`, `user.name` and `github.user` values.

    [user]
      name = Oskar Schöldström
      email = m@oxy.fi

    [github]
      user = oxyc

Making changes
----------------

If you want to take over the management of your dotfiles you are free to do so
by editing whatever you want. But if you want to receive updates, do your
changes in `.bash/local.sh` and `.bash/overrides.sh`, by doing so the system
recognizes that you have not made changes and pulls in updates when told by an
administrator.

This works by cloning `https://github.com/generoi/dotfiles.git` into
`~/.dotfiles` and symlinking all files to your `~/` directory. When an update
is available, the system goes into your `~/.dotfiles` folder and runs `git
checkout` and exiting if there are local changes.

Functions and aliases
---------------------

### Aliases

*These are shell shortcuts you can use instead of the regular command*

You can edit them or add more in the `.bash/aliases.sh` file.

```sh
..         cd ..
...        cd ../..
....       cd ../../..
.....      cd ../../../..
ll         list all files with human readable sizes ls -lah
lsd        list all directories
clean      recursively delete .DS_Store files.
aptail     tail the apache error log

g          git
ga         git add
gp         git push
gpa        git push --all
gu         git pull
gl         git log
gg         git log --decorate --oneline --graph --date-order --all
gs         git status
gd         git diff
gdc        git diff --cached
gm         git commit -m
gma        git commit -am
gb         git branch
gba        git branch -a
gc         git checkout, master by default unless followed by branch.
gcb        git checkout -b

z          search for most frecently used directories and cd into it
zz         same as above but does it interactively
v          search for most frecently used file and open it with vim
vv         same as above but does it interactively
o          search for most frecently used files and open with default application
oo         same as above but does it interactively

ip         show ip
ips        list all local ips
bf         list 10 biggest files in your current directory
urlencode  urlencode a string
meminfo    show readable RAM information

week       show week number

GET        make a GET request
HEAD       make a HEAD request
POST       make a POST request
PUT        make a PUT request
DELETE     make a DELETE request
TRACE      make a TRACE request
OPTIONS    make an OPTIONS request
```

### Shell functions

These are located in `.bash/functions.sh`, feel free to modify/add.

```
codepoint                Get a character's Unicode code point
duh                      Sort and display the size of files/directories
escape                   Escape UTF-8 characters into their 3-byte format
extract {foo.tgz}        One command to extract all compressed formats
fs {foo}                 Determine size of a file or total size of a directory
getcertnames {foo.com}   Show all names listed in the SSL certificate of domain
gf                       Git log with per-commit clickable GitHub URLs.
gz                       Compare original and gzipped file size
have                     Whether or not we have a command
psgrep {apache}          Filter through running processes by grep regexp
targz                    Create a .tar.gz archive using `zopfli`, `pigz` or `gzip`
tre {dir}                List the directory tree ignoring unwanted folders
unidecode                Decode \x{ABCD}-style unicode escape sequences
vag {pattern}            Open all files found with `ag` in vim.
= {1+(5*3)/7}            A calculator
```

bootstrap.sh
------------

### Install

```sh
git clone https://github.com/generoi/dotfiles.git
cd dotfiles
./bootstrap.sh
```

### Update

```sh
cd dotfiles
./bootstrap.sh
```

### Options

```sh
--dry     Dry run
```
