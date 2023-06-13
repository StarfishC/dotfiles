# proxy
# wslip=$(hostname -I | awk '{print $1}')
export hostip=$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')
httpport=10811
socksport=10810

set_proxy()
{
    # export ALL_PROXY=socks5://$hostip:10809
    export ALL_PROXY=http://$hostip:$httpport
    export HTTP_PROXY=$ALL_PROXY
    export http_proxy=$ALL_PROXY
    export HTTPS_PROXY=$ALL_PROXY
    export https_proxy=$ALL_PROXY

    if [ "`git config --global --get http.proxy`" != "socks://$hostip:$httpport"    ];
    then
        git config --global https.proxy socks://$hostip:$socksport
        git config --global http.proxy socks://$hostip:$socksport
    fi

    ssh_proxy
    # echo $ALL_PROXY
    # echo "set proxy success"
}

unset_proxy()
{
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
ssh_proxy()
{
    ssh="$hostip:$socksport"
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

test_setting()
{
    echo "Host ip:" ${hostip}
    echo "Wsl ip:" ${wslip}
    echo "Current proxy": $https_proxy
    curl "http://ipinfo.io"
}

set_proxy

