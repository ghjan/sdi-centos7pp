FROM centos:7
MAINTAINER Florian Sachs "florian.sachs@gmx.at"

ADD set_bash_environment.sh /etc/profile.d/
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN yum -y install wget tar epel-release net-tools telnet openssh-server openssh-clients
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
RUN yum -y update
RUN yum -y clean all
RUN rm /var/log/*
