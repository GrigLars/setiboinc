# Change the hostname at runtime
#    Go into a working directory (not root) and wget this Dockerfile
#    $ docker build -f Dockerfile .
#      [some stuff...]
#    Successfully built 8de238193c90
#    $ docker run -h punkadyne-docker 8de238193c90 

# Tested on Debian 8 (Jessie)
FROM debian:latest
RUN apt-get update && apt-get install -y wget libcurl3 libx11-6 libxss1 multitail psmisc 
RUN wget -q https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_docker_init -O /etc/init.d/boinc \
    && chmod +x /etc/init.d/boinc 
RUN mkdir -p /opt && cd /opt \
    && wget -q http://boinc.berkeley.edu/dl/boinc_7.2.42_x86_64-pc-linux-gnu.sh -P /opt \
    && sh boinc_7.2.42_x86_64-pc-linux-gnu.sh \
    && wget https://github.com/GrigLars/setiboinc/blob/master/cc_config.xml -P /opt/BOINC
CMD /etc/init.d/boinc attach
