#!/usr/bin/perl

# The bash script sucked, trying perl

use strict;

my @servers = ( "belldandy",
                "pikachu","toshiuki","sayako","riachu","totoro",  
                "haku","pussyfoot","calcifer",
                "yubaba",
                "ponyo", "togepi","magikarp",
                "mothra","gamera");

my %server_result=qw();
my $running_what=qw();
my $seti_grep=qw();
my @ssh_array=qw();
my %server_uptime=qw();
my %server_speed=qw();
my $ssh_command="ssh -o ConnectTimeout=1";
my %server_distro=qw();

print "SETI BOINC STATS\n------\n\n";

format STDOUT_TOP = 
Server     SETIType    RunTime AsUser      Uptime     Speed      Reported Distro
----------------------------------------------------------------------------------
.

format STDOUT =
@<<<<<<<<  @<<<<<<<<< @>>>>>>> @<<<<<<@###.# days @>>>>>>>> mhz  @<<<<<<<<<<<<<<<<<<<
        $seti_grep $ssh_array[10] $ssh_array[9]  $ssh_array[0] $server_uptime{$seti_grep} $server_speed{$seti_grep} $server_distro{$seti_grep}
.

foreach $seti_grep (@servers) {
        if ($seti_grep eq "yubaba") {$seti_grep = $seti_grep." -p 21138";}
        if ($seti_grep eq "zeniba") {$seti_grep = $seti_grep." -p 222";}
        $server_uptime{$seti_grep}=`$ssh_command $seti_grep 'cat /proc/uptime | cut -d. -f1' 2> /dev/null`;
        if ($server_uptime{$seti_grep}) {
                $server_uptime{$seti_grep} = ($server_uptime{$seti_grep} / 60 / 60 / 24) ; 
                $server_speed{$seti_grep}=`$ssh_command $seti_grep 'cat /proc/cpuinfo |  grep "cpu MHz" | cut -d: -f2' 2> /dev/null`;
                if ($seti_grep eq "ponyo") {
                        $server_speed{$seti_grep}="133.000";
                }
                if ($seti_grep eq "magikarp") {
                        $server_speed{$seti_grep}="1200.000";
                }
        } else {
                $server_uptime{$seti_grep} = "-1";
                $server_speed{$seti_grep} = "serv_down";

        }

        $server_distro{$seti_grep}=`$ssh_command $seti_grep 'head -n 1 /etc/issue.net' 2> /dev/null`;
                # print "Server Distro: $server_distro{$seti_grep}\n";
        if ($server_distro{$seti_grep} =~ m/Debian/) {
                if ($server_distro{$seti_grep} =~ m/4.0/) {
                        $server_distro{$seti_grep} = "Debian 4";
                } elsif ($server_distro{$seti_grep} =~ m/5.0/) {
                         $server_distro{$seti_grep} = "Debian 5";
                } elsif ($server_distro{$seti_grep} =~ m/6.0/) {
                         $server_distro{$seti_grep} = "Debian 6";
                } else {
                         $server_distro{$seti_grep} = "Debian ?";
                } 


        } elsif ($server_distro{$seti_grep} =~ m/Ubuntu/) {
                # The title is fine

        } elsif ($server_distro{$seti_grep} =~ m/Cent/) {
                my @distro_array = split(/\s+/, $server_distro{$seti_grep});
                 $server_distro{$seti_grep} = "CentOS $distro_array[2]";

        } else {
                 $server_distro{$seti_grep} = "Damn Dead Linux";

        }

        $server_result{$seti_grep}=`$ssh_command $seti_grep 'ps aux | grep [a]stropulse' 2> /dev/null`;
        if ($server_result{$seti_grep}) {
                @ssh_array=split(/\s+/, $server_result{$seti_grep});


                # print "$seti_grep: Running Astropulse\n";
                write;

        } else {
                $server_result{$seti_grep}=`$ssh_command $seti_grep 'ps aux | grep [s]eti' 2> /dev/null`;
                if  ($server_result{$seti_grep}) {
                        # print "$seti_grep: Running plain SETI\@HOME\n";
                        @ssh_array=split(/\s+/, $server_result{$seti_grep});
                        $ssh_array[10] = "setiathome";
                        write;

                } else {
                        $server_result{$seti_grep}=`$ssh_command $seti_grep 'ps aux | grep [b]oinc' 2> /dev/null`;
                        if ($server_result{$seti_grep}) {
                                @ssh_array=split(/\s+/, $server_result{$seti_grep});
                                $ssh_array[10] = "just boinc";
                                write;

                        } else {
                                $ssh_array[10] = " -nothing-";
                                $ssh_array[9] = "--:--";
                                $ssh_array[0] = "-----\n";

                        # print "$seti_grep: UNKNOWN\n";
                        write;
                        }

                }
        }


}
print "\n....\nCreated by $0 \n";
exit 0;
