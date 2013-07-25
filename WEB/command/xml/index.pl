#!/usr/bin/perl
#
# Include Library Path
use FCGI;
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
my $request = FCGI::Request();
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
    print kSChtml::ContentType("xml");
    print "<components>\n";
    print "   <postgre>\n";
    foreach my $key (keys %{$pgst}) {
	print "      <host>\n";
	print "         <ip>". $key ."</ip>\n";
	print "         <name>". $pgst->{$key}->{'name'} ."</name>\n";
	print "         <postgre_prc>". $pgst->{$key}->{'result'}->{'POSTGRE_PRC'} ."</postgre_prc>\n";
	print "         <port_no>". $pgpo->{$key}->{'result'}[0]->{'PORTNO'} ."</port_no>\n";
	print "         <port_on>". $pgpo->{$key}->{'result'}[0]->{'STATUS'} ."</port_on>\n";
	print "      </host>\n";
    }
    print "   </postgre>\n";
    #
    # Icinga + Xinetd
    print "   <icinga>";
    foreach my $key (keys %{$icck}) {
	print "      <host>\n";
	print "         <ip>". $key ."</ip>\n";
	print "         <name>". $icck->{$key}->{'name'} ."</name>\n";
	print "         <icinga_prc>". $icck->{$key}->{'result'}->{'ICINGA_PRC'} ."</icinga_prc>\n";
	print "         <xinetd_prc>". $gibc->{$key}->{'result'}->{'XINETD_PRC'} ."</xinetd_prc>\n";
	print "         <port_no>". $icpo->{$key}->{'result'}[0]->{'PORTNO'} ."</port_no>\n";
	print "         <port_on>". $icpo->{$key}->{'result'}[0]->{'STATUS'} ."</port_on>\n";
	print "      </host>\n";
    }
    # Output
    print "   </icinga>";
    print "</components>";
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
while($request->Accept() >= 0) {

if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","y") == 0) {
	ReCheck();
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","n") == 0) {
	ReCheck();
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
