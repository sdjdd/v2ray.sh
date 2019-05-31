#! env bash

working_dir=`dirname $0`
pid_file=$working_dir/v2ray.pid
config='router'
proxy_types=(
    "web"
    "secureweb"
    "socksfirewall"
)

kill_by_pid() {
    ps -p $1 | grep v2ray > /dev/null
    if [[ $? -eq 0 ]]; then
        kill $1
    fi
}

set_sys_proxy_stat() {
    for type in ${proxy_types[@]}; do
        networksetup -set${type}proxystate Wi-Fi $1
    done
}

start() {
    if [[ -f $pid_file ]]; then
        kill_by_pid `cat $pid_file`
    else
        set_sys_proxy_stat on
    fi

    $v2ray_bin -config $working_dir/${config}.json > /dev/null &
    echo -n $! > $pid_file

    echo "v2ray run as $config"
}

stop() {
    if [[ -f $pid_file ]]; then
        kill_by_pid `cat $pid_file`
        rm $pid_file

        set_sys_proxy_stat off

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
        echo "invalid param: $1, only run as (r)outer or (g)lobal"
        exit 1
        ;;
esac
