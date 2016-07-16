# To change the hostname at runtime 
#  docker run -h "punkadyne-docker-${RANDOM}" -it  debian /etc/init.d/boinc 

FROM: debian:latest
RUN apt-get -y update && apt-get -y install wget libcurl3 libx11-6 libxss1 multitail
