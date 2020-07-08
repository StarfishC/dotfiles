# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ubuntu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

export PATH=$HOME/bin:/usr/.local/bin:/home/ubuntu/.local/bin:/bin:/usr/bin:/usr/local/bin:$PATH

# source /home/ubuntu/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')

# export ALL_PROXY=socks5://$hostip:10808
# export HTTP_PROXY=$ALL_PROXY
# export HTTPS_PROXY=$ALL_PROXY

# 设置git的代理
# if [ "`git config --global --get proxy.https`" != "socks5://$hostip:10808"  ]; then
#         git config --global proxy.https socks5://$hostip:10808
# fi

wslip=$(hostname -I | awk '{print $1}')
export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')

set_proxy(){
    # export ALL_PROXY=socks5://$hostip:10809
    export ALL_PROXY=http://$hostip:10809
    export HTTP_PROXY=$ALL_PROXY
    export http_proxy=$ALL_PROXY
    export HTTPS_PROXY=$ALL_PROXY
    export https_proxy=$ALL_PROXY

    if [ "`git config --global --get http.proxy`" != "socks5://$hostip:10808"    ];
    then
        git config --global https.proxy socks5://$hostip:10808
        git config --global http.proxy socks5://$hostip:10808
    fi

    ssh_proxy

    # echo $ALL_PROXY
    # echo "set proxy success"
}

unset_proxy(){
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
    unset ALL_PROXY

    ssh_proxy cancel
    git config --global --unset https.proxy
    git config --global --unset http.proxy
}


# ssh_proxy
ssh_proxy(){
    ssh="$hostip:10808"
    oldip=`cat ~/.ssh/config | grep -o "[0-9].*[0-9]"`
    pcd=`cat ~/.ssh/config | grep "ProxyCommand"`

    if [ "$pcd" = "" ]; then
        echo "Host github.com" >> ~/.ssh/config
        echo "    HostName github.com" >> ~/.ssh/config
        echo "    User git" >> ~/.ssh/config
        echo "    ProxyCommand nc -v -x $ssh %h %p" >> ~/.ssh/config
    elif [ "$ssh" != "$oldip" ]; then
        sed -i "s/[0-9].*[0-9]/$ssh/g" ~/.ssh/config
    fi

    if [ "$1" = "cancel" ]; then
        echo "unset proxy"
        startLine=`sed -n '/Host github.com/=' ~/.ssh/config`
        lineAfter=3
        let endLine="startLine + lineAfter"
        sed -i $startLine','$endLine'd' ~/.ssh/config
    fi
}

test_setting(){
    echo "Host ip:" ${hostip}
    echo "Wsl ip:" ${wslip}
    echo "Current proxy": $https_proxy
}

alias setproxy=set_proxy
alias unsetproxy=unset_proxy
alias testproxy=test_setting

set_proxy
