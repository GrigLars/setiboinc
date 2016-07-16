# To change the hostname at runtime 
#  docker run -h "punkadyne-docker-${RANDOM}" -it  debian /etc/init.d/boinc 

# BOINC_ROOT="/opt"
# BOINC_PATH="$BOINC_ROOT/BOINC"
# BOINC_VERSION="boinc_7.2.42-pc-linux-gnu.sh"

FROM debian:latest
RUN apt-get update && apt-get install -y wget libcurl3 libx11-6 libxss1 multitail
RUN wget -q https://raw.githubusercontent.com/GrigLars/setiboinc/master/boinc_docker_init -O /etc/init.d/boinc \
    && chmod +x /etc/init.d/boinc 
RUN mkdir -p $BOINC_ROOT && cd $BOINC_ROOT \
    && wget -q http://boinc.berkeley.edu/dl/$BOINC_VERSION -P $BOINC_ROOT \
    && sh $BOINC_VERSION
CMD /etc/init.d/boinc attach
