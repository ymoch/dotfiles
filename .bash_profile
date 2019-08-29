# Aliases.
alias ll='ls -l'

# Pyenv.
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

# Homebrew.
if which brew > /dev/null; then
  # Bash Completion.
  if prefix=$(brew --prefix bash-completion); then
    source "$prefix/etc/bash_completion"
  fi

  # Coreutils.
  if prefix=$(brew --prefix coreutils); then
    export PATH="$prefix/libexec/gnubin:$PATH"
    export MANPATH="$prefix/libexec/gnuman:$MANPATH"
  fi

  # Findutils.
  if prefix=$(brew --prefix findutils); then
    export PATH="$prefix/libexec/gnubin:$PATH"
    export MANPATH="$prefix/libexec/gnuman:$MANPATH"
  fi
fi
