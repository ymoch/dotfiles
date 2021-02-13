# Aliases.
alias ls='ls --color'
alias ll='ls -l'

# Pyenv.
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

# Poetry
if [ -f $HOME/.poetry/env ]; then
  source $HOME/.poetry/env
fi

# Homebrew.
if which brew > /dev/null; then
  readonly _brew_opt=$(brew --prefix)/opt

  function _brew_register_source() {
    local script="${1:?}"
    if [[ -f "$script" ]]; then
      source "$script"
    fi
  }

  function _brew_register_command() {
    local package="${1:?}"
    local prefix="$_brew_opt/$package"

    local gnubin="$prefix/libexec/gnubin"
    if [[ -d "$gnubin" ]]; then
      export PATH="$gnubin:$PATH"
    fi
    local man="$prefix/share"
    if [[ -d "$man" ]]; then
      export MANPATH="$man:$MANPATH"
    fi
  }

  function _brew_register_lib() {
    local package="${1:?}"
    local prefix="$_brew_opt/$package"

    local include="$prefix/include"
    if [[ -d "$include" ]]; then
      export CFLAGS="$CFLAGS -I$include"
    fi

    local lib="$prefix/lib"
    if [[ -d "$lib" ]]; then
      export LDFLAGS="$LDFLAGS -L$lib"
    fi
  }

  _brew_register_source "$_brew_opt/bash-completion/etc/bash_completion"

  _brew_register_command coreutils
  _brew_register_command findutils

  _brew_register_lib zlib
  _brew_register_lib bzip2
fi
