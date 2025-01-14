set_prompt() {
  local hour_min_sec="%F{240}%*%f"
  local separator="::"
  local current_directory="%F{blue}%1d%f"

  local git_branch
  local git_changes

  if [ -d ".git" ]; then
    # Read the short, abbreviated name of the current git object
    # https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---abbrev-refstrictloose
    git_branch=$(echo "$separator%F{magenta}$(git rev-parse --abbrev-ref HEAD)%f")

    # Read the file names of all files in the diff, count the words, trim the whitespace & only show if non-zero
    git_changes=$(git diff --name-only | wc -w | tr -d ' ')
    git_changes=$(if [[ $git_changes != '0' ]]; then echo "(%F{red}$git_changes%f)"; fi)
  fi

  PROMPT="$hour_min_sec $current_directory$git_branch$git_changes "
}

setopt PROMPT_SUBST
set_prompt

# Refresh prompt on every command.
# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/hooks.md#set-prompt-in-precmd
typeset -a precmd_functions
precmd_functions+=(set_prompt)

# Command history search
bindkey "^[f" history-beginning-search-forward # opt+left
bindkey "^[b" history-beginning-search-backward # opt+right

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
