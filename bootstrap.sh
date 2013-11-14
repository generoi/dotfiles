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
    echo "rm -f $new"
    echo "ln -sf $existing $new"
  else
    mkdir -p $(dirname $new)
    rm -f $new
    ln -sf $existing $new
  fi
}

update() {
  git pull origin master && \
    git submodule init && \
    git submodule update
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

case $1 in
  install) install ;;
  update) update ;;
  *) echo "Usage: bootstrap.sh [install|update]"; exit 1
esac

popd > /dev/null

