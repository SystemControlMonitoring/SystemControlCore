#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use kSClive;
use kSChtml;
use kSCbasic;
use warnings;
use strict;
use Data::Dumper;
#
#
# Redirect Error Output
open STDERR, '>>/kSCcore/LOG/error.log';
#
sub HostFullInfo {
    my $uid = shift;
    my @HIF = kSClive::HostFullInfo($uid);
    my @SFL = kSClive::ServiceFullList($uid);
    print kSChtml::ContentType("xml");
    print "<hostlist>\n";
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	print "   <host>\n";
	print "      <name>". $HIF[0][$c][0] ."</name>\n";
	print "      <address>". $HIF[0][$c][1] ."</address>\n";
	print "      <state>". $HIF[0][$c][2] ."</state>\n";
	print "      <last_check_utime>". $HIF[0][$c][3] ."</last_check_utime>\n";
	print "      <last_check_iso>". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."</last_check_iso>\n";
	print "      <srv_ok>". $HIF[0][$c][4] ."</srv_ok>\n";
	print "      <srv_wa>". $HIF[0][$c][5] ."</srv_wa>\n";
	print "      <srv_cr>". $HIF[0][$c][6] ."</srv_cr>\n";
	print "      <srv_un>". $HIF[0][$c][7] ."</srv_un>\n";
	print "      <srv_pe>". $HIF[0][$c][8] ."</srv_pe>\n";
	print "      <ack>". $HIF[0][$c][9] ."</ack>\n";
	print "      <output>". kSCbasic::EncodeXML($HIF[0][$c][10]) ."</output>\n";
	print "      <next_check_utime>". $HIF[0][$c][11] ."</next_check_utime>\n";
	print "      <next_check_iso>". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."</next_check_iso>\n";
	print "      <servicelist>\n";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		print "         <service>\n";
		print "            <name>". $SFL[0][$k][1] ."</name>\n";
		print "            <state>". $SFL[0][$k][2] ."</state>\n";
		print "            <last_check_utime>". $SFL[0][$k][3] ."</last_check_utime>\n";
		print "            <last_check_iso>". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."</last_check_iso>\n";
		print "            <output>". kSCbasic::EncodeXML($SFL[0][$k][4]) ."</output>\n";
		print "            <long_output>". kSCbasic::EncodeXML($SFL[0][$k][5]) ."</long_output>\n";
		print "            <ack>". $SFL[0][$k][6] ."</ack>\n";
		print "            <next_check_utime>". $SFL[0][$k][7] ."</next_check_utime>\n";
		print "            <next_check_iso>". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."</next_check_iso>\n";
		print "         </service>\n";
	    }
	}
	print "      </servicelist>\n";
	print "   </host>\n";
    }
    print "</hostlist>\n";
}
# e = encoded, m = module
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	print kSChtml::ContentType("xml");
	print "<error>\n<message>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"m\",\"?\") .</message>";
	print kSCbasic::PrintUrlKeyValue("xml");
	print "\n</error>\n";
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","n") == 0) {
	HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
    } else {
	print kSChtml::ContentType("xml");
	print "<error>\n<message>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"m\",\"?\") .</message>";
	print kSCbasic::PrintUrlKeyValue("xml");
	print "\n</error>\n";
    }
} else {
    print kSChtml::ContentType("xml");
    print "<error>\n<message>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"e\",\"?\") .</message>\n";
    print kSCbasic::PrintUrlKeyValue("xml");
    print "\n</error>\n";
}
#
close STDERR;