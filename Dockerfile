# To change the hostname at runtime 
#  docker run -h "punkadyne-docker-${RANDOM}" -it  debian /etc/init.d/boinc 

# BOINC_ROOT="/opt"
# BOINC_PATH="${BOINC_ROOT}/BOINC"
# BOINC_VERSION="7.2.42"

FROM: debian:latest
RUN apt-get -y update && apt-get -y install wget libcurl3 libx11-6 libxss1 multitail
# wget -nv https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_init -O /etc/init.d/boinc
# wget -q http://boinc.berkeley.edu/dl/boinc_${BOINC_VERSION}_x86_64-pc-linux-gnu.sh 

CMD /etc/init.d/boinc
