#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSCpostgre;
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
#
sub AllHosts {
    my $uid = shift;
    my @AH = kSClive::AllHosts($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    print kSChtml::ContentType("xml");
    print "<hostlist>\n";
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	print "   <host>\n";
	print "      <name>". $AH[0][$c][0] ."</name>\n";
	print "      <state>". $AH[0][$c][2] ."</state>\n";
	print "      <custom_var>". uc($AH[0][$c][1][0]) ."</custom_var>\n";
	my @tmp = split(" ", uc($AH[0][$c][1][0]));
	if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."</icon>\n";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."</icon>\n";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."</icon>\n";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."</icon>\n";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."</icon>\n";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
	    print "      <icon>". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."</icon>\n";
	} else {
	    print "      <icon>". kSCbasic::GetHostIcon("ho") ."</icon>\n";
	}
	print "      <last_check_utime>". $AH[0][$c][3] ."</last_check_utime>\n";
	print "      <last_check_iso>". kSCbasic::ConvertUt2Ts($AH[0][$c][3]) ."</last_check_iso>\n";
	print "      <srv_ok>". $AH[0][$c][4] ."</srv_ok>\n";
	print "      <srv_wa>". $AH[0][$c][5] ."</srv_wa>\n";
	print "      <srv_cr>". $AH[0][$c][6] ."</srv_cr>\n";
	print "      <srv_un>". $AH[0][$c][7] ."</srv_un>\n";
	print "      <srv_pe>". $AH[0][$c][8] ."</srv_pe>\n";
	print "      <ack>". $AH[0][$c][9] ."</ack>\n";
	print "      <next_check_utime>". $AH[0][$c][10] ."</next_check_utime>\n";
	print "      <next_check_iso>". kSCbasic::ConvertUt2Ts($AH[0][$c][10]) ."</next_check_iso>\n";
	print "   </host>\n";
    }
    print "</hostlist>\n";
}
#
sub AllDatabases {
    my $uid = shift;
    my @AD = kSClive::AllDatabases($uid);
    print kSChtml::ContentType("xml");
    print "<databaselist>\n";
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	print "   <database>\n";
	if ($AD[0][$c][0] =~ /_DBST_/i) {
	    print "      <name>". uc(substr($AD[0][$c][0], 10)) ."</name>\n";
	} elsif ($AD[0][$c][0] =~ /_DBSTATUS/i) {
	    $AD[0][$c][0] =~ s/_DBSTATUS//g;
	    print "      <name>". uc(substr($AD[0][$c][0],7))  ."</name>\n";
	} else {
	    print "      <name>". $AD[0][$c][0] ."</name>\n";
	}
	print "      <host>". $AD[0][$c][1] ."</host>\n";
	print "      <state>". $AD[0][$c][2] ."</state>\n";
	print "      <last_check_utime>". $AD[0][$c][3] ."</last_check_utime>\n";
	print "      <last_check_iso>". kSCbasic::ConvertUt2Ts($AD[0][$c][3]) ."</last_check_iso>\n";
	print "   </database>\n";
    }
    print "</databaselist>\n";
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
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","y") == 0) {
    	AllHosts(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","y") == 0) {
    	AllDatabases(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	print kSChtml::ContentType("xml");
	print kSCbasic::ErrorMessage("xml","1");
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","n") == 0) {
	HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","n") == 0) {
    	AllHosts(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","n") == 0) {
    	AllDatabases(kSCbasic::GetUrlKeyValue("u"));
    } else {
	print kSChtml::ContentType("xml");
	print kSCbasic::ErrorMessage("xml","2");
    }
} else {
    print kSChtml::ContentType("xml");
    print kSCbasic::ErrorMessage("xml","0");
}
#
# End
#