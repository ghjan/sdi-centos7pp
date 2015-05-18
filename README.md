# docker-centos7

A docker image, based on the official CentOS 7 Release with minimal changes.

## Changes
* Added packages: wget tar epel-release net-tools telnet
* Import CentOS and EPEL gpg-keys into rpm database
* Add a mini version of my bash environment to /etc/profile.d
* Supervisor from epel already installed

## Entrypoint

The official Postgres Dockerfiles (https://github.com/docker-library/postgres) use 
an elegant mechanism to execute some script when the container is started. This 
mechanism has been copied by me.

The Dockerfile defines the script **/docker-entrypoint.sh** as ENTRYPOINT. It sources all Files /docker-entrypoint.d/\*.sh.
Afterwards it executes the Command given. Any initialization steps of the **container** should go as script into
the directory **/docker-entrypoint.d**. The script has to be written in a way that it can be executed every time the container starts.
The directory **/docker-entrypoint-ext.d** is defined as VOLUME and is treated the same way like the directory **/docker-entrypoint.d**.
If you need to run something in the container at startup, that is not included in the image, you me put it there an mount the volume.

If the Environmentvariable DEBUG_ENTRYPOINT_SCRIPTS ist set to 1 (or anything else..), the entrypoint scripts run with **set -x** invoced which comes handy during debugging startup errors.

The **docker-entrypoint.sh**:

	#!/bin/bash
	set -e
	
	[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set -x
	
	if [[ -d /docker-entrypoint.d ]] ; then
		for file in /docker-entrypoint.d/*.sh
		do
			echo "docker-entrypoint.sh : Sourcing $file"
			[[ -f $file ]] && . $file
		done
	fi
	
	if [[ -d /docker-entrypoint-ext.d ]] ; then
		for file in /docker-entrypoint-ext.d/*.sh
		do
			echo "docker-entrypoint.sh : Sourcing Ext $file"
			[[ -f $file ]] && . $file
		done
	fi
	
	[[ $DEBUG_ENTRYPOINT_SCRIPTS ]] && set +x
	
	exec "$@"


## Every container's entrypoint script

Every container gets the following script. It does not harm, but it is used by my **diwa** project to deploy the logstash
configuration.

	#!/bin/bash
	# Copy the /etc/logstash.conf to the /logs directory if it exists
	# and the file is not already there                                                                                                                                                                                                                                           
	
	if [[ -d /logs ]] && [[ ! -f /logs/logstash.conf ]] && [[ -f /etc/logstash.conf ]] ; then
		cp /etc/logstash.conf /logs
	fi

Most images of my DIWA project use this image as base.
