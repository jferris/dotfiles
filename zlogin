# adds the current branch name in green
git_prompt_info() {
  let "name_width = $COLUMNS / 8 + 15"
  ref=$(git symbolic-ref HEAD 2> /dev/null | sed "s/^\(.\{$name_width\}\).*/\1…/")
  if [[ -n $ref ]]; then
    gitroot=$(basename $(git rev-parse --show-toplevel))
    gitpath=$(git rev-parse --show-prefix | sed "s/\/$//")
    echo "%{$fg_bold[blue]%}${gitroot}%{$reset_color%}%{$fg_bold[green]%}@${ref#refs/heads/}%{$reset_color%} %{$fg_bold[blue]%}/${gitpath}%{$reset_color%}"
  else
    echo "%{$fg_bold[blue]%}%~%{$reset_color%}"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt promptsubst

# prompt
export PS1='$(git_prompt_info) %% '

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# keep the current working directory
export CURRENT_PROJECT_PATH=$HOME/.current-project
function chpwd {
  echo $(pwd) >! $CURRENT_PROJECT_PATH
}
current() {
  if [[ -f $CURRENT_PROJECT_PATH ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current
