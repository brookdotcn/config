hour_min_sec="%F{240}%*%f"
separator="::"
current_directory="%F{blue}%1d%f"

set_prompt() {
  git_branch=$(if [ -d ".git" ]; then echo "$separator%F{magenta}$(git rev-parse --abbrev-ref HEAD)%f"; fi)
  PROMPT="$hour_min_sec $current_directory$git_branch "
}

setopt PROMPT_SUBST
set_prompt

# Refresh prompt on every directory change.
# https://stackoverflow.com/a/17060679
autoload -U add-zsh-hook
add-zsh-hook chpwd set_prompt

source ~/.cargo/env
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
