#!/bin/bash

pushd "$(dirname "${BASH_SOURCE}")" > /dev/null

dry=0
dest=$HOME

symlink() {
  local existing=$(readlink -f $1)
  local new=$2
  if ((dry)); then
    if [[ ! -d $(dirname $new) ]]; then
      echo mkdir -p $(dirname $new)
    fi
    [[ -f $new ]] && echo "rm -f $new"
    echo "ln -sf $existing $new"
  else
    mkdir -p $(dirname $new)
    [[ -f $new ]] && rm -f $new
    ln -sf $existing $new
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
    git pull origin master && \
      git submodule init && \
      git submodule update

    return 0
  else
    return 1
  fi
}

install() {
  for f in $(find . -type f -not -wholename '*.git/*' -not -name 'bootstrap.sh' -not -name 'README.md'); do
    symlink $f $dest/${f#./}
  done
  echo "Done!"
}

if [[ $1 == "--dry" ]]; then
  dry=1
  set -- "$2"
fi


update && install

popd > /dev/null

