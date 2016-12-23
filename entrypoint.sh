#!/bin/bash -eu

cmd_usage()
{
	echo "usage: $0 build"
}

cmd_build()
{
        if [ -f "requirements.txt" ]
	then
		"$PYTHON" -m pip install -r requirements.txt
	fi
	exec pyinstaller $@
}

cmd_shell()
{
	exec /bin/bash
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

case "$1" in
	build|clean|distclean|shell)
		cmd="$1"
		shift
		cmd_${cmd} $@
	;;
	*)
		cmd_usage
		exit 1
	;;
esac
