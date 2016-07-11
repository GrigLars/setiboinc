# setiboinc
These are the files I need to run Seti@Boinc on a seti server

1. boinc_init = /etc/init.d/boinc
2. chmod+x /etc/init.d/boinc
3. cd /opt
4. Get the latest (uname -m)
    a. http://boinc.berkeley.edu/dl/boinc_7.2.42_x86_64-pc-linux-gnu.sh
    b. http://boinc.berkeley.edu/dl/boinc_7.2.42_i686-pc-linux-gnu.sh
5. sh boinc_*
6. cd BOINC/
7. ./boinc -no_gui_rpc -attach_project http://setiathome.berkeley.edu d14af2375aa9c85dd1251f0f04d09654
8. 
