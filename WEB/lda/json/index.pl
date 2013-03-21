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
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $HIF[0][$c][0] ."\",\"ADDRESS\":\"". $HIF[0][$c][1] ."\",\"STATE\":\"". $HIF[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."\",\"SRV_OK\":\"". $HIF[0][$c][4] ."\",\"SRV_WA\":\"". $HIF[0][$c][5] ."\",\"SRV_CR\":\"". $HIF[0][$c][6] ."\",\"SRV_UN\":\"". $HIF[0][$c][7] ."\",\"SRV_PE\":\"". $HIF[0][$c][8] ."\",\"ACK\":\"". $HIF[0][$c][9] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][10]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][11] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."\",\"SERVICELIST\":{";
	$out.="{\"NAME\":\"". $HIF[0][$c][0] ."\",\"ADDRESS\":\"". $HIF[0][$c][1] ."\",\"STATE\":\"". $HIF[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."\",\"SRV_OK\":\"". $HIF[0][$c][4] ."\",\"SRV_WA\":\"". $HIF[0][$c][5] ."\",\"SRV_CR\":\"". $HIF[0][$c][6] ."\",\"SRV_UN\":\"". $HIF[0][$c][7] ."\",\"SRV_PE\":\"". $HIF[0][$c][8] ."\",\"ACK\":\"". $HIF[0][$c][9] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][10]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][11] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		#$out.="\"SERVICE_". $m ."\":{\"NAME\":\"". $SFL[0][$k][1] ."\",\"STATE\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". $SFL[0][$k][4] ."\",\"LONG_OUTPUT\":\"". $SFL[0][$k][5] ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\"},";
		$out.="{\"NAME\":\"". $SFL[0][$k][1] ."\",\"STATE\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AllHosts {
    my $uid = shift;
    my @AH = kSClive::AllHosts($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][2] ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][2] ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
        my @tmp = split(" ", uc($AH[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\"";
        }
	$out.=",\"LAST_CHECK_UTIME\":\"". $AH[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][3]) ."\",\"SRV_OK\":\"". $AH[0][$c][4] ."\",\"SRV_WA\":\"". $AH[0][$c][5] ."\",\"SRV_CR\":\"". $AH[0][$c][6] ."\",\"SRV_UN\":\"". $AH[0][$c][7] ."\",\"SRV_PE\":\"". $AH[0][$c][8] ."\",\"ACK\":\"". $AH[0][$c][9] ."\",\"NEXT_CHECK_UTIME\":\"". $AH[0][$c][10] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][10]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AllDatabases {
    my $uid = shift;
    my @AD = kSClive::AllDatabases($uid);
    my $out;
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	#$out.="\"DATABASE_". $c ."\":{";
	$out.="{";
        if ($AD[0][$c][0] =~ /_DBST_/i) {
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][0], 10)) ."\"";
        } elsif ($AD[0][$c][0] =~ /_DBSTATUS/i) {
            $AD[0][$c][0] =~ s/_DBSTATUS//g;
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][0],7))  ."\"";
        } else {
            $out.="\"NAME\":\"". $AD[0][$c][0] ."\"";
        }
        $out.=",\"HOST\":\"". $AD[0][$c][1] ."\",\"STATE\":\"". $AD[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][3]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
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
    print kSChtml::ContentType("json");
    print "{\"HOST\":{\"OK\":{\"COUNT\":\"". $hstok ."\"},\"CRITICAL\":{\"COUNT\":\"". $hstcr ."\",\"NACK\":\"". $hstnacr ."\",\"ACK\":\"". $hstacr ."\"},\"UNREACHABLE\":{\"COUNT\":\"". $hstun ."\",\"NACK\":\"". $hstnaun ."\",\"ACK\":\"". $hstaun ."\"}},\"SERVICE\":{\"OK\":{\"COUNT_ON\":\"". $srvok ."\"},\"WARNING\":{\"COUNT_ON\":\"". $srvwa ."\",\"NACK_ON\":\"". $srvnawa ."\",\"ACK_ON\":\"". $srvawa ."\",\"NACK_OFF\":\"". $srvnawaoff ."\"},\"CRITICAL\":{\"COUNT_ON\":\"". $srvcr ."\",\"NACK_ON\":\"". $srvnacr ."\",\"ACK_ON\":\"". $srvacr ."\",\"NACK_OFF\":\"". $srvnacroff ."\"},\"UNKNOWN\":{\"COUNT_ON\":\"". $srvun ."\",\"NACK_ON\":\"". $srvnaun ."\",\"ACK_ON\":\"". $srvaun ."\",\"NACK_OFF\":\"". $srvnaunoff ."\"},\"PENDING\":{\"COUNT_ON\":\"". $pending ."\"}}}";
}
#
sub ShowCritical {
    my $uid = shift;
    my $row = shift;
    my $lns = shift;
    my @SCS = kSClive::ShowCriticalServices($uid);
    my @SCH = kSClive::ShowCriticalHosts($uid);
    my @temp;
    for (my $c=0;$c<scalar(@{$SCS[0]});$c++) {
        push @temp, [$SCS[0][$c][0],$SCS[0][$c][1],$SCS[0][$c][2],$SCS[0][$c][3],$SCS[0][$c][4],$SCS[0][$c][5]];
    }
    for (my $c=0;$c<scalar(@{$SCH[0]});$c++) {
        push @temp, [$SCH[0][$c][0],$SCH[0][$c][1],$SCH[0][$c][2],$SCH[0][$c][3],$SCH[0][$c][4],$SCH[0][$c][5]];
    }
    my @tmp = reverse sort {$a->[0] cmp $b->[0]} @temp;
    my $cc;
    my $out;
    if ($lns > 0) {
        $cc = $lns;
    } else {
        $cc = scalar(@tmp);
    }
    for (my $c=0;$c<$cc;$c++) {
        $out.="{\"TIMESTAMP_UTIME\":\"". $tmp[$c][0] ."\",\"TIMESTAMP_ISO\":\"". kSCbasic::ConvertUt2Ts($tmp[$c][0]) ."\",\"DISPLAY_NAME\":\"". $tmp[$c][1] ."\",\"HOST_NAME\":\"". $tmp[$c][2] ."\",\"SERVICE_STATE\":\"". kSCbasic::GetStatusIcon($tmp[$c][3],"service") ."\",";
        if ($tmp[$c][4] eq "0") {
    	    $out.="\"HOST_STATE\":\"HOST ONLINE\",";
    	} else {
    	    $out.="\"HOST_STATE\":\"HOST OFFLINE\",";
    	}
        if ($row > 0) {
            $out.="\"OUTPUT\":\"". substr(kSCbasic::EncodeHTML($tmp[$c][5]), 0, $row) ." [...]\"";
        } else {
            $out.="\"OUTPUT\":\"". kSCbasic::EncodeHTML($tmp[$c][5]) ."\"";
        }
        $out.="},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub SelectLiveticker {
    my $uid = shift;
    my $row = shift;
    my $lns = shift;
    my $cut = time;
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    my $sth = kSCpostgre::SelectLiveticker($uid);
    while ( (my $hn,my $cv, my $hs,my $sn,my $st,my $ot,my $ts) = $sth->fetchrow_array()) {
	$out.="{\"TIMESTAMP_UTIME\":\"". $ts ."\",\"TIMESTAMP_ISO\":\"". kSCbasic::ConvertUt2Ts($ts) ."\",";
        if ( $cut-300 < $ts ) {
            $out.="\"INCIDENT\":\"NEW\",";
        } else {
            $out.="\"INCIDENT\":\"NOTICED\",";
        }
        $out.="\"DISPLAY_NAME\":\"". $sn ."\",\"HOST_NAME\":\"". $hn ."\",\"SERVICE_STATE\":\"". kSCbasic::GetStatusIcon($st,"service") ."\",";
        if ($hs eq "0") {
            $out.="\"HOST_STATE\":\"HOST ONLINE\",";
        } else {
    	    $out.="\"HOST_STATE\":\"HOST OFFLINE\",";
        }
        $out.="\"CUSTOM_VAR\":\"". uc($cv) ."\",";
        my @tp = split(" ", uc($cv));
        if (kSCbasic::GetHostIcon($AHI{$tp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[0]}) ."\",";
        } elsif (kSCbasic::GetHostIcon($AHI{$tp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[1]}) ."\",";
        } elsif (kSCbasic::GetHostIcon($AHI{$tp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[2]}) ."\",";
        } elsif (kSCbasic::GetHostIcon($AHI{$tp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[3]}) ."\",";
        } elsif (kSCbasic::GetHostIcon($AHI{$tp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[4]}) ."\",";
        } elsif (kSCbasic::GetHostIcon($AHI{$tp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tp[5]}) ."\",";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
        }
        if ($row > 0) {
            $out.="\"OUTPUT\":\"". substr(kSCbasic::EncodeHTML($ot), 0, $row) ." [...]\"";
        } else {
            $out.="\"OUTPUT\":\"". kSCbasic::EncodeHTML($ot) ."\"";
        }
        $out.="},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub FillLiveticker {
    my $uid = shift;
    # Services
    my @SCS = kSClive::ShowNewCriticalServices($uid);
    for (my $c=0;$c<scalar(@{$SCS[0]});$c++) {
        kSCpostgre::FillLiveticker($uid,$SCS[0][$c][2],$SCS[0][$c][5][0],$SCS[0][$c][4],$SCS[0][$c][1],$SCS[0][$c][3],kSCbasic::EncodeXML($SCS[0][$c][6]));
    }
    # Host
    my @SCH = kSClive::ShowNewCriticalHosts($uid);
    for (my $c=0;$c<scalar(@{$SCH[0]});$c++) {
        kSCpostgre::FillLiveticker($uid,$SCH[0][$c][2],$SCH[0][$c][5][0],$SCH[0][$c][4],$SCH[0][$c][1],$SCH[0][$c][3],kSCbasic::EncodeXML($SCH[0][$c][6]));
    }
    print kSChtml::ContentType("json");
    print "{\"EXEC\":\"UPDATED\"}";
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","y") == 0) {
        SelectLiveticker(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","y") == 0) {
        FillLiveticker(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
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
    } elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","n") == 0) {
        SelectLiveticker(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","n") == 0) {
        FillLiveticker(kSCbasic::GetUrlKeyValue("u"));
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
