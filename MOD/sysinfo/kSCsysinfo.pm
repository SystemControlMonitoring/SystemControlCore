#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use warnings;
use LWP::Simple;
use Config::Properties;
use Sys::Statistics::Linux::Processes;
# Name
package kSCsysinfo;
# Redirect Error Output
#########################################################
#                                                       #
#                  Read Configuration                   #
#                                                       #
#########################################################
open my $CF, '<', '/kSCcore/CFG/core.properties' or die "[". (localtime) ."] Kann Konfiguration '/kSCcore/CFG/core.properties' nicht öffnen!";
my $properties = Config::Properties->new();
$properties->load($CF);
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub LinuxProcesses {
    my $owner = shift;
    # Load Libarary
    my $lxs = Sys::Statistics::Linux::Processes->new;
    # Initiate
    $lxs->init;
    # Execute
    my $stat = $lxs->get;
    # Return
    return ($stat);
}
#
sub LinuxProcessState {
    my $ps = shift;
    my $rv;
    if ( $ps eq "D" ) {
        $rv = "Uninterruptible Sleep.";
    } elsif ( $ps eq "R") {
        $rv = "Running.";
    } elsif ( $ps eq "S") {
        $rv = "Interruptable Sleep.";
    } elsif ( $ps eq "T") {
        $rv = "Stopped.";
    } elsif ( $ps eq "W") {
        $rv = "Paging.";
    } elsif ( $ps eq "X") {
        $rv = "Dead.";
    } elsif ( $ps eq "Z") {
        $rv = "Zombie process.";
    } else {
        $rv = "N/A.";
    }
    return ($rv);
}
#
close ($CF);
#
1;
