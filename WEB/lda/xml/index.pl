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
    print kSChtml::ContentType("xml");
    print "<HOSTLIST>\n";
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	print "   <HOST>\n";
	print "      <NAME>". $HIF[0][$c][0] ."</NAME>\n";
	print "      <ADDRESS>". $HIF[0][$c][1] ."</ADDRESS>\n";
	print "      <STATE>". $HIF[0][$c][2] ."</STATE>\n";
	print "      <LAST_CHECK_UTIME>". $HIF[0][$c][3] ."</LAST_CHECK_UTIME>\n";
	print "      <LAST_CHECK_ISO>". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."</LAST_CHECK_ISO>\n";
	print "      <SRV_OK>". $HIF[0][$c][4] ."</SRV_OK>\n";
	print "      <SRV_WA>". $HIF[0][$c][5] ."</SRV_WA>\n";
	print "      <SRV_CR>". $HIF[0][$c][6] ."</SRV_CR>\n";
	print "      <SRV_UN>". $HIF[0][$c][7] ."</SRV_UN>\n";
	print "      <SRV_PE>". $HIF[0][$c][8] ."</SRV_PE>\n";
	print "      <SERVICES>\n";
	print "      </SERVICES>\n";
	print "   </HOST>\n";
    }
    print "</HOSTLIST>\n";
}
# e = encoded, m = module
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	print kSChtml::ContentType("xml");
	print "<FEHLER>\n<MESSAGE>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"m\",\"?\") .</MESSAGE>";
	print kSCbasic::PrintUrlKeyValue("xml");
	print "\n</FEHLER>\n";
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","n") == 0) {
	HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
    } else {
	print kSChtml::ContentType("xml");
	print "<FEHLER>\n<MESSAGE>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"m\",\"?\") .</MESSAGE>";
	print kSCbasic::PrintUrlKeyValue("xml");
	print "\n</FEHLER>\n";
    }
} else {
    print kSChtml::ContentType("xml");
    print "<FEHLER>\n<MESSAGE>Falsches Modul in kSCbasic::CheckUrlKeyValue(\"e\",\"?\") .</MESSAGE>\n";
    print kSCbasic::PrintUrlKeyValue("xml");
    print "\n</FEHLER>\n";
}
#
close STDERR;