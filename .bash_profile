for file in ~/.bash/{local,functions,shell,completions,aliases,prompt,exports,ssh-agent,overrides}.sh; do
  [ -r "$file" ] && source "$file"
done
unset file
