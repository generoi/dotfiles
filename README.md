Welcome!
========

To get git working correctly you should edit `.bash/local.sh` and add your own
information, such as git user name, email and github user.

```sh
export GIT_USER_NAME="oxy"
export GIT_USER_EMAIL="public@oxy.fi"
export GITHUB_USER="oxyc"

export DEFAULT_USERNAME="oxy"
export DEFAULT_HOSTNAME="minastirith"
```

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
v          vim
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
psgrep {apache}          Filter through running processes by grep regexp
extract {foo.tgz}        One command to extract all compressed formats
bu {file}                Backup file to the `.backup/` folder in your $HOME
mkcdir {foo}             Make directory `foo` and cd into it
duh                      Sort and display the size of files/directories
glgithub                 Git log with per-commit clickable GitHub URLs.
imageshadow {img.png}    Create a dropshadow on specified image.
getcertnames {foo.com}   Show all names listed in the SSL certificate of domain
= {1+(5*3)/7}            A calculator
escape                   Escape UTF-8 characters into their 3-byte format
unicode                  Decode \x{ABCD}-style unicode escape sequences
codepoint                Get a character's Unicode code point
targz                    Create a .tar.gz archive using `zopfli`, `pigz` or `gzip`
tre {dir}                List the directory tree ignoring unwanted folders
gitio {url}              Create a git.io short URL
dataurl {file}           Create a data URL from a file
extractsql --help        Parse a full mysqldump and restore a single table.
license                  Output a MIT license containing your name.
rasterize --help         Rasterize a web site to a image.
whenis                   Try to figure out when whatever date you give it is.
```

### Drush aliases

```sh
# Creates aliases to common drush commands that work in a global context:

dr               drush
ddd              drush drupal-directory
dl               drush pm-download
ev               drush php-eval
sa               drush site-alias
sa               drush site-alias --local (show local site aliases)
st               drush core-status
use              drush site-set

# Aliases for drush commands that work on the current drupal site:

cc               drush cache-clear
cca              drush cache-clear all
dis              drush pm-disable
en               drush pm-enable
i                drush pm-info
pml              drush pm-list
rf               drush pm-refresh
unin             drush pm-uninstall
up               drush pm-update
upc              drush pm-updatecode
updb             drush updatedb
q                drush sql-query

# Provides several common shell commands to work better with drush:

ddd @dev         print the path to the root directory of @dev
cdd @dev         change the current working directory to @dev
lsd @dev         ls root folder of @dev
lsd %files       ls "files" directory of current site
lsd @dev:%devel  ls devel module directory in @dev
@dev st          drush @dev core-status
dssh @live       ssh to the remote server @live points at
gitd @live pull  run `git pull` on the drupal root of @live

# Drush site alias expansion is also done for the cpd command:

cpd -R @site1:%files @site2:%files
```

Globally installed utilities
----------------------------

- `ag` [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)

  *A code searching tool similar to ack, with a focus on speed.*

  Usage: `ag "(hook_menu|hook_permissions)" /campaign/`

  Notes: ignores `log`, `tmp`, `vendor`, `sass-cache` and whatever is in your `.gitignore` by default

- `jshint` [JSHint](http://www.jshint.com/)

  *Error and code quality tool for JavaScript code*

  Usage: `jshint file.js`

- `drush` [Drush](http://drush.ws/)

  *A command line shell and scripting interface for Drupal*

  Usage: `drush`

- `wp-cli` [WP-Cli](http://wp-cli.org/)

  *A set of command-line tools for managing WordPress installations.*

  Usage: `wp`

- `mosh` [Mosh](http://mosh.mit.edu/)

  *Mosh is a replacement for ssh, designed for roaming and unstable connections.*

  Usage: just like ssh, however `mosh` must be installed on the server to you
  are connecting to. Only our development server has `mosh` installed, but you
  should definitely install `mosh` on your own computer and use it to connect.

- `fasd` [fasd](https://github.com/clvv/fasd)

  *A command-line productivity booster, offering quick access to files and directories*

  Usage: `z mu` if you've been active in the mushbarf diretory you would most
  likely `cd` into it.

Default configurations
----------------------

- `.jshintrc`: default jshint configurations.
- `.agignore`: `log`, `tmp`, `vendor`, `sass-cache`.
- `.gitignore`: `.DS_Store`, `Desktop.ini`, `*~`, `*.bak`, `*.old`.
- `.gitconfig`: some sensible defaults for `git`.
- `.drush/drushrc.php`: some sensible defaults for `drush`.
- `.vimrc`: sensible vim defaults

bootstrap.sh
------------

### Install

```sh
git clone https://github.com/generoi/dotfiles.git
cd dotfiles
./bootstrap.sh install
```

### Update

```sh
cd dotfiles
./bootstrap.sh update
```

### Options

```sh
--dry     Dry run
```
