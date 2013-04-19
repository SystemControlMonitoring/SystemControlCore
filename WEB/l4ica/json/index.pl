#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/sysinfo';
# Include Library
use kSChtml;
use kSCbasic;
use kSCsysinfo;
use warnings;
use strict;
use Data::Dumper;
#
#
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
