# Paths
if [[ -d "/opt/homebrew" ]]; then
  export PATH=/opt/homebrew/bin:${PATH}
fi
if [[ -d "${HOME}/.local" ]]; then
  export PATH=${HOME}/.local/bin:${PATH}
fi

# Pyenv
if which pyenv > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
if [ -e "$NVM_DIR/nvm.sh" ]; then
  alias nvm='unalias nvm node npm && source "$NVM_DIR"/nvm.sh && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm && nvm'
  alias node='unalias nvm node npm && source "$NVM_DIR"/nvm.sh && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm && node'
  alias npm='unalias nvm node npm && source "$NVM_DIR"/nvm.sh && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm && npm'
fi

function _source_if_exists() {
  local script="${1:?}"
  if [[ -f "$script" ]]; then
    source "$script" || return $?
  fi
}

# Homebrew.
if which brew > /dev/null; then
  _brew_prefix=$(brew --prefix)
  _brew_opt=$_brew_prefix/opt

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

    local pkg_config="$lib/pkgconfig"
    if [[ -d "$pkg_config" ]]; then
      export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pkg_config"
    fi
  }

  if [[ -d $_brew_prefix/share/zsh-completions ]]; then
    FPATH=$_brew_prefix/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
  fi

  _brew_register_gnu_command coreutils
  _brew_register_gnu_command findutils
  _brew_register_gnu_command gnu-sed
  _brew_register_gnu_command gnu-tar
  _brew_register_gnu_command grep

  _brew_register_lib zlib
  _brew_register_lib bzip2
  _brew_register_lib libffi

  unset -f _brew_register_lib
  unset -v _brew_opt
  unset -v _brew_prefix
fi

unset -f _source_if_exists
