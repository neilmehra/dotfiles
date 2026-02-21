if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux has-session -t main     2>/dev/null || tmux new-session -d -s main
  tmux has-session -t spine    2>/dev/null || tmux new-session -d -s spine
  tmux has-session -t research 2>/dev/null || tmux new-session -d -s research
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
 exec startx
fi

