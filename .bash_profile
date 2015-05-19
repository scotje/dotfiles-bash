source ~/.bash_env

export EDITOR=vim
export RACK_ENV=development
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

# Aliases
alias ll='ls -lah -G'
alias bx='bundle exec'
alias tmux='tmux -2'

# Puppet Alias
#alias puppet='~/src/pe-puppet/.binstubs/puppet'

# Mac OS X uses path_helper to preload PATH, clear it out first
if [ -x /usr/libexec/path_helper ]; then
  PATH=''
  eval `/usr/libexec/path_helper -s`
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.bash


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

# homebrew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

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

# vcloud VMs
function getvm() { curl -d --url http://vcloud.delivery.puppetlabs.net/vm/$1; }
function sshvm() { ssh -i ~/.ssh/id_rsa-acceptance root@$1; }
function rmvm() { curl -X DELETE --url http://vcloud.delivery.puppetlabs.net/vm/$1; }

# clojure
export PATH="$PATH:$HOME/bin"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/jesse/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/jesse/google-cloud-sdk/completion.bash.inc'

# node version manager
source ~/.nvm/nvm.sh

# haxe
export HAXE_STD_PATH="/usr/local/lib/haxe/std"
alias flixel='haxelib run flixel-tools'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
