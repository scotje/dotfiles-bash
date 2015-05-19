include () {
  [[ -f "$1" ]] && source "$1"
}

export EDITOR=vim
export RACK_ENV=development

# Aliases
alias ll='ls -lah -G'
alias bx='bundle exec'
alias tmux='tmux -2'

# Mac OS X uses path_helper to preload PATH, clear it out first
if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  eval `/usr/libexec/path_helper -s`
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.bash


# homebrew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
__rbenv_ps1 ()
{
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  if [[ `rbenv version | sed -e 's/.* (set by //' -e 's/)//'` != "$HOME/.rbenv/version" ]]
  then
    printf "$rbenv_ruby_version "
  fi
}

# prompt with git && rbenv
if [ -f $BASH_COMPLETION_DIR/git-prompt.sh ] && [ -f `which rbenv` ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;36m\] $(__rbenv_ps1)\[\033[01;33m\]\w\[\033[01;35m\]$(__git_ps1) \[\033[01;34m\]\$\[\033[00m\] '
elif [ -f $BASH_COMPLETION_DIR/git-prompt.sh ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;35m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '
elif [ `which rbenv` ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;36m\] $(__rbenv_ps1)\[\033[01;33m\]\w \[\033[01;34m\]\$\[\033[00m\] '
else
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \[\033[01;34m\]\$\[\033[00m\] '
fi

# user binpath
export PATH="$PATH:$HOME/bin"

include ~/.bash_local
