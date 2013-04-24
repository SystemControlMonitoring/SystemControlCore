#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/json';
# Include Library
use kSChtml;
use kSCbasic;
use kSCjson;
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
sub CheckProcess {
    # Get results
    my $pgst = kSCjson::CheckPostgresProcess();
    my $pgpo = kSCjson::CheckPostgresOpenPorts();
    my $gibc = kSCjson::CheckXinetdProcess();
    my $icck = kSCjson::CheckIcingaProcess();
    my $icpo = kSCjson::CheckIcingaOpenPorts();
    my $out;
    #
    # Postgres
    $out.="\"POSTGRES\":[";
    foreach my $key (keys %{$pgst}) {
	$out.= "{\"IP\":\"". $key ."\",\"NAME\":\"". $pgst->{$key}->{'name'} ."\",\"POSTGRE_PRC\":\"". $pgst->{$key}->{'result'}->{'POSTGRE_PRC'} ."\",";
	$out.= "\"PORT_NO\":\"". $pgpo->{$key}->{'result'}[0]->{'PORTNO'} ."\",\"PORT_ON\":\"". $pgpo->{$key}->{'result'}[0]->{'STATUS'} ."\"},";
    }
    $out = substr($out, 0, -1);
    $out.= "],";
    #
    # Icinga + Xinetd
    $out.="\"ICINGA\":[";
    foreach my $key (keys %{$icck}) {
	$out.= "{\"IP\":\"". $key ."\",\"NAME\":\"". $icck->{$key}->{'name'} ."\",\"ICINGA_PRC\":\"". $icck->{$key}->{'result'}->{'ICINGA_PRC'} ."\",\"XINETD_PRC\":\"". $gibc->{$key}->{'result'}->{'XINETD_PRC'} ."\",";
	$out.= "\"PORT_NO\":\"". $icpo->{$key}->{'result'}[0]->{'PORTNO'} ."\",\"PORT_ON\":\"". $icpo->{$key}->{'result'}[0]->{'STATUS'} ."\"},";
    }
    $out = substr($out, 0, -1);
    $out.= "]";
    # Output
    print kSChtml::ContentType("json");
    print "{". $out ."}";
}
#
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
    if (kSCbasic::CheckUrlKeyValue("m","CheckProcess","y") == 0) {
	CheckProcess();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","CheckProcess","n") == 0) {
	CheckProcess();
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
