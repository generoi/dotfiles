#!/bin/bash

pushd "$(dirname "${BASH_SOURCE}")" > /dev/null

dry=0
dest=$HOME
rc=
changed=0

realpath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

symlink() {
  local existing="$(realpath "$1")"
  local new=$2
  if ((dry)); then
    if [[ ! -d $(dirname $new) ]]; then
      echo mkdir -pv $(dirname $new)
    fi
    if [[ -f $new ]] && ! cmp $new $existing; then
      echo "rm -fv $new"
    fi
    if [[ ! -f $new ]]; then
      echo "ln -sfv $existing $new"
      ((changed++))
    fi
  else
    mkdir -pv $(dirname $new)
    if [[ -f $new ]] && ! cmp $new $existing; then
      rm -fv $new
    fi
    if [[ ! -f $new ]]; then
      ln -sfv $existing $new
      ((changed++))
    fi
  fi
}

dirty() {
  if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != ""  ]]; then
    return 0
  else
    return 1
  fi
}

update() {
  if ! dirty; then
    echo "Fetching updates..."
    git pull origin master && \
      git submodule init && \
      git submodule update

    return 0
  else
    echo "Repository is dirty, cannot update."
    return 1
  fi
}

install() {
  echo "Installing..."
  for f in $(find . -type f -not -wholename '*.git/*' -not -name 'bootstrap.sh' -not -name 'README.md'); do
    symlink $f $dest/${f#./}
  done
  echo "Done!"
}

if [[ $1 == "--dry" ]]; then
  dry=1
  set -- "$2"
fi

update && install && rc=0 || rc=3

popd > /dev/null

if [[ $changed -eq 0 ]]; then
  echo "No changes done."
else
  echo "$changed files changed."
fi

exit $rc
