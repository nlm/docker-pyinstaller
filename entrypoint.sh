#!/bin/bash -eu

cmd_usage()
{
    echo "usage: $0 COMMAND"
    echo "commands:"
    echo "  autobuild    builds using .pyinstaller.yml"
    echo "  build        invokes pyinstaller"
    echo "  clean        removes the build/ directory"
    echo "  distclean    cleans and removes the dist/ directory"
    echo "  exec         executes a command"
    echo "  shell        runs a shell"
}

cmd_autobuild()
{
    if [ -f '.pyinstaller.yml' ]
    then
        exec pyinstaller-helper .pyinstaller.yml
    else
        echo "no .pyinstaller.yml file found"
        return 1
    fi
}

cmd_build()
{
    exec pyinstaller $@
}

cmd_clean()
{
    rm -fr ./build/
}

cmd_distclean()
{
    cmd_clean
    rm -fr ./dist/
}

cmd_exec()
{
    exec $@
}

cmd_shell()
{
    exec /bin/bash
}

case "$1" in
    autobuild|build|clean|distclean|exec|shell)
        cmd="$1"
        shift
        cmd_${cmd} $@
    ;;
    *)
        cmd_usage
        exit 1
    ;;
esac
