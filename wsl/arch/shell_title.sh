precmd () {
    print -Pn "\e]2;%m: %~\a"
}
preexec () {
    local app_name=${1% *}
    #print -Pn "\e]2;${1##*/} [%~]\a"
    print -Pn "\e]2;$app_name [%~]\a"
}

