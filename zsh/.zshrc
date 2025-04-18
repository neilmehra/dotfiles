export PATH="/home/neil/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

zstyle ':omz:update' mode disabled
zmodload zsh/zprof

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	copypath
	copybuffer
  sudo
)

source $ZSH/oh-my-zsh.sh


alias ranger="cat /home/neil/dotfiles/wal/backup/sequences && ranger"
alias ls='exa --icons'
alias py='python3'
alias icat="kitty +kitten icat --scale-up"
alias wmc="xprop | grep WM_CLASS"
alias grep='grep -i'
alias vim='nvim'
alias vi='nvim'
alias setbg="feh --bg-fill"
alias cpick="colorpicker --one-shot"
alias ytaudio="$HOME/scripts/ytaudio.sh"
alias xev='~/scripts/xev.sh'
alias fileman="pcmanfm > /dev/null 2>&1"
alias nc="ncmpcpp"
alias gdl="gallery-dl"
alias rm="rm -i"
alias yt="$HOME/scripts/ycmd.sh"
alias mwin="sudo mount /data/windows"
alias hgr="history | grep"
alias up="cd .."
alias gssh="ssh-add ~/.ssh/id_ed25519"
alias fd="fd -H"

mkc() {
  mkdir $1 
  cd $1 
}

cpm() {
  mkdir $1
  cd $1
  touch main.cpp
  nvim main.cpp
}

yta() {
  nohup $HOME/scripts/ytarchive.sh $1 &!
}

rea() {
  nohup $HOME/scripts/rearchive.sh $1 &!
}

mpall() {
  mpv --shuffle --image-display-duration=5 --no-loop --loop-playlist *
}

fix() {
  ~/scripts/xautostart.sh
  xmodmap ~/.Xmodmap
}

(cat {{ wal }}/sequences &)

source {{ wal }}/colors-tty.sh

export RANGER_LOAD_DEFAULT_RC=false
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export VISUAL=/usr/bin/nvim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME="$HOME/.config"


# source $HOME/.rvm/scripts/rvm

bindkey -s '^Z' 'fg\n'

if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi


source $HOME/.rvm/scripts/rvm
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
