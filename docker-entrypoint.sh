#!/bin/bash
set -e

ENTRYPOINT_DIR=/docker-entrypoint.d
ENTRYPOINT_EXT_DIR=/docker-entrypoint-ext.d

[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set -x

if [[ -d $ENTRYPOINT_DIR ]] ; then
	COUNT=$(ls $ENTRYPOINT_DIR/*.sh 2>/dev/null | wc -l)
	echo "*** Anzahl der .sh-Dateien in $ENTRYPOINT_DIR: $COUNT"
	for file in  $(ls $ENTRYPOINT_DIR/*.sh 2>/dev/null)		# ls to sort it explizitely alphabetically
	do
		echo "*** docker-entrypoint.sh : Sourcing $file"
		cd $ENTRYPOINT_DIR
		[[ -f $file ]] && . $file
	done
fi

if [[ -d $ENTRYPOINT_EXT_DIR ]] ; then
	COUNT=$(ls $ENTRYPOINT_EXT_DIR/*.sh 2>/dev/null | wc -l)
	echo "*** Anzahl der .sh-Dateien in $ENTRYPOINT_EXT_DIR: $COUNT"
	for file in $(ls $ENTRYPOINT_EXT_DIR/*.sh 2>/dev/null)	# ls to sort it explizitely alphabetically
	do
		echo "*** docker-entrypoint-ext.sh : Sourcing $file"
		cd $ENTRYPOINT_EXT_DIR
		[[ -f $file ]] && . $file
	done
fi

[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set +x

exec "$@"

