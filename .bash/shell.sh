# Disable CTRL-s (stop output)
stty stop ''

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Correct minor spelling errors in 'cd' commands.
shopt -s cdspell

# Enter directories by default, i.e. no `cd`
shopt -s autocd

# Attempt to save all lines of a multiple-line command in the same history entry.
shopt -s cmdhist

# Expand aliases for non-interactive shells.
shopt -s expand_aliases

# Don't try to find all the command possibilities when hitting TAB on an empty line.
shopt -s no_empty_cmd_completion

# Include dotfiles in globbing.
shopt -s dotglob

# Recursive globbing
shopt -s globstar

# Case-insensitive globbing.
shopt -s nocaseglob

# Extended globbing patterns.
# http://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching
shopt -s extglob

# Do not overwrite files when redirecting using ">".
# Note that you can still override this with ">|".
set -o noclobber

# Vi-like behavior for bash
set -o vi

# nvm
[[ -s ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# rvm
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

command -v fasd > /dev/null && eval "$(fasd --init auto)"
command -v grunt > /dev/null && eval "$(grunt --completion=bash)"

command -v git > /dev/null && {
  if [[ -n "$GIT_USER_NAME" ]]; then
    git config --global --unset-all user.name
    git config --global --add user.name "$GIT_USER_NAME"
  fi
  if [[ -n "$GIT_USER_EMAIL" ]]; then
    git config --global --unset-all user.email
    git config --global --add user.email "$GIT_USER_EMAIL"
  fi
  if [[ -n "$GITHUB_USER" ]]; then
    git config --global --unset-all github.user
    git config --global --add github.user "$GITHUB_USER"
  fi
}
