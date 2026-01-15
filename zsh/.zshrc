### 1. EXPORTS (Environment variables)
export TERM="xterm-256color"
export EDITOR="nvim"
export CODE="code"
export VISUAL="nvim"
export PATH="$HOME/.local/share/cargo/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

### 2. HISTORY SETTINGS (Must come early)
setopt inc_append_history    # Save history incrementally
setopt share_history         # Share history across sessions
setopt extended_history      # Record timestamps
setopt hist_ignore_dups      # Ignore duplicates
setopt hist_ignore_space     # Ignore space-prefixed commands

### 3. VI MODE (Keybindings and cursor)
bindkey -v  # Enable vi mode

# Fix Home/End/Del keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[1;5D" backward-word  # Ctrl+Left
bindkey "\e[1;5C" forward-word   # Ctrl+Right
bindkey "\e[3;5~" kill-word      # Ctrl+Del

# tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"

# Cursor shape for vi modes
function zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;  # Block
        viins|main) echo -ne '\e[5 q';; # Beam
    esac
}
zle -N zle-keymap-select
echo -ne '\e[5 q'  # Default beam cursor

### 4. COMPLETION (After vi mode)
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"  # Cache compinit
_comp_options+=(globdots)  # Complete hidden files


### 6. ALIASES (After plugins)
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

### 7. PROMPT (Starship last)
eval "$(starship init zsh)"

# temp
eval "$(fnm env --use-on-cd --shell zsh)"

# fzf history
source <(fzf --zsh)

# Auto-suggestions (after history search)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# History substring search (requires vi mode)
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow

# Syntax highlighting (MUST BE LAST)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue


