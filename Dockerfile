# To change the hostname at runtime 
#  docker run -h "punkadyne-docker-${RANDOM}" -it  debian /etc/init.d/boinc 

# BOINC_ROOT="/opt"
# BOINC_PATH="${BOINC_ROOT}/BOINC"
# BOINC_VERSION="7.2.42"

FROM debian:latest
RUN apt-get update && apt-get install -y wget libcurl3 libx11-6 libxss1 multitail
RUN wget -q https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_docker_init -O /etc/init.d/boinc \
    && chmod +x /etc/init.d/boinc \
RUN mkdir -p ${BOINC_ROOT} && cd ${BOINC_ROOT} \
    && wget -q http://boinc.berkeley.edu/dl/boinc_${BOINC_VERSION}_x86_64-pc-linux-gnu.sh -P ${BOINC_ROOT} \
    && sh boinc_${BOINC_VERSION}_x86_64-pc-linux-gnu.sh
CMD /etc/init.d/boinc attach
