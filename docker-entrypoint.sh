#!/bin/bash
set -e

ENTRYPOINT_DIR=/docker-entrypoint.d
ENTRYPOINT_EXT_DIR=/docker-entrypoint-ext.d

[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set -x

if [[ -d $ENTRYPOINT_DIR ]] ; then
	for file in $ENTRYPOINT_DIR/*.sh
	do
		echo "docker-entrypoint.sh : Sourcing $file"
		cd $ENTRYPOINT_DIR
		[[ -f $file ]] && . $file
	done
fi

if [[ -d $ENTRYPOINT_EXT_DIR ]] ; then
	for file in $ENTRYPOINT_EXT_DIR/*.sh
	do
		echo "docker-entrypoint-ext.sh : Sourcing $file"
		cd $ENTRYPOINT_EXT_DIR
		[[ -f $file ]] && . $file
	done
fi

[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set +x

exec "$@"

