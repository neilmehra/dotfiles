export PATH="$HOME/.local/bin:$PATH"
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

[[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

autoload -Uz add-zsh-hook
_set_beam_cursor() { echo -ne '\e[5 q' }
add-zsh-hook precmd _set_beam_cursor
add-zsh-hook preexec _set_beam_cursor


alias ls='eza --icons --git'
alias ll='eza -l --icons --git --group-directories-first -m'
alias la='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'
alias cat='bat --paging=never --style=plain'

alias grep='grep -i -P'
alias vim='nvim'
alias vi='nvim'
alias hgr="history | grep -i -P"

alias up="cd .."

alias fd="fd -H"

alias cla='IS_SANDBOX=1 claude --dangerously-skip-permissions'
alias cod='IS_SANDBOX=1 codex --dangerously-bypass-approvals-and-sandbox --enable use_legacy_landlock'
alias gnp='git --no-pager'



# fuzzy-search shell history -> drop the pick onto the command line (edit before run)
h() {
  local cmd
  cmd=$(fc -rl 1 | fzf --height 40% --reverse --query "$*" | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
  [ -n "$cmd" ] && print -z -- "$cmd"
}
# view a git diff in nvim via diffview; args pass through, e.g. `gd --cached`, `gd HEAD~2`
# (overrides oh-my-zsh's gd='git diff')
unalias gd 2>/dev/null
gd() { nvim -c "DiffviewOpen $*" }
# yazi: open the file manager and cd to wherever you navigated on quit
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then builtin cd -- "$cwd"; fi
  rm -f -- "$tmp"
}

mkc() {
  mkdir $1
  cd $1
}

export VISUAL="$(command -v nvim)"
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

setopt IGNORE_EOF

bindkey -s '^Z' 'fg\n'
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
export BAT_THEME="base16"
# zoxide: provides `z` / `zi` only; `cd` is left as the builtin
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

