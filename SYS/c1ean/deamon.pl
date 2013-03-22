#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSCpostgre;
use kSCbasic;
use warnings;
use strict;
#
binmode(STDOUT, ':utf8');
#
# Select Parameter
my $Modus = $ARGV[0];
#
#
#
#
sub Install {
    # Installation
}
#
sub Main {
    # Get PID
    kSCbasic::ShowEnv("Clean Liveticker Datasource");
    # Hauptfunktion
    while (1) {
	kSCpostgre::CleanLiveticker();
	sleep 60;
    }
}
#
sub DeInstall {
    # Deinstallation
}
#
sub NotSelected {
    # Keine Auswahl
    print "\n";
    print "\n";
    print "   #################################################################################\n";
    print "   #                                                                               #\n";
    print "   #  ######  #### ##     ##       ###     ######                                  #\n";
    print "   # ##    ##  ##  ##     ##      ## ##   ##    ##                                 #\n";
    print "   # ##        ##  ##     ##     ##   ##  ##                                       #\n";
    print "   #  ######   ##  ##     ##    ##     ## ##   ####                                #\n";
    print "   #       ##  ##   ##   ##     ######### ##    ##                                 #\n";
    print "   # ##    ##  ##    ## ##  ### ##     ## ##    ##                                 #\n";
    print "   #  ######  ####    ###   ### ##     ##  ######             03.2013 S.Baresel    #\n";
    print "   #                                                                               #\n";
    print "   #################################################################################\n";
    print "\n";
    print "   --- No Modus Selected ---\n";
    print "\n";
    print " Select one of the following options:\n";
    print "\n";
    print "   ./daemon.pl --install -> Install Prerequisits\n";
    print "   ./daemon.pl --start   -> Start Application\n";
    print "\n";
}
#
#
#
if (!defined $Modus){ $Modus = ""; }
#
if ($Modus eq "--install") {
    Install();
} elsif ($Modus eq "--start") {
    Main();
} elsif ($Modus eq "--deinstall") {
    DeInstall();
} else {
    NotSelected();
}
#
