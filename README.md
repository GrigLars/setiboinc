# setiboinc
These are the files I need to run Seti@Boinc on a seti server

- boinc_init = /etc/init.d/boinc
- chmod+x /etc/init.d/boinc
- cd /opt
- Get the latest (uname -m)
    - http://boinc.berkeley.edu/dl/boinc_7.2.42_x86_64-pc-linux-gnu.sh
    - http://boinc.berkeley.edu/dl/boinc_7.2.42_i686-pc-linux-gnu.sh
- sh boinc_*
- cd BOINC/
- ./boinc -no_gui_rpc -attach_project http://setiathome.berkeley.edu d14af2375aa9c85dd1251f0f04d09654

