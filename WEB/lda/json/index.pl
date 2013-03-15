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
    print kSChtml::ContentType("json");
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	$out.="\"HOST_". $c ."\":{\"NAME\":\"". $HIF[0][$c][0] ."\",\"ADDRESS\":\"". $HIF[0][$c][1] ."\",\"STATE\":\"". $HIF[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."\",\"SRV_OK\":\"". $HIF[0][$c][4] ."\",\"SRV_WA\":\"". $HIF[0][$c][5] ."\",\"SRV_CR\":\"". $HIF[0][$c][6] ."\",\"SRV_UN\":\"". $HIF[0][$c][7] ."\",\"SRV_PE\":\"". $HIF[0][$c][8] ."\",\"ACK\":\"". $HIF[0][$c][9] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][10]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][11] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."\",\"SERVICELIST\":{";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		$out.="\"SERVICE_". $m ."\":{\"NAME\":\"". $SFL[0][$k][1] ."\",\"STATE\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". $SFL[0][$k][4] ."\",\"LONG_OUTPUT\":\"". $SFL[0][$k][5] ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="}},";
    }
    $out = substr($out, 0, -1);
    print "{". $out ."}";
}
#
sub AllHosts {
    my $uid = shift;
    my @AH = kSClive::AllHosts($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    print kSChtml::ContentType("json");
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="\"HOST_". $c ."\":{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][2] ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
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
    print "{". $out ."}";
}
#
sub AllDatabases {
    my $uid = shift;
    my @AD = kSClive::AllDatabases($uid);
    print kSChtml::ContentType("json");
    my $out;
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	$out.="\"DATABASE_". $c ."\":{";
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
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","y") == 0) {
        AllHosts(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","y") == 0) {
        AllDatabases(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
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