# Add brew installed commands autocomplete support
fpath+=/opt/homebrew/share/zsh/site-functions

# Add deno, cargo and rustup autocompletions support
fpath+=$HOME/.zfunc/

# Add rust installed binaries using 
# ```sh
#   cargo install --PATH ./relative/path/to/rust/project
# ```
# to zsh 
path+=$HOME/.cargo/bin/
# Add go installed binaries using
# ```sh
#   go build
# ````
# to zsh
path+=$HOME/go/bin

# MacOS only
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Add java to path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

autoload -Uz compinit && compinit

# old prompt settings
# PROMPT='%F{36}%n%f%B@%b %F{magenta}%m%f %F{33}%~%f %# '
# RPROMPT='%(?.✅.❌) %F{104}${vcs_info_msg_0_}%f'

# new prompt settings
directory_prompt='%F{yellow}%~%f'

# git branch settings
function git_branch()
{
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ $branch == "" ]]
    then
        echo "%T"
    else
        echo "%F{44}%f %F{cyan}$branch%f"
    fi
}

# Enable substitution in the prompt
setopt prompt_subst

git_prompt='$(git_branch)'

# name_and_host='%B%n%b@%B%m%b'

# arrow_prompt='%(?.%F{bold}%F{green}↳  %f%f.%F{bold}%F{red}↳  %f%f)'
# arrow_prompt='%(?.%F{white}%K{34} $name_and_host %k%K{33} ✓%k%f%F{33}%f .%F{white}%K{red} $name_and_host %k%K{33} ✘%k%F{33}%f %f)'

# PROMPT="$directory_prompt $arrow_prompt"
# RPROMPT="$git_prompt $"
PROMPT='%(?.%F{green}[%f$directory_prompt%F{green}]▶︎%f.%F{red}[%f$directory_prompt%F{red}]▶︎%f) '
RPROMPT=$git_prompt

# Direct Aliases
alias vim='nvim'
# Lazygit
# https://github.com/jesseduffield/lazygit
alias lg='lazygit'
# RipGrep
# https://github.com/BurntSushi/ripgrep
alias grep='rg'

# pretty JSON in terminal
alias jsp="json_pp -json_opt pretty, canonical"

# Change Directory Aliases (Directory Only)
export CONFIG_DIR=$HOME/.config
# The ZSHRC file is linked to $HOME/.zshrc
export ZSHRC=$CONFIG_DIR/zsh/.zshrc
# Alacritty has been dropped in favor of wezTerm
# export ALACRITTY=$HOME/.config/alacritty/alacritty.yml
export WEZTERM=$CONFIG_DIR/wezterm
export NVIM=$CONFIG_DIR/nvim
export PROJECTS_DIR=$HOME/Developer

# Change Directory Aliases (Command)
alias cdp='cd $PROJECTS_DIR'
alias cdn='cd $NVIM'
alias cdw='cd $WEZTERM'
alias cdc='cd $CONFIG_DIR'

# ls Aliases for eazy calls
alias la='ls -a'
alias ll='ls -al'

# Vim Open Aliases (Commonly Used Config Directories and Files)
alias viz='vim $ZSHRC'
# alias via='vim $ALACRITTY'
alias viw='cdw && vim'
alias vin='cdn && vim'

# Python 3.11 -> python
alias python='python3'
alias pip='python -m pip'

# alias to create and move into a directory
mkmv() {
	if [ "$1" != "" ]
	then
		mkdir "$1" && cd "$1"
	else
		echo "Enter a directory name"
	fi
}

# Syntax Highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Syntax highlighting changes
ZSH_HIGHLIGHT_STYLES[default]='fg=32'
ZSH_HIGHLIGHT_STYLES[alias]='fg=43'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=43'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=43'
ZSH_HIGHLIGHT_STYLES[function]='fg=43'
ZSH_HIGHLIGHT_STYLES[command]='fg=43'
ZSH_HIGHLIGHT_STYLES[pre-command]='fg=43'

# Command Auto-completion
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

alias gignore='cp $HOME/templates/.gitignore .'
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.cpp:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
