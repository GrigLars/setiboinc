#!/bin/bash

BOINC_ROOT="/opt"
BOINC_PATH="${BOINC_ROOT}/BOINC"
BOINC_VERSION="7.2.42"

# Must be run as root
# This is kind of unsafe: we need to run these as a boinc user
if [ "$(whoami)" != 'root' ]; then
        echo -e "\e[31;1m$0: ERROR: You have no permission to run $0 as non-root user.\e[0m"
        exit 1;
fi

# Check machine version
MACHINE=$(uname -m)

# Libraries for Debian 8
apt-get -y install libx11-6 libxss1 multitail

# Libraries for CentOS
# - Currently, due to shitty programming on static libssl stuff, I haven't gotten this to
#   work on current CentOS

if [ ! -f "/etc/debian_version" ]; then 
        echo -e "\e[31;1m$0: ERROR: This can only run on Debian.  Bummer.\e[0m"
        exit 1;
fi

# Download the init script
wget -nv https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_init -O /etc/init.d/boinc

chmod +x /etc/init.d/boinc
mkdir -p ${BOINC_ROOT}
cd ${BOINC_ROOT}

# Download right client
if [ ${MACHINE} == "i686" ]; then
  wget -nv http://boinc.berkeley.edu/dl/boinc_${BOINC_VERSION}_i686-pc-linux-gnu.sh
else
  wget -nv http://boinc.berkeley.edu/dl/boinc_${BOINC_VERSION}_x86_64-pc-linux-gnu.sh
fi

sh boinc_*
# useradd -r -m /opt/BOINC -s /bin/false boinc
# chown -R boinc:boinc ${BOINC_PATH}
cd ${BOINC_PATH}

# Set up service

# systemctl enable boinc

# Set up client
/etc/init.d/boinc attach
multitail /var/log/boinc.log
