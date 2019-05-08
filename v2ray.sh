#! env bash

working_dir=`dirname $0`
pid_file=$working_dir/v2ray.pid
config='router'

start() {
    if [[ -f $pid_file ]]; then
        kill `cat $pid_file`
    fi
    $v2ray_path/v2ray -config $working_dir/$config.json >> /dev/null &
    echo -n $! > $pid_file
    echo "v2ray run as $config" 
}

stop() {
    if [[ -f $pid_file ]]; then
        kill `cat $pid_file`
        rm $pid_file
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
