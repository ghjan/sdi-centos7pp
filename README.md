# sdi-centos7 (Sumpfgottheit's Docker Image for CentOS7)

A docker image, based on the official CentOS 7 Release with minimal changes. This image is the base image for all sdi-Images.

See the [Sumpfgottheit's Docker Image wiki](https://github.com/sumpfgottheit/sdi-centos7/wiki) for the concept and idea behind the SDI images.

## Changes
* Added packages: wget tar epel-release net-tools telnet
* Import CentOS and EPEL gpg-keys into rpm database
* Add a mini version of my bash environment to /etc/profile.d
* Supervisor from epel already installed

