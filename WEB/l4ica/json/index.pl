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
use strict;
use Data::Dumper;
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
    my $count=0;
    foreach my $key (keys %{$stat}) {
	if ( $stat->{$key}->{'cmdline'} =~ /icinga -d/ ) {
	    $count++;
        }
    }
    print kSChtml::ContentType("json");
    print "{\"ICINGA_PRC\":\"". $count ."\"}";
}
#
sub CheckXinetdProcess {
    my $stat = kSCsysinfo::LinuxProcesses();
    my $count=0;
    foreach my $key (keys %{$stat}) {
	if ( $stat->{$key}->{'cmdline'} =~ /xinetd -stayalive/ ) {
	    $count++;
        }
    }
    print kSChtml::ContentType("json");
    print "{\"XINETD_PRC\":\"". $count ."\"}";
}
#
sub CheckIcingaOpenPorts {
    my $host_hr = kSCsysinfo::IcingaOpenPorts();
    my $out;
    for my $port (sort {$a <=> $b} keys %{$host_hr->{tcp}}) {
	my $yesno = $host_hr->{tcp}{$port}{open} ? "yes" : "no";
	$out.="{\"PORTNO\":\"". $port ."\",\"STATUS\":\"". $host_hr->{tcp}{$port}{'open'} ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
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
    if (kSCbasic::CheckUrlKeyValue("m","CheckIcingaProcess","y") == 0) {
	CheckIcingaProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckIcingaOpenPorts","y") == 0) {
	CheckIcingaOpenPorts();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckXinetdProcess","y") == 0) {
	CheckXinetdProcess();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckIcingaProcess","n") == 0) {
	CheckIcingaProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckIcingaOpenPorts","n") == 0) {
	CheckIcingaOpenPorts();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckXinetdProcess","n") == 0) {
	CheckXinetdProcess();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("json");
    $out.= kSCbasic::ErrorMessage("json","0");
    print $out;
}
#
# End
#
