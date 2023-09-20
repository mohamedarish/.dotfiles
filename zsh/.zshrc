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
path+=$go/bin

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
        echo " $branch"
    fi
}

# Enable substitution in the prompt
setopt prompt_subst

git_prompt='%F{cyan}$(git_branch)%f'

name_and_host='%B%n%b@%B%m%b'

# arrow_prompt='%(?.%F{bold}%F{green}↳  %f%f.%F{bold}%F{red}↳  %f%f)'
arrow_prompt='%(?.%F{white}%K{34} $name_and_host %k%K{33} ✓%k%f%F{33}%f .%F{white}%K{red} $name_and_host %k%K{33} ✘%k%F{33}%f %f)'

# PROMPT="$directory_prompt $arrow_prompt"
# RPROMPT="$git_prompt $"
PROMPT=$directory_prompt$'\n'$arrow_prompt
RPROMPT=$git_prompt

# Direct Aliases
alias vim='nvim'
# exa
# https://github.com/ogham/exa
# alias ls='exa -l --icons'
# bat
# https://github.com/sharkdp/bat
alias cat='bat'
# Lazygit
# https://github.com/jesseduffield/lazygit
alias lg='lazygit'
# RipGrep
# https://github.com/BurntSushi/ripgrep
alias grep='rg'
# Bottom
# https://github.com/ClementTsang/bottom
# This has no alias setup in my config
# ---
# Fd
# https://github.com/sharkdp/fd
alias find='fd'


# Change Directory Aliases (Directory Only)
export ZSHRC=$HOME/.config/zsh/.zshrc
# Alacritty has been dropped in favor of wezTerm
# export ALACRITTY=$HOME/.config/alacritty/alacritty.yml
export WEZTERM=$HOME/.config/wezterm/
export NVIM=$HOME/.config/nvim/
export PROJECTS_DIR=$HOME/Projects/

# Change Directory Aliases (Command)
alias cdp='cd $PROJECTS_DIR'
alias cdn='cd $NVIM'
alias cdw='cd $WEZTERM'

# Vim Open Aliases (Commonly Used Config Directories and Files)
alias viz='vim $ZSHRC'
# alias via='vim $ALACRITTY'
alias viw='cdw && vim'
alias vin='cdn && vim'

# Python 3.11 -> python
alias python='python3.11'
alias pip='python -m pip'

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

# MacOS only
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
