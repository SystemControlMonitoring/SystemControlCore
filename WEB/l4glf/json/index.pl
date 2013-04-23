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
# Functions
#
sub CheckGlassfishProcess {
    my $stat = kSCsysinfo::LinuxProcesses();
    my $count=0;
    foreach my $key (keys %{$stat}) {
	if ( $stat->{$key}->{'cmdline'} =~ /glassfish/ ) {
	    $count++;
        }
    }
    print kSChtml::ContentType("json");
    print "{\"GLASSFISH_PRC\":\"". $count ."\"}";
}
#
sub CheckGlassfishOpenPorts {
    my $host_hr = kSCsysinfo::GlassfishOpenPorts();
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
    if (kSCbasic::CheckUrlKeyValue("m","CheckGlassfishProcess","y") == 0) {
	CheckGlassfishProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckGlassfishOpenPorts","y") == 0) {
	CheckGlassfishOpenPorts();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckGlassfishProcess","n") == 0) {
	CheckGlassfishProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckGlassfishOpenPorts","n") == 0) {
	CheckGlassfishOpenPorts();
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
