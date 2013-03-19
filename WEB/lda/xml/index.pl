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
    print "</hostlist>";
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
    print "</hostlist>";
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
	    print
	     "      <name>". $AD[0][$c][0] ."</name>\n";
	}
	print "      <host>". $AD[0][$c][1] ."</host>\n";
	print "      <state>". $AD[0][$c][2] ."</state>\n";
	print "      <last_check_utime>". $AD[0][$c][3] ."</last_check_utime>\n";
	print "      <last_check_iso>". kSCbasic::ConvertUt2Ts($AD[0][$c][3]) ."</last_check_iso>\n";
	print "   </database>\n";
    }
    print "</databaselist>";
}
#
sub SlimTaov {
    my $uid = shift;
    my @TAOV = kSClive::TaovServices($uid);
    my @HTOV = kSClive::TaovHosts($uid);
    my $hstok=0; my $hstcr=0; my $hstun=0;
    my $hstnacr=0; my $hstnaun=0;
    my $hstacr=0; my $hstaun=0;
    my $srvok=0; my $srvwa=0; my $srvcr=0; my $srvun=0;
    my $srvnawa=0; my $srvnacr=0; my $srvnaun=0;
    my $srvawa=0; my $srvacr=0; my $srvaun=0;
    my $srvnawaoff=0; my $srvnacroff=0; my $srvnaunoff=0;
    my $pending=0;
    print kSChtml::ContentType("xml");
    for (my $c=0;$c<scalar(@{$HTOV[0]});$c++) {
	$hstok = $HTOV[0][$c][0] + $hstok;
	$hstcr = $HTOV[0][$c][1] + $hstcr;
	$hstnacr = $HTOV[0][$c][2] + $hstnacr;
	$hstacr = $HTOV[0][$c][3] + $hstacr;
	$hstun = $HTOV[0][$c][4] + $hstun;
	$hstnaun = $HTOV[0][$c][5] + $hstnaun;
	$hstaun = $HTOV[0][$c][6] + $hstaun;
    }
    for (my $c=0;$c<scalar(@{$TAOV[0]});$c++) {
	$srvok = $TAOV[0][$c][0] + $srvok;
	$srvwa = $TAOV[0][$c][1] + $srvwa;
	$srvnawa = $TAOV[0][$c][2] + $srvnawa;
	$srvawa = $TAOV[0][$c][3] + $srvawa;
	$srvnawaoff = $TAOV[0][$c][4] + $srvnawaoff;
	$srvcr = $TAOV[0][$c][5] + $srvcr;
	$srvnacr = $TAOV[0][$c][6] + $srvnacr;
	$srvacr = $TAOV[0][$c][7] + $srvacr;
	$srvnacroff = $TAOV[0][$c][8] + $srvnacroff;
	$srvun = $TAOV[0][$c][9] + $srvun;
	$srvnaun = $TAOV[0][$c][10] + $srvnaun;
	$srvaun = $TAOV[0][$c][11] + $srvaun;
	$srvnaunoff = $TAOV[0][$c][12] + $srvnaunoff;
	$pending = $TAOV[0][$c][13] + $pending;
    }
    print "<taov>\n";
    print "   <host>\n";
    print "      <ok>\n";
    print "         <c>". $hstok ."</c>\n";
    print "      </ok>\n";
    print "      <critical>\n";
    print "         <c>". $hstcr ."</c>\n";
    print "         <na>". $hstnacr ."</na>\n";
    print "         <a>". $hstacr ."</a>\n";
    print "      </critical>\n";
    print "      <unreachable>\n";
    print "         <c>". $hstun ."</c>\n";
    print "         <na>". $hstnaun ."</na>\n";
    print "         <a>". $hstaun ."</a>\n";
    print "      </unreachable>\n";
    print "   </host>\n";
    print "   <services>\n";
    print "      <ok>\n";
    print "         <on>". $srvok ."</on>\n";
    print "      </ok>\n";
    print "      <warning>\n";
    print "         <on>". $srvwa ."</on>\n";
    print "         <na_on>". $srvnawa ."</na_on>\n";
    print "         <a_on>". $srvawa ."</a_on>\n";
    print "         <na_off>". $srvnawaoff ."</na_off>\n";
    print "      </warning>\n";
    print "      <critical>\n";
    print "         <on>". $srvcr ."</on>\n";
    print "         <na_on>". $srvnacr ."</na_on>\n";
    print "         <a_on>". $srvacr ."</a_on>\n";
    print "         <na_off>". $srvnacroff ."</na_off>\n";
    print "      </critical>\n";
    print "      <unknown>\n";
    print "         <on>". $srvun ."</on>\n";
    print "         <na_on>". $srvnaun ."</na_on>\n";
    print "         <a_on>". $srvaun ."</a_on>\n";
    print "         <na_off>". $srvnaunoff ."</na_off>\n";
    print "      </unknown>\n";
    print "      <pending>\n";
    print "         <on>". $pending ."</on>";
    print "      </pending>\n";
    print "   </services>\n";
    print "</taov>";
}
#
sub ShowCritical {
    my $uid = shift;
    my $row = shift;
    my $lns = shift;
    my @SCS = kSClive::ShowCriticalServices($uid);
    my @SCH = kSClive::ShowCriticalHosts($uid);
    my @temp;
    print kSChtml::ContentType("xml");
    for (my $c=0;$c<scalar(@{$SCS[0]});$c++) {
	push @temp, [$SCS[0][$c][0],$SCS[0][$c][1],$SCS[0][$c][2],$SCS[0][$c][3],$SCS[0][$c][4],$SCS[0][$c][5]];
    }
    for (my $c=0;$c<scalar(@{$SCH[0]});$c++) {
	push @temp, [$SCH[0][$c][0],$SCH[0][$c][1],$SCH[0][$c][2],$SCH[0][$c][3],$SCH[0][$c][4],$SCH[0][$c][5]];
    }
    my @tmp = reverse sort {$a->[0] cmp $b->[0]} @temp;
    print "<critical>\n";
    my $cc;
    if ($lns > 0) {
	$cc = $lns;
    } else {
	$cc = scalar(@tmp);
    }
    for (my $c=0;$c<$cc;$c++) {
	print "   <entry>";
	print "      <timestamp_utime>". $tmp[$c][0] ."</timestamp_utime>";
	print "      <timestamp_iso>". kSCbasic::ConvertUt2Ts($tmp[$c][0]) ."</timestamp_iso>";
	print "      <display_name>". $tmp[$c][1] ."</display_name>";
	print "      <host_name>". $tmp[$c][2] ."</host_name>";
	print "      <service_state>". kSCbasic::GetStatusIcon($tmp[$c][3],"service") ."</service_state>";
	if ($tmp[$c][4] eq "0") {
	    print "      <host_state>HOST ONLINE</host_state>";
	} else {
	    print "      <host_state>HOST OFFLINE</host_state>";
	}
	if ($row > 0) {
	    print "      <output>". substr(kSCbasic::EncodeXML($tmp[$c][5]), 0, $row) ." [...]</output>";
	} else {
	    print "      <output>". kSCbasic::EncodeXML($tmp[$c][5]) ."</output>";
	}
	print "   </entry>";
    }
    print "</critical>";
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SlimTaov","y") == 0) {
    	SlimTaov(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
    	ShowCritical(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("r")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("l")));
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SlimTaov","n") == 0) {
    	SlimTaov(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","n") == 0) {
    	ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("r"),kSCbasic::GetUrlKeyValue("l"));
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