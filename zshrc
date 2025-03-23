# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/dpn/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
#ZSH_THEME="dpoggi"
# takashiyoshida
# muse
#ZSH_THEME="refined"
#ZSH_THEME="kennethreitz"
#ZSH_THEME="zhann"
#ZSH_THEME="af-magic"
#ZSH_THEME="bureau"
#tjkirch_mod
## steeef
## tjkirch
#dogenpunk
#ZSH_THEME="sorin"
ZSH_THEME=dstufft

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node docker-compose) #virtualenvwrapper python )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
bindkey -v
export KEYTIMEOUT=1

export PATH=$PATH:/home/dpn/bin:/home/dpn/gocode/bin

alias cb=git_current_branch


#export BROWSER="google-chrome %s"
#export BROWSER="brave %s"
#export TERM=screen-256color
#export TERM=xterm-256color
#export TERM=linux
export TERM=xterm-kitty
export EDITOR=vim
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.8
#source /usr/local/bin/virtualenvwrapper.sh
# xset m 20/10 10 r rate 280 22 b on
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!target/*"'
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#export PATH=~/.npm-global/bin:$PATH
export PATH=/home/dpn/.local/bin:$PATH
export PATH=/home/dpn/.cabal/bin:$PATH
export PATH=$PATH:/usr/local/bin
export GOPATH=~/gocode
#export PATH=$PATH:/home/dpn/.npm-path/bin
export PATH=/home/dpn/.pyenv/bin:$PATH
export PATH=/home/dpn/.local/bin:$PATH
export PATH=/home/dpn/.local/kitty.app/bin:$PATH
#alias vim=~dpn/bin/nvim.appimage
#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi

alias fd=fdfind

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

alias gcz="git cz"
alias v=aws-vault
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="$HOME/.tfenv/bin:$PATH"
alias por="poetry run"
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib64/qt5/plugins
export QT_QPA_PLATFORMTHEME=gtk2
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/dpn/.local/share/flatpak/exports/share
alias aws=awscliv2

# bun completions
[ -s "/home/dpn/.bun/_bun" ] && source "/home/dpn/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/dpn/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias pnpx="pnpm dlx"
export N_PREFIX=/home/dpn/n
export PATH=/home/dpn/n/bin:$PATH
alias gitlog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an> %Creset' --abbrev-commit"


alias gogh="bash -c  \"$(wget -qO- https://git.io/vQgMr)\""
COMPOSE_BAKE=true
alias vim=nvim
alias vdiff='/usr/bin/vim +Gvdiffsplit\!'
