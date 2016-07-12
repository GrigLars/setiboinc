# setiboinc
These are the files I need to run Seti@Boinc on a seti server.

##boinc_init 
- Commonly copied to /etc/init.d/boinc, this is the init.d service.  Right now it's kind of crude.

##cc_config.xml
- This is a config file I have used when the Smothwall firewall blocked work units

##setup_seti_grig.bash
- This is a setup script that automates an install

##To Do
[ ] Logrotate for logs
[ ] Make some ways to properly install as a service on init or systemd
[ ] Update the files with my older scripts and moderinize them

######Some links
https://boinc.berkeley.edu/wiki/Client_configuration


