#! env bash

working_dir=`dirname $0`
pid_file=$working_dir/v2ray.pid
config='router'
proxy_types=(
    "web"
    "secureweb"
    "socksfirewall"
)

start() {
    if [[ -f $pid_file ]]; then
        kill `cat $pid_file`
    else
        for type in ${proxy_types[@]}; do
            networksetup -set${type}proxystate Wi-Fi on
        done
    fi

    $v2ray_bin -config $working_dir/${config}.json >> /dev/null &
    echo -n $! > $pid_file

    echo "v2ray run as $config"
}

stop() {
    if [[ -f $pid_file ]]; then
        kill `cat $pid_file`
        rm $pid_file

        for type in ${proxy_types[@]}; do
            networksetup -set${type}proxystate Wi-Fi off
        done

        echo 'v2ray stopped'
    else
        echo 'v2ray is not running'
    fi
}

case $1 in
    'r'|'router')
        config='router'
        start
        ;;
    'g'|'global')
        config='global'
        start
        ;;
    'stop')
        stop
        ;;
    *)
        echo 'invalid param: only run as router or global'
        ;;
esac
