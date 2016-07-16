# To change the hostname at runtime 
#  docker run -h "punkadyne-docker-${RANDOM}" -it  debian /etc/init.d/boinc 

FROM debian:latest
RUN apt-get update && apt-get install -y wget libcurl3 libx11-6 libxss1 multitail
RUN wget -q https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_docker_init -O /etc/init.d/boinc \
    && chmod +x /etc/init.d/boinc 
RUN mkdir -p /opt && cd /opt \
    && wget -q http://boinc.berkeley.edu/dl/boinc_7.2.42_x86_64-pc-linux-gnu.sh -P /opt \
    && sh boinc_7.2.42_x86_64-pc-linux-gnu.sh
CMD /etc/init.d/boinc attach
