# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="yyyy-mm-dd"
plugins=(aliases fzf fzf-tab git history web-search you-should-use zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# ---------- bat/batcat detection ----------
if command -v batcat &>/dev/null; then
  alias cat="batcat"
  alias bat="batcat"
  _BAT="batcat"
elif command -v bat &>/dev/null; then
  alias cat="bat"
  _BAT="bat"
fi

# ---------- History ----------
export HISTTIMEFORMAT="%F %T "

# ---------- Editor ----------
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- PATH ----------
export PATH="$HOME/.local/bin:$PATH"

# Mac-only PATH
if [[ "$OSTYPE" == darwin* ]]; then
  export PATH="$HOME/.codeium/windsurf/bin:$PATH"
  export PATH="$HOME/.console-ninja/.bin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
fi

# ---------- fzf ----------
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,vendor
  --preview '$_BAT -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

if [[ "$OSTYPE" == darwin* ]]; then
  export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"
else
  export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
    --color header:italic
    --header 'Press CTRL-/ to toggle preview'"
fi

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,vendor
  --preview 'tree -C {}'"

# ---------- Shared aliases ----------
alias lg="lazygit"
alias ld="lazydocker"
alias dc="docker compose"

# ---------- Mac-only aliases ----------
if [[ "$OSTYPE" == darwin* ]]; then
  alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
  alias sup="sail up"
  alias sud="sail down"
  alias cyop="npx cypress open"
  alias dcb="docker compose exec api.crm.test php"
  alias dcs="docker compose exec subscription php"
  alias ds="doctl serverless"
fi

# ---------- Linux-only aliases ----------
if [[ "$OSTYPE" == linux* ]]; then
  alias v="nvim"
  alias tm="tmux"
  alias tma="tmux attach -t"
fi

# ---------- thefuck (if installed) ----------
if command -v thefuck &>/dev/null; then
  eval $(thefuck --alias)
fi

# ---------- p10k ----------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------- Local overrides (not tracked) ----------
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
