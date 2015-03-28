#!/bin/bash
# Copy the /etc/logstash.conf to the /logs directory if it exists
# and the file is not already there

if [[ -d /logs ]] && [[ ! -f /logs/logstash.conf ]] && [[ -f /etc/logstash.conf ]] ; then
	sed  "s/\$LOGSTASH_PORT/$LOGSTASH_PORT/" < /etc/logstash.conf > /logs/logstash.conf
fi

if [[ -d /logs ]] && [[ ! -f /logs/logstash.pattern ]] && [[ -f /etc/logstash.pattern ]] ; then
	cp /etc/logstash.pattern /logs
fi
