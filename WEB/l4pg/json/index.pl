#!/usr/bin/perl
#
# Include Library Path
use FCGI;
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
my $request = FCGI::Request();
#
#
#
#
#
# Functions
#
sub CheckPostgresProcess {
    my $stat = kSCsysinfo::LinuxProcesses();
    my $count=0;
    foreach my $key (keys %{$stat}) {
	if ( $stat->{$key}->{'cmdline'} =~ /postgres:/ ) {
	    $count++;
        }
    }
    print kSChtml::ContentType("json");
    print "{\"POSTGRE_PRC\":\"". $count ."\"}";
}
#
sub CheckPostgresOpenPorts {
    my $host_hr = kSCsysinfo::PostgresOpenPorts();
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
while($request->Accept() >= 0) {

if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckPostgresProcess","y") == 0) {
	CheckPostgresProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckPostgresOpenPorts","y") == 0) {
	CheckPostgresOpenPorts();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckPostgresProcess","n") == 0) {
	CheckPostgresProcess();
    } elsif (kSCbasic::CheckUrlKeyValue("m","CheckPostgresOpenPorts","n") == 0) {
	CheckPostgresOpenPorts();
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

}
#
# End
#
