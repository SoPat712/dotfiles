# Environment variables
export GPG_TTY=$TTY
export BAT_THEME="Enki-Tokyo-Night"
export HISTSIZE=5000
export SAVEHIST=10000
export HISTFILE=~/.cache/zsh/.zsh_history
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export SOLARIZED_THEME="dark"
export ET_NO_TELEMETRY=FALSE
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/libgit2@1.7/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# History settings
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS

# Plugins
plugins=(git hacker-quotes)

# Source files
source ~/Projects/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init zsh)"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(fzf --zsh)"

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias vim=nvim
alias cd=z
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza -alh"
alias tree="eza --tree"
alias cat=bat

# OS-specific settings
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=$PATH:/Users/joshp/.spicetify
  alluptd() {
    skip_all=false

    # Check for -all argument
    if [[ "$1" == "-all" ]]; then
        skip_all=true
    fi

    # # Combined port selfupdate and port upgrade
    # if [ "$skip_all" = true ]; then
    #     sudo port selfupdate
    #     sudo port upgrade outdated
    # else
    #     echo "Run port selfupdate and upgrade outdated? (y/n): "
    #     read confirm
    #     if [[ $confirm == [yY] ]]; then
    #         sudo port selfupdate
    #         sudo port upgrade outdated
    #     fi
    # fi

    # Display mas list, and prompt for mas upgrade
    mas list
    if [ "$skip_all" = true ]; then
        mas upgrade
    else
        echo "Run mas upgrade? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            mas upgrade
        fi
    fi

    brew update
    brew upgrade
    brew cu --all --yes

    # Combined rustup update and cargo install-update
    if [ "$skip_all" = true ]; then
        rustup update
        cargo install-update -a
    else
        echo "Run rustup update and cargo install-update? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            rustup update
            cargo install-update -a
        fi
    fi

    # Combined pip install and pip-review
    if [ "$skip_all" = true ]; then
        pip install --upgrade pip
        pip-review --local --auto
    else
        echo "Run pip install --upgrade pip and pip-review? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            pip install --upgrade pip
            pip-review --local --auto
        fi
    fi
}

  export DISPLAY=:0
  source ~/Projects/fzf-git.sh/fzf-git.sh
fi

# Editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Functions
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Keybinds
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey '^r' atuin-search
bindkey '^[[A' atuin-up-search
bindkey '^[OA' atuin-up-search
