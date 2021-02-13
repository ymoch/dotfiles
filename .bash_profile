# Aliases.
alias ls='ls --color'
alias ll='ls -l'

function _source_if_exists() {
  local script="${1:?}"
  if [[ -f "$script" ]]; then
    source "$script" || return $?
  fi
}

# Pyenv.
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

# Poetry
_source_if_exists $HOME/.poetry/env

# Homebrew.
if which brew > /dev/null; then
  _brew_opt=$(brew --prefix)/opt

  function _brew_register_gnu_command() {
    local package="${1:?}"
    local prefix="$_brew_opt/$package"

    local gnubin="$prefix/libexec/gnubin"
    if [[ -d "$gnubin" ]]; then
      export PATH="$gnubin:$PATH"
    fi
    local gnuman="$prefix/libexec/gnuman"
    if [[ -d "$gnuman" ]]; then
      export MANPATH="$gnuman:$MANPATH"
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

  _source_if_exists "$_brew_opt/bash-completion/etc/bash_completion"

  _brew_register_gnu_command coreutils
  _brew_register_gnu_command findutils
  _brew_register_gnu_command gnu-sed
  _brew_register_gnu_command gnu-tar
  _brew_register_gnu_command grep

  _brew_register_lib zlib
  _brew_register_lib bzip2

  unset -f _brew_register_command
  unset -f _brew_register_lib
  unset -v _brew_opt
fi

unset -f _source_if_exists
