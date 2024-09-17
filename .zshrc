ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="yyyy-mm-dd"

plugins=(aliases fzf fzf-tab git history web-search you-should-use zsh-autosuggestions)

export HISTTIMEFORMAT="%F %T "

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
	--walker-skip .git,node_modules,target,vendor
	--preview 'bat -n --color=always {}'
	--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
	--preview 'echo {}' --preview-window up:3:hidden:wrap
	--bind 'ctrl-/:toggle-preview'
	--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
	--color header:italic
	--header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
	--walker-skip .git,node_modules,target,vendor
	--preview 'tree -C {}'"

alias lzd='lazydocker'

eval $(thefuck --alias)
