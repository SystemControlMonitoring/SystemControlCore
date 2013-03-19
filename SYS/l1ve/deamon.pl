#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSClive;
use kSCbasic;
use kSCpostgre;
use warnings;
use strict;
use Data::Dumper;
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
    # Hauptfunktion
    kSCbasic::ShowEnv("LastCritical");
    while (1) {
	my @SNCH = kSClive::ShowNewCriticalHosts();
	for (my $c=0;$c<scalar(@{$SNCH[0]});$c++) {
	    print $SNCH[0][$c][0]."\n";
	}
	print "NEXT -->\n";
	sleep 2;
    }
}
#
sub DeInstall {
    # Deinstallation
}
#
sub NotSelected {
    # Keine Auswahl
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