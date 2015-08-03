for file in ~/.bash/{local,functions,shell,aliases,prompt,drush,exports,ssh-agent,overrides}.sh; do
  [ -r "$file" ] && source "$file"
done
unset file
