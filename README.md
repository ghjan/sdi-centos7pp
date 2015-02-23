# docker-centos7

A docker image, based on the official CentOS 7 Release with minimal changes.

## Changes
* Added packages: wget tar epel-release net-tools telnet
* Import CentOS and EPEL gpg-keys into rpm database
* Add a mini version of my bash environment to /etc/profile.d

Most images of my DIWA project use this image as base.
