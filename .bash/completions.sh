# Shell completions.
if ! shopt -oq posix; then
  for file in /etc/bash_completion /usr/local/etc/bash_completion.d/* ~/.bash_completion.d/*; do
    [ -r "$file" ] && source "$file"
  done
fi

complete -cf sudo
complete -o nospace -A command killall

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "$HOME/.ssh/config" ]; then
  complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh mosh
fi

# Fasd
[ hash fasd 2>/dev/null ] && _fasd_bash_hook_cmd_complete v m j o

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g
fi
