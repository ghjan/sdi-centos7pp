FROM centos:7
MAINTAINER Florian Sachs "florian.sachs@gmx.at"

# Tell me which Puppet configuration to use, default to none
ENV BUILDTIME_PUPPET_NODE=default
ENV BUILDTIME_PUPPET_REPO=https://github.com/sumpfgottheit/puppet-sumpfgottheit.git

ENV PUPPETDIR=/opt/puppet-sumpfgottheit

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# Install EPEL
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

# Install Puppet
RUN yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1

# Install mandatory Packages
RUN yum -y install wget tar net-tools telnet openssh-server openssh-clients sudo puppet-agent git
RUN yum -y update

ADD puppet-sumpfgottheit /opt/puppet-sumpfgottheit

RUN rm -fr /var/log/*

RUN /opt/puppetlabs/bin/puppet apply --onetime --verbose --no-daemonize --show_diff --modulepath=/opt/puppet-sumpfgottheit/modules /opt/puppet-sumpfgottheit/site.pp

RUN yum -y clean all

VOLUME ["/docker-entrypoint-ext.d", "/logs", "/opt/puppet-sumpfgottheit"]

ENTRYPOINT ["/docker-entrypoint.sh"]
