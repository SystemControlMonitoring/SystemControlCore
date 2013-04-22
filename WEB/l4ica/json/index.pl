#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/sysinfo';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSChtml;
use kSCbasic;
use kSCsysinfo;
use kSCpostgre;
use warnings;
use strict;
use Data::Dumper;
#
# Precheck
if ( kSCpostgre::CheckHash(kSCbasic::HashFromString(kSCbasic::GetScriptPath()),kSCbasic::HashFromFile(kSCbasic::GetScriptPath()) ) == 0 ) {
    # go on
} else {
    print kSChtml::ContentType("html");
    print kSChtml::ErrorFileChanged();
    exit 2;
};
#
#
#
#
#
# Functions
#
sub CheckIcingaProcess {
    my $stat = kSCsysinfo::LinuxProcesses();
    print kSChtml::ContentType("text");
    foreach my $key (keys %{$stat}) {
	if ( $stat->{$key}->{'owner'} eq "icinga" ) {
	    print $key ."\n";
	    print $stat->{$key}->{'cmd'} ."\n";
	    print $stat->{$key}->{'cmdline'} ."\n";
	    print kSCsysinfo::LinuxProcessState($stat->{$key}->{'state'}) ."\n";
        }
    }
    print "Hello";
}
#
#
#
#
#
#
#
# Output
#
# e = encoded, m = module
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","y") == 0) {
	#SelectDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","y") == 0) {
	#InsertDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","y") == 0) {
	#DeleteDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckIcingaProcess","n") == 0) {
	CheckIcingaProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","n") == 0) {
	#InsertDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","n") == 0) {
	#DeleteDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","GetConfig","n") == 0) {
	#GetConfig(kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("xml");
    $out.= kSCbasic::ErrorMessage("xml","0");
    print $out;
}
#
# End
#
