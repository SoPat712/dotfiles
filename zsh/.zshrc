# Environment variables
export GPG_TTY=$TTY
export BAT_THEME="tokyonight_storm"
export HISTSIZE=5000
export SAVEHIST=10000
export HISTFILE=~/.cache/zsh/.zsh_history
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export SOLARIZED_THEME="dark"
export ET_NO_TELEMETRY=FALSE
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$PATH:/Users/joshp/tizen-studio/tools/ide/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/opt/homebrew/opt/libgit2@1.7/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/sdk"
# export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export MANPAGER='nvim +Man!'
#Nano Zone for gcc on MacOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    export MallocNanoZone=0
fi


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
source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init zsh)"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
eval "$(fzf --zsh)"
eval "$(~/.local/bin/mise activate zsh)"

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
    run_music=false

    # Check for -all and -music arguments
    for arg in "$@"; do
        if [[ "$arg" == "-all" ]]; then
            skip_all=true
        elif [[ "$arg" == "-music" ]]; then
            run_music=true
        fi
    done

    # Perform system updates if -all is specified or if running normally
    if [ "$skip_all" = true ]; then
        # Uncomment the following lines if MacPorts updates are needed
        # sudo port selfupdate
        # sudo port upgrade outdated

        mas list
        mas upgrade

        brew update
        brew upgrade
        brew cu --all --yes

        rustup update
        cargo install-update -a

        pip install --upgrade pip
        pip-review --local --auto
    else
        # Prompt-based updates
        mas list
        echo "Run mas upgrade? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            mas upgrade
        fi

        echo "Run brew update and upgrade? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            brew update
            brew upgrade
            brew cu --all --yes
        fi

        echo "Run rustup update and cargo install-update? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            rustup update
            cargo install-update -a
        fi

        echo "Run pip install --upgrade pip and pip-review? (y/n): "
        read confirm
        if [[ $confirm == [yY] ]]; then
            pip install --upgrade pip
            pip-review --local --auto
        fi
    fi

    # Perform music-related tasks if -music is specified
    # if [ "$run_music" = true ]; then
    #     echo "Running music sync..."
    #     cd ~/Projects/lrcput
    #     python lrcput.py -d "/Volumes/Crucial X8/Media/Music/" -r -R
    #
    #     # rsync -avP --delete --chown=navidrome:nogroup -e 'ssh -p 5222' "/Volumes/Crucial X8/Media/Music/" root@ddns.joshpatra.me:/media/FiveTB/Navidrome/joshp
    #     #
    #     # rsync -avP --delete "/Volumes/Crucial X8/Media/Music/" "/Volumes/Samsung USB/Music/"
    #     rsync -avP --delete --chown=navidrome:navidrome -e 'ssh -p 5222' "/Volumes/Crucial X8/Media/Music/" root@ddns.joshpatra.me:/media/FiveTB/Navidrome/joshp
    #
    # rsync -rltDvP --delete --no-perms --no-owner --no-group --chmod=ugo=rwX "/Volumes/Crucial X8/Media/Music/" "/Volumes/Samsung USB/Music/"
    #
    # fi
    if [ "$run_music" = true ]; then
    echo "Running music sync..."
    cd ~/Projects/lrcput
    python lrcput.py -d "/Volumes/Crucial X8/Media/Music/" -r -R

    dot_clean "/Volumes/Crucial X8/Media/Music/"

    rsync -aHv --delete --chown=navidrome:navidrome \
      --chmod=F644,D755 \
      -e 'ssh -p 5222' \
      "/Volumes/Crucial X8/Media/Music/" \
      root@ddns.joshpatra.me:/media/FiveTB/Navidrome/joshp


    rsync -aHv --delete \
      "/Volumes/Crucial X8/Media/Music/" \
      "/Volumes/Samsung USB/Music/"

    fi
  }

  # Additional configurations
  export DISPLAY=:0
  source ~/Projects/fzf-git.sh/fzf-git.sh
  alias brewfixes="brew cleanup && brew cleanup --prune=all && brew autoremove && brew doctor && brew update && brew upgrade && brew missing"
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


#Temp
export DYLD_LIBRARY_PATH="/opt/homebrew/Cellar/libgit2/1.9.0/lib:$DYLD_LIBRARY_PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
