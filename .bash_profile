include () {
  [[ -f "$1" ]] && source "$1"
}

export OS=$(uname)

export EDITOR=vim
export RACK_ENV=development

# Aliases
alias ll='ls -lah -G'
alias bx='bundle exec'
alias tmux='tmux -2'

if [ -x /usr/libexec/path_helper ]; then
  # Mac OS X uses path_helper to preload PATH, clear it out first
  PATH=''
  eval `/usr/libexec/path_helper -s`
elif [ -f /etc/environment ]; then
  source /etc/environment
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.bash


if [ $OS = "Darwin" ]; then
  # homebrew
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  BASH_COMPLETION="$(brew --prefix)/etc/bash_completion"
else
  BASH_COMPLETION="/etc/bash_completion"
  BASH_COMPLETION_DIR="/etc/bash_completion.d"
fi

if [ -f $BASH_COMPLETION ]; then
  . $BASH_COMPLETION
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

if [ -f $BASH_COMPLETION_DIR/git-prompt.sh ]; then
  git_prompt=true
elif [ -f $BASH_COMPLETION_DIR/git-prompt ]; then
  git_prompt=true
else
  git_prompt=false
fi

# prompt with git && rbenv
if $git_prompt && [ -f `which rbenv` ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;36m\] $(__rbenv_ps1)\[\033[01;33m\]\w\[\033[01;35m\]$(__git_ps1) \[\033[01;34m\]\$\[\033[00m\] '
elif $git_prompt; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;35m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '
elif [ `which rbenv` ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;36m\] $(__rbenv_ps1)\[\033[01;33m\]\w \[\033[01;34m\]\$\[\033[00m\] '
else
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \[\033[01;34m\]\$\[\033[00m\] '
fi

# user binpath
export PATH="$PATH:$HOME/bin"

if [ $OS = "Linux" ]; then
  alias gdate='date'
fi

# Add a CLI countdown timer function.
function countdown(){
  date1=$((`gdate +%s` + $1));

  while [ "$date1" -ne `gdate +%s` ]; do
    echo -ne "$(gdate -u --date @$(($date1 - `gdate +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done

  if [ -x /usr/bin/afplay ]; then
    /usr/bin/afplay /System/Library/Sounds/Glass.aiff
  fi
}

# Add a CLI stopwatch function.
function stopwatch(){
  date1=`gdate +%s`;

  while true; do
    echo -ne "$(gdate -u --date @$((`gdate +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

include ~/.bash_local
