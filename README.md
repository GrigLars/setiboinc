# setiboinc
These are the files I need to run Seti@Boinc on a seti server.  This is for my own use, really, with my account ID attached.  Some of these are full of notes and comments particular to my issues with my home lab and some experiemnts.  I am team Punkadyne if you want to join.  Here's a list of files. I have on here, and what they do:

##setup_seti_grig.bash
This is a setup script that automates an install on a standard box.  Tested at of July 2016 on Debian 8 (Jessie), both 64 bit and 32 bit (I have some old-ass machines in my lab, mostly former core desktops).

##boinc_init 
Commonly copied to /etc/init.d/boinc, this is the init.d service.  Right now it's kind of crude.  I still have to make it a service, which differs so widely right now, I just dont want to deal with it until it becomes a standard.

##cc_config.xml
This is a config file I have used when the Smoothwall firewall blocked work units.  may be useful for other strict firewalls.  Dunno.

# Docker installs
- Dockerfile, self explanitory.  Still needs some work.  Takes over the TTY and seem really slow for some reason.
- boinc_docker_init, a modified and stripped startup init script.

##To Do
- Logrotate for logs (does killall do -SIGHUP?)
- Make some ways to properly install as a service on init or systemd
- Generate a status and PID file

##Some links
- Some client config notes: https://boinc.berkeley.edu/wiki/Client_configuration
- Manual on logrotate: http://www.linuxcommand.org/man_pages/logrotate8.html
- My SETI account (I have to be logged in): http://setiathome.berkeley.edu/home.php
- Source code for SETI: http://boinc.berkeley.edu/trac/wiki/SourceCodeGit

