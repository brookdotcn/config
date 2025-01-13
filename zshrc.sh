hour_min_sec="%F{240}%*%f"
separator="::"
current_directory="%F{blue}%1d%f"

set_prompt() {
  # Read the short, abbreviated name of the current git 'object'
  # https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---abbrev-refstrictloose
  git_branch=$(if [ -d ".git" ]; then echo "$separator%F{magenta}$(git rev-parse --abbrev-ref HEAD)%f"; fi)

  # Read the file names of all files in the diff, count the words, trim the whitespace
  git_change_count=$(if [ -d ".git" ]; then echo "(%F{red}$(git diff --name-only | wc -w | tr -d ' ')%f)"; fi)

  PROMPT="$hour_min_sec $current_directory$git_branch$git_change_count "
}

setopt PROMPT_SUBST
set_prompt

# Refresh prompt on every directory change.
# https://stackoverflow.com/a/17060679
autoload -U add-zsh-hook
add-zsh-hook chpwd set_prompt

# Command history search
bindkey "^[f" history-beginning-search-forward # opt+left
bindkey "^[b" history-beginning-search-backward # opt+right

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
