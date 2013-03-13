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
    print "{". $out ."}\n";
}
# e = encoded, m = module
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.="{\"ERROR_1\":{\"MODULE\":\"kSCbasic::CheckUrlKeyValue,\"PROBLEM\":\"m=?\",";
	$out.= kSCbasic::ErrorCode("json","1");
	$out.=",\"URLPARA\":{";
	$out.= substr(kSCbasic::PrintUrlKeyValue("json"), 0, -1);
	$out.="}}";
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","n") == 0) {
	HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.="{\"ERROR_2\":{\"MODULE\":\"kSCbasic::CheckUrlKeyValue,\"PROBLEM\":\"m=?\",";
	$out.= kSCbasic::ErrorCode("json","2");
	$out.=",\"URLPARA\":{";
	$out.= substr(kSCbasic::PrintUrlKeyValue("json"), 0, -1);
	$out.="}}";
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("json");
    $out.="{\"ERROR_0\":{\"MODULE\":\"kSCbasic::CheckUrlKeyValue,\"PROBLEM\":\"e=?\",";
    $out.= kSCbasic::ErrorCode("json","0");
    $out.=",\"URLPARA\":{";
    $out.= substr(kSCbasic::PrintUrlKeyValue("json"), 0, -1);
    $out.="}}";
    print $out;
}
#
close STDERR;