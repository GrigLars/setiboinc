#!/bin/bash

# This should install within seconds a SETI service on my Linux box unattended.  Well, on mine, at any rate.  
#   Currently (July 2016), this has been tested on Debian 8 (Jessie) 64 and 32 bit servers.

BOINC_ROOT="/opt"
BOINC_PATH="${BOINC_ROOT}/BOINC"
BOINC_VERSION="7.2.42"
ADDUSER="punkie"
MYHOMESSH="/home/${ADDUSER}/.ssh"

# Must be run as root
# This is kind of unsafe: we need to run these as a boinc user

if [ "$(whoami)" != 'root' ]; then
        echo -e "\e[31;1m$0: ERROR: You have no permission to run $0 as non-root user.\e[0m"
        exit 1;
fi

# Check machine version
MACHINE=$(uname -m)

if [ ! -f "/etc/debian_version" ]; then 
        # Libraries for CentOS
        # - Currently, due to shitty programming on static libssl RPM stuff, I haven't gotten this to
        #   work on current CentOS 7 :(
        
        echo -e "\e[31;1m$0: ERROR: This can currently only run on Debian.  Bummer.\e[0m"
        exit 1;
else
        # Libraries for Debian 8
        # Also seems to work with AWS Ubuntu
        apt-get -y install libx11-6 libxss1 psmisc multitail sudo
fi

# Install my keys, assuming the file is on pippi
if [ ! -d "${MYHOMESSH}" ]; then
                /bin/echo "$0: No .ssh folder found for ${ADDUSER}.  Creating, and putting in authorized keys."
                /bin/mkdir -p ${MYHOMESSH}
                /bin/chmod 700 ${MYHOMESSH}
                wget -q http://10.100.10.10/authorized_keys -O ${MYHOMESSH}/authorized_keys
                /bin/chmod 600 ${MYHOMESSH}/authorized_keys
                /bin/chown -R ${ADDUSER}:${ADDUSER} /home/${ADDUSER}/
else
                /bin/echo "$0: ${ADDUSER} .ssh folder found.  Will not alter any .ssh files for ${ADDUSER}."
fi

MYSUDOERS="${ADDUSER}        ALL=(ALL)       NOPASSWD: ALL"
/bin/echo ${MYSUDOERS} >> /etc/sudoers.d/10_${ADDUSER}

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
cd ${BOINC_PATH}

# useradd -r -m /opt/BOINC -s /bin/false boinc
# chown -R boinc:boinc ${BOINC_PATH}

# Set up service
#       This *sort* of works on systemd, but it's messy
#       and I have a lot of stuff on older versions of
#       Debian/Ubuntu with use inid/upstart :/
#       Commented out until I learn how to do this properly

#       systemctl enable boinc

# Set up client 
timeout -k 5m /etc/init.d/boinc attach 
reboot
exit 0
