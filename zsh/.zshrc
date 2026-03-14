# --- PROMPT ---
eval "$(starship init zsh)"

# --- MODERN TOOLS ---
eval "$(zoxide init zsh)"

# Custom Aliases
alias t="tmux"

# Sessions
alias tn="tmux new -s"          # tmux new -s <name>
alias ta="tmux attach -t"       # tmux attach -t <name>
alias td="tmux detach"          # detach current session
alias tl="tmux ls"              # list sessions
alias tk="tmux kill-session -t" # kill a session

# Quick attach (smart)
alias ts='tmux attach || tmux new -s main'

alias ls="eza --icons"
alias lsa="ls -la"
alias cat="bat"
