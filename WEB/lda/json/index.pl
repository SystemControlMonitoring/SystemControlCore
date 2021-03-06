#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSCpostgre;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
while($request->Accept() >= 0) {
    if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	    HostFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfo","y") == 0) {
	    DatabaseFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfo","y") == 0) {
	    MiddlewareFullInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","y") == 0) {
    	    AllHosts(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","y") == 0) {
    	    AllDatabases(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SlimTaov","y") == 0) {
    	    SlimTaov(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
    	    ShowCritical(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","y") == 0) {
    	    SelectLiveticker(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","y") == 0) {
    	    FillLiveticker(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceStatusSelect","y") == 0) {
    	    ServiceStatusSelect(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostStatusSelect","y") == 0) {
    	    HostStatusSelect(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseStatusSelect","y") == 0) {
    	    DatabaseStatusSelect(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoStatusHost","y") == 0) {
    	    HostFullInfoStatusHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoStatusDatabase","y") == 0) {
    	    DatabaseFullInfoStatusDatabase(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoStatusMiddleware","y") == 0) {
    	    MiddlewareFullInfoStatusMiddleware(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("s")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceSearchList","y") == 0) {
    	    ServiceSearchList(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSearchList","y") == 0) {
    	    HostSearchList(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoSearchHost","y") == 0) {
    	    HostFullInfoSearchHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoSearchDatabase","y") == 0) {
    	    DatabaseFullInfoSearchDatabase(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoSearchMiddleware","y") == 0) {
    	    MiddlewareFullInfoSearchMiddleware(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseSearchList","y") == 0) {
    	    DatabaseSearchList(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("searchstring")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowAllComments","y") == 0) {
    	    ShowAllComments(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} else {
	    my $out = kSChtml::ContentType("json");
	    $out.= kSCbasic::ErrorMessage("json","1");
	    print $out;
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","n") == 0) {
	    HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfo","n") == 0) {
	    DatabaseFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfo","n") == 0) {
	    MiddlewareFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","n") == 0) {
    	    AllHosts(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","n") == 0) {
    	    AllDatabases(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SlimTaov","n") == 0) {
    	    SlimTaov(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","n") == 0) {
    	    ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","n") == 0) {
    	    SelectLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","n") == 0) {
    	    FillLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceStatusSelect","n") == 0) {
    	    ServiceStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostStatusSelect","n") == 0) {
    	    HostStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoStatusHost","n") == 0) {
    	    HostFullInfoStatusHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoStatusDatabase","n") == 0) {
    	    DatabaseFullInfoStatusDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoStatusMiddleware","n") == 0) {
    	    MiddlewareFullInfoStatusMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseStatusSelect","n") == 0) {
    	    DatabaseStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceSearchList","n") == 0) {
    	    ServiceSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSearchList","n") == 0) {
    	    HostSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoSearchHost","n") == 0) {
    	    HostFullInfoSearchHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoSearchDatabase","n") == 0) {
    	    DatabaseFullInfoSearchDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoSearchMiddleware","n") == 0) {
    	    MiddlewareFullInfoSearchMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseSearchList","n") == 0) {
    	    DatabaseSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowAllComments","n") == 0) {
    	    ShowAllComments(kSCbasic::GetUrlKeyValue("u"));
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
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	$out.="{\"NAME\":\"". $HIF[0][$c][0] ."\",\"CUSTOM_VAR\":\"". uc($HIF[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($HIF[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"ADDRESS\":\"". $HIF[0][$c][2] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($HIF[0][$c][3],"host") ."\",\"STATUS\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][4]) ."\",\"SRV_OK\":\"". $HIF[0][$c][5] ."\",\"SRV_WA\":\"". $HIF[0][$c][6] ."\",\"SRV_CR\":\"". $HIF[0][$c][7] ."\",\"SRV_UN\":\"". $HIF[0][$c][8] ."\",\"SRV_PE\":\"". $HIF[0][$c][9] ."\",\"ACK\":\"". $HIF[0][$c][10] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][11]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][12]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$HIF[0][$c][13]}) {
	    $out.= $cmt .",";
	}
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		foreach my $cmt (@{$SFL[0][$k][8]}) {
		    $out.= $cmt .",";
		}
		$out = substr($out, 0, -1);
		$out.="\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostFullInfoSearchHost {
    my $uid = shift;
    my $searchstring = shift;
    my @HIF = kSClive::HostSearchList($uid,$searchstring);
    my @SFL = kSClive::ServiceFullList($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	$out.="{\"STRING\":\"". $searchstring ."\",\"NAME\":\"". $HIF[0][$c][0] ."\",\"CUSTOM_VAR\":\"". uc($HIF[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($HIF[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"ADDRESS\":\"". $HIF[0][$c][2] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($HIF[0][$c][3],"host") ."\",\"STATUS\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][4]) ."\",\"SRV_OK\":\"". $HIF[0][$c][5] ."\",\"SRV_WA\":\"". $HIF[0][$c][6] ."\",\"SRV_CR\":\"". $HIF[0][$c][7] ."\",\"SRV_UN\":\"". $HIF[0][$c][8] ."\",\"SRV_PE\":\"". $HIF[0][$c][9] ."\",\"ACK\":\"". $HIF[0][$c][10] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][11]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][12]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$HIF[0][$c][13]}) {
	    $out.= $cmt .",";
	}
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		foreach my $cmt (@{$SFL[0][$k][8]}) {
		    $out.= $cmt .",";
		}
		$out = substr($out, 0, -1);
		$out.="\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostFullInfoStatusHost {
    my $uid = shift;
    my $status = shift;
    my @HIF;
    # PreCheck
    if ($status eq "up") {
	@HIF = kSClive::HostUp($uid);
    } elsif ($status eq "do") {
	@HIF = kSClive::HostDo($uid);
    } elsif ($status eq "un") {
	@HIF = kSClive::HostUn($uid);
    } elsif ($status eq "nok") {
	@HIF = kSClive::HostNok($uid);
    } elsif ($status eq "noknodt") {
	@HIF = kSClive::HostNokNodt($uid);
    } elsif ($status eq "nokdt") {
	@HIF = kSClive::HostNokDt($uid);
    } elsif ($status eq "donoack") {
	@HIF = kSClive::HostDoNoack($uid);
    } elsif ($status eq "doack") {
	@HIF = kSClive::HostDoAck($uid);
    } elsif ($status eq "unnoack") {
	@HIF = kSClive::HostUnNoack($uid);
    } elsif ($status eq "unack") {
	@HIF = kSClive::HostUnAck($uid);
    } elsif ($status eq "donacknodt") {
	@HIF = kSClive::HostDoNoackNodt($uid);
    } elsif ($status eq "doacknodt") {
	@HIF = kSClive::HostDoAckNodt($uid);
    } elsif ($status eq "donackdt") {
	@HIF = kSClive::HostDoNoackDt($uid);
    } elsif ($status eq "doackdt") {
	@HIF = kSClive::HostDoAckDt($uid);
    } elsif ($status eq "unnoacknodt") {
	@HIF = kSClive::HostUnNoackNodt($uid);
    } elsif ($status eq "unacknodt") {
	@HIF = kSClive::HostUnAckNodt($uid);
    } elsif ($status eq "unnoackdt") {
	@HIF = kSClive::HostUnNoackDt($uid);
    } elsif ($status eq "unackdt") {
	@HIF = kSClive::HostUnAckDt($uid);
    } else {
	@HIF = kSClive::HostFullInfo($uid);
    }
    # Execution
    my @SFL = kSClive::ServiceFullList($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	$out.="{\"STRING\":\"". $status ."\",\"NAME\":\"". $HIF[0][$c][0] ."\",\"CUSTOM_VAR\":\"". uc($HIF[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($HIF[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"ADDRESS\":\"". $HIF[0][$c][2] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($HIF[0][$c][3],"host") ."\",\"STATUS\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][4]) ."\",\"SRV_OK\":\"". $HIF[0][$c][5] ."\",\"SRV_WA\":\"". $HIF[0][$c][6] ."\",\"SRV_CR\":\"". $HIF[0][$c][7] ."\",\"SRV_UN\":\"". $HIF[0][$c][8] ."\",\"SRV_PE\":\"". $HIF[0][$c][9] ."\",\"ACK\":\"". $HIF[0][$c][10] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][11]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][12]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$HIF[0][$c][13]}) {
	    $out.= $cmt .",";
	}
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		foreach my $cmt (@{$SFL[0][$k][8]}) {
		    $out.= $cmt .",";
		}
		$out = substr($out, 0, -1);
		$out.="\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseFullInfo {
    my $uid = shift;
    my @AD = kSClive::DatabaseFullInfo($uid);
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="DB";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /_DBST_/i) {
            $dbname = uc(substr($AD[0][$c][4], 10));
            $dbtype = substr($AD[0][$c][4], 0, index($AD[0][$c][4], "_"));
        } elsif ($AD[0][$c][4] =~ /_DBSTATUS/i) {
            $AD[0][$c][4] =~ s/_DBSTATUS//g;
            $dbname = uc(substr($AD[0][$c][4],7));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"DB_NAME\":\"". $dbname ."\",\"DB_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub DatabaseFullInfoSearchDatabase {
    my $uid = shift;
    my $searchstring = shift;
    my @AD = kSClive::DatabaseSearchList($uid,$searchstring);
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="DB";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /_DBST_/i) {
            $dbname = uc(substr($AD[0][$c][4], 10));
            $dbtype = substr($AD[0][$c][4], 0, index($AD[0][$c][4], "_"));
        } elsif ($AD[0][$c][4] =~ /_DBSTATUS/i) {
            $AD[0][$c][4] =~ s/_DBSTATUS//g;
            $dbname = uc(substr($AD[0][$c][4],7));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"DB_NAME\":\"". $dbname ."\",\"DB_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub DatabaseFullInfoStatusDatabase {
    my $uid = shift;
    my $status = shift;
    my @AD;
    # PreCheck
    if ($status eq "ao") {
	@AD = kSClive::DatabaseOK($uid);
    } elsif ($status eq "aw") {
	@AD = kSClive::DatabaseWA($uid);
    } elsif ($status eq "ac") {
	@AD = kSClive::DatabaseCR($uid);
    } elsif ($status eq "au") {
	@AD = kSClive::DatabaseUN($uid);
    } elsif ($status eq "ap") {
	@AD = kSClive::DatabaseNOK($uid);
    } elsif ($status eq "apnaoh") {
	@AD = kSClive::DatabaseNOKNOACKOH($uid);
    } elsif ($status eq "apaoh") {
	@AD = kSClive::DatabaseNOKACKOH($uid);
    } elsif ($status eq "apoh") {
	@AD = kSClive::DatabaseNOKOHND($uid);
    } elsif ($status eq "woh") {
	@AD = kSClive::DatabaseWAOHND($uid);
    } elsif ($status eq "coh") {
	@AD = kSClive::DatabaseCROHND($uid);
    } elsif ($status eq "uoh") {
	@AD = kSClive::DatabaseUNOHND($uid);
    } elsif ($status eq "apdh") {
	@AD = kSClive::DatabaseNOKOFFHND($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::DatabaseWAOFFHND($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::DatabaseCROFFHND($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::DatabaseUNOFFHND($uid);
    } elsif ($status eq "wnaoh") {
	@AD = kSClive::DatabaseWAOHNOACK($uid);
    } elsif ($status eq "waoh") {
	@AD = kSClive::DatabaseWAOHACK($uid);
    } elsif ($status eq "cnaoh") {
	@AD = kSClive::DatabaseCROHNOACK($uid);
    } elsif ($status eq "caoh") {
	@AD = kSClive::DatabaseCROHACK($uid);
    } elsif ($status eq "unaoh") {
	@AD = kSClive::DatabaseUNOHNOACK($uid);
    } elsif ($status eq "uaoh") {
	@AD = kSClive::DatabaseUNOHACK($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::DatabaseWAOFFHNOACK($uid);
    } elsif ($status eq "wafh") {
	@AD = kSClive::DatabaseWAOFFHACK($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::DatabaseCROFFHNOACK($uid);
    } elsif ($status eq "cafh") {
	@AD = kSClive::DatabaseCROFFHACK($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::DatabaseUNOFFHNOACK($uid);
    } elsif ($status eq "uafh") {
	@AD = kSClive::DatabaseUNOFFHACK($uid);
    } else {
	@AD = kSClive::DatabaseFullInfo($uid);
    }
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="DB";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /_DBST_/i) {
            $dbname = uc(substr($AD[0][$c][4], 10));
            $dbtype = substr($AD[0][$c][4], 0, index($AD[0][$c][4], "_"));
        } elsif ($AD[0][$c][4] =~ /_DBSTATUS/i) {
            $AD[0][$c][4] =~ s/_DBSTATUS//g;
            $dbname = uc(substr($AD[0][$c][4],7));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"DB_NAME\":\"". $dbname ."\",\"DB_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub MiddlewareFullInfo {
    my $uid = shift;
    my @AD = kSClive::MiddlewareFullInfo($uid);
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="fr";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /WLS_SRV_/i) {
    	    my $t = uc(substr($AD[0][$c][4], 8));
            $dbname = substr($t, index($t ,":")+1);
            $dbtype = substr($t, 0, index($t ,":"));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"WLS_NAME\":\"". $dbname ."\",\"WLS_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon(lc($dbtype)) ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub MiddlewareFullInfoSearchMiddleware {
    my $uid = shift;
    my $searchstring = shift;
    my @AD = kSClive::MiddlewareSearchList($uid,$searchstring);
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="fr";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /WLS_SRV_/i) {
    	    my $t = uc(substr($AD[0][$c][4], 8));
            $dbname = substr($t, index($t ,":")+1);
            $dbtype = substr($t, 0, index($t ,":"));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"WLS_NAME\":\"". $dbname ."\",\"WLS_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon(lc($dbtype)) ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub MiddlewareFullInfoStatusMiddleware {
    my $uid = shift;
    my $status = shift;
    my @AD;
    # PreCheck
    if ($status eq "ao") {
	@AD = kSClive::MiddlewareOK($uid);
    } elsif ($status eq "aw") {
	@AD = kSClive::MiddlewareWA($uid);
    } elsif ($status eq "ac") {
	@AD = kSClive::MiddlewareCR($uid);
    } elsif ($status eq "au") {
	@AD = kSClive::MiddlewareUN($uid);
    } elsif ($status eq "ap") {
	@AD = kSClive::MiddlewareNOK($uid);
    } elsif ($status eq "apnaoh") {
	@AD = kSClive::MiddlewareNOKNOACKOH($uid);
    } elsif ($status eq "apaoh") {
	@AD = kSClive::MiddlewareNOKACKOH($uid);
    } elsif ($status eq "apoh") {
	@AD = kSClive::MiddlewareNOKOHND($uid);
    } elsif ($status eq "woh") {
	@AD = kSClive::MiddlewareWAOHND($uid);
    } elsif ($status eq "coh") {
	@AD = kSClive::MiddlewareCROHND($uid);
    } elsif ($status eq "uoh") {
	@AD = kSClive::MiddlewareUNOHND($uid);
    } elsif ($status eq "apdh") {
	@AD = kSClive::MiddlewareNOKOFFHND($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::MiddlewareWAOFFHND($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::MiddlewareCROFFHND($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::MiddlewareUNOFFHND($uid);
    } elsif ($status eq "wnaoh") {
	@AD = kSClive::MiddlewareWAOHNOACK($uid);
    } elsif ($status eq "waoh") {
	@AD = kSClive::MiddlewareWAOHACK($uid);
    } elsif ($status eq "cnaoh") {
	@AD = kSClive::MiddlewareCROHNOACK($uid);
    } elsif ($status eq "caoh") {
	@AD = kSClive::MiddlewareCROHACK($uid);
    } elsif ($status eq "unaoh") {
	@AD = kSClive::MiddlewareUNOHNOACK($uid);
    } elsif ($status eq "uaoh") {
	@AD = kSClive::MiddlewareUNOHACK($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::MiddlewareWAOFFHNOACK($uid);
    } elsif ($status eq "wafh") {
	@AD = kSClive::MiddlewareWAOFFHACK($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::MiddlewareCROFFHNOACK($uid);
    } elsif ($status eq "cafh") {
	@AD = kSClive::MiddlewareCROFFHACK($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::MiddlewareUNOFFHNOACK($uid);
    } elsif ($status eq "uafh") {
	@AD = kSClive::MiddlewareUNOFFHACK($uid);
    } else {
	@AD = kSClive::MiddlewareFullInfo($uid);
    }
    my @SFL = kSClive::ServiceFullList($uid);
    my $out;
    #
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	my $m=0; my $dbname; my $srv_ok=0; my $srv_wa=0; my $srv_cr=0; my $srv_un=0; my $srv_pe=0; my $dbtype="fr";
	$out.="{\"HOST_NAME\":\"". $AD[0][$c][0] ."\",\"HOST_CUSTOM_VAR\":\"". uc($AD[0][$c][2]{'TAGS'}) ."\",\"HOST_ADDRESS\":\"". $AD[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][1],"host") ."\",\"HOST_STATUS\":\"". $AD[0][$c][1] ."\",";
        if ($AD[0][$c][4] =~ /WLS_SRV_/i) {
    	    my $t = uc(substr($AD[0][$c][4], 8));
            $dbname = substr($t, index($t ,":")+1);
            $dbtype = substr($t, 0, index($t ,":"));
        } else {
            $dbname = $AD[0][$c][4];
        }
        $out.="\"WLS_NAME\":\"". $dbname ."\",\"WLS_TYPE\":\"". $dbtype ."\",\"ICON\":\"". kSCbasic::GetHostIcon(lc($dbtype)) ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"SERVICE_STATE\":\"". $AD[0][$c][5] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][5],"service") ."\",\"ACK\":\"". $AD[0][$c][8] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][6] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][6]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][9] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][9]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AD[0][$c][10]}) { $out.= $cmt .","; }
	$out = substr($out, 0, -1);
	$out.="\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $AD[0][$c][0]) {
		if ($SFL[0][$k][1] =~ /$dbname/) {
		    $out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"SCMT\":\"";
		    foreach my $cmt (@{$SFL[0][$k][8]}) {
		    	$out.= $cmt .",";
		    }
		    $out = substr($out, 0, -1);
		    $out.="\"},";
		    $m++;
		    if ($SFL[0][$k][2] eq "1") { $srv_wa++; } elsif ($SFL[0][$k][2] eq "2") { $srv_cr++; } elsif ($SFL[0][$k][2] eq "3") { $srv_un++; } else { $srv_ok++; }
		}
	    }
	}
	$out = substr($out, 0, -1);
	$out.="],\"SRV_OK\":\"". $srv_ok ."\",\"SRV_WA\":\"". $srv_wa ."\",\"SRV_CR\":\"". $srv_cr ."\",\"SRV_UN\":\"". $srv_un ."\",\"SRV_PE\":\"". $srv_pe ."\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\",/\"CMT\":\"\",/g;
    $out =~ s/\"SCMT\":\"}/\"SCMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]\n";
}
#
sub AllHosts {
    my $uid = shift;
    my @AH = kSClive::HostFullInfo($uid);
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AH[0][$c][3],"host") ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AH[0][$c][11]) ."\",";
        my @tmp = split(" ", uc($AH[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"LAST_CHECK_UTIME\":\"". $AH[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][4]) ."\",\"SRV_OK\":\"". $AH[0][$c][5] ."\",\"SRV_WA\":\"". $AH[0][$c][6] ."\",\"SRV_CR\":\"". $AH[0][$c][7] ."\",\"SRV_UN\":\"". $AH[0][$c][8] ."\",\"SRV_PE\":\"". $AH[0][$c][9] ."\",\"ACK\":\"". $AH[0][$c][10] ."\",\"NEXT_CHECK_UTIME\":\"". $AH[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][12]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$AH[0][$c][13]}) {
	    $out.= $cmt .",";
	}
	$out = substr($out, 0, -1);
	$out.="\"},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\"}/\"CMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AllDatabases {
    my $uid = shift;
    my @AD = kSClive::AllDatabases($uid);
    my $out;
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	$out.="{";
        if ($AD[0][$c][2] =~ /_DBST_/i) {
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2], 10)) ."\"";
        } elsif ($AD[0][$c][2] =~ /_DBSTATUS/i) {
            $AD[0][$c][2] =~ s/_DBSTATUS//g;
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2],7))  ."\"";
        } else {
            $out.="\"NAME\":\"". $AD[0][$c][2] ."\"";
        }
        $out.=",\"HOST\":\"". $AD[0][$c][0] ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"HOST_STATE\":\"". $AD[0][$c][1] ."\",\"SERVICE_STATE\":\"". $AD[0][$c][3] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][3],"service") ."\",\"ACK\":\"". $AD[0][$c][7] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][4]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][8] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][8]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][5]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][6]) ."\"},";
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
    my @DBOV = kSClive::TaovDatabases($uid);
    my @MWOV = kSClive::TaovMiddleware($uid);
    my $c=0;
    # Hosts
    my $hstok = $HTOV[0][$c][0];
    my $hstcr = $HTOV[0][$c][1];
    my $hstnacr = $HTOV[0][$c][2];
    my $hstacr = $HTOV[0][$c][3];
    my $hstun = $HTOV[0][$c][4];
    my $hstnaun = $HTOV[0][$c][5];
    my $hstaun = $HTOV[0][$c][6];
    # Services
    #
    # Ok
    my $srvoka = $TAOV[0][$c][0];
    my $srvok = $TAOV[0][$c][1];
    # Warning
    my $srvwaa = $TAOV[0][$c][2];
    my $srvwa = $TAOV[0][$c][3];
    my $srvnawa = $TAOV[0][$c][4];
    my $srvawa = $TAOV[0][$c][5];
    my $srvnawaoff = $TAOV[0][$c][6];
    # Critical
    my $srvcra = $TAOV[0][$c][7];
    my $srvcr = $TAOV[0][$c][8];
    my $srvnacr = $TAOV[0][$c][9];
    my $srvacr = $TAOV[0][$c][10];
    my $srvnacroff = $TAOV[0][$c][11];
    # Unknown
    my $srvuna = $TAOV[0][$c][12];
    my $srvun = $TAOV[0][$c][13];
    my $srvnaun = $TAOV[0][$c][14];
    my $srvaun = $TAOV[0][$c][15];
    my $srvnaunoff = $TAOV[0][$c][16];
    # Pending
    my $pending = $TAOV[0][$c][17];
    #
    # Datenbanken
    #
    # Online
    my $dboka = $DBOV[0][$c][0];
    my $dbok = $DBOV[0][$c][1];
    # Offline
    my $dbcra = $DBOV[0][$c][2];
    my $dbcr = $DBOV[0][$c][3];
    my $dbnacr = $DBOV[0][$c][4];
    my $dbacr = $DBOV[0][$c][5];
    my $dbnacroff = $DBOV[0][$c][6];
    #
    # Middleware
    #
    # Online
    my $mwoka = $MWOV[0][$c][0];
    my $mwok = $MWOV[0][$c][1];
    # Offline
    my $mwcra = $MWOV[0][$c][2];
    my $mwcr = $MWOV[0][$c][3];
    my $mwnacr = $MWOV[0][$c][4];
    my $mwacr = $MWOV[0][$c][5];
    my $mwnacroff = $MWOV[0][$c][6];
    # Output
    print kSChtml::ContentType("json");
    print "\"HOST\":{\"OK\":{\"COUNT\":\"". $hstok ."\"},\"CRITICAL\":{\"COUNT\":\"". $hstcr ."\",\"NACK\":\"". $hstnacr ."\",\"ACK\":\"". $hstacr ."\"},\"UNREACHABLE\":{\"COUNT\":\"". $hstun ."\",\"NACK\":\"". $hstnaun ."\",\"ACK\":\"". $hstaun ."\"}},\"SERVICE\":{\"OK\":{\"COUNT_ALL\":\"". $srvoka ."\",\"COUNT_ON\":\"". $srvok ."\"},\"WARNING\":{\"COUNT_ALL\":\"". $srvwaa ."\",\"COUNT_ON\":\"". $srvwa ."\",\"NACK_ON\":\"". $srvnawa ."\",\"ACK_ON\":\"". $srvawa ."\",\"NACK_OFF\":\"". $srvnawaoff ."\"},\"CRITICAL\":{\"COUNT_ALL\":\"". $srvcra ."\",\"COUNT_ON\":\"". $srvcr ."\",\"NACK_ON\":\"". $srvnacr ."\",\"ACK_ON\":\"". $srvacr ."\",\"NACK_OFF\":\"". $srvnacroff ."\"},\"UNKNOWN\":{\"COUNT_ALL\":\"". $srvuna ."\",\"COUNT_ON\":\"". $srvun ."\",\"NACK_ON\":\"". $srvnaun ."\",\"ACK_ON\":\"". $srvaun ."\",\"NACK_OFF\":\"". $srvnaunoff ."\"},\"PENDING\":{\"COUNT_ON\":\"". $pending ."\"}},\"DATABASE\":{\"ONLINE\":{\"COUNT_ALL\":\"". $dboka ."\",\"COUNT_ON\":\"". $dbok ."\"},\"OFFLINE\":{\"COUNT_ALL\":\"". $dbcra ."\",\"COUNT_ON\":\"". $dbcr ."\",\"NACK_ON\":\"". $dbnacr ."\",\"ACK_ON\":\"". $dbacr ."\",\"NACK_OFF\":\"". $dbnacroff ."\"}},\"MIDDLEWARE\":{\"ONLINE\":{\"COUNT_ALL\":\"". $mwoka ."\",\"COUNT_ON\":\"". $mwok ."\"},\"OFFLINE\":{\"COUNT_ALL\":\"". $mwcra ."\",\"COUNT_ON\":\"". $mwcr ."\",\"NACK_ON\":\"". $mwnacr ."\",\"ACK_ON\":\"". $mwacr ."\",\"NACK_OFF\":\"". $mwnacroff ."\"}}";
}
#
sub ShowCritical {
    my $uid = shift;
    my $out;
    #####
    #
    # Get Data and fill central array
    #
    #####
    my @SCS = kSClive::ShowCriticalServices($uid);
    my @SCH = kSClive::ShowCriticalHosts($uid);
    my @temp;
    for (my $c=0;$c<scalar(@{$SCS[0]});$c++) {
        push @temp, [$SCS[0][$c][0],$SCS[0][$c][1],$SCS[0][$c][2],$SCS[0][$c][3],$SCS[0][$c][4],$SCS[0][$c][5],$SCS[0][$c][6],$SCS[0][$c][7]];
    }
    for (my $c=0;$c<scalar(@{$SCH[0]});$c++) {
        push @temp, [$SCH[0][$c][0],$SCH[0][$c][1],$SCH[0][$c][2],$SCH[0][$c][3],$SCH[0][$c][4],$SCH[0][$c][5],$SCH[0][$c][6],$SCH[0][$c][7]];
    }
    my @tmp = reverse sort {$a->[0] cmp $b->[0]} @temp;
    #####
    #
    # Get lines
    #
    #####
    for (my $c=0;$c<scalar(@tmp);$c++) {
	if ($tmp[$c][1] eq $tmp[$c][2]) {
    	    $out.="{\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($tmp[$c][3],"host") ."\",\"SERVICE_STATUS\":\"". $tmp[$c][3] ."\",\"SERVICE_NAME\":\"\",\"HOST_NAME\":\"". $tmp[$c][2] ."\",\"TIMESTAMP\":\"". $tmp[$c][0] ."\",";
        } else {
    	    $out.="{\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($tmp[$c][3],"service") ."\",\"SERVICE_STATUS\":\"". $tmp[$c][3] ."\",\"SERVICE_NAME\":\"". $tmp[$c][1] ."\",\"HOST_NAME\":\"". $tmp[$c][2] ."\",\"TIMESTAMP\":\"". $tmp[$c][0] ."\",";
        }
        if ($tmp[$c][4] eq "0") {
    	    $out.="\"HOST_STATUS\":\"<font class='fok FontBigShowCritical'>Host ist Online.</font>\",";
    	} else {
    	    $out.="\"HOST_STATUS\":\"<font class='fcr FontBigShowCritical'>Host ist Offline.</font>\",";
    	}
        $out.="\"OUTPUT\":\"". kSCbasic::EncodeHTML($tmp[$c][5]) ."\",\"ACK\":\"". $tmp[$c][6] ."\",\"CMT\":\"";
        foreach my $cmt (@{$tmp[$c][7]}) {
	    $out.= $cmt .",";
	}
	$out = substr($out, 0, -1);
	$out.="\"},";

    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\"}/\"CMT\":\"\"}/g;
    #####
    #
    # Output
    #
    #####
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub SelectLiveticker {
    my $uid = shift;
    my $cut = time;
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    my $sth = kSCpostgre::SelectLiveticker($uid);
    while ( (my $hn,my $cv, my $hs,my $sn,my $st,my $ot,my $ts) = $sth->fetchrow_array()) {
	$out.="{\"TIMESTAMP\":\"". $ts ."\",";
        if ( $cut-300 < $ts ) { $out.="\"INCIDENT\":\"NEW\","; } else { $out.="\"INCIDENT\":\"". substr(kSCbasic::ConvertUt2Ts($ts), 11) ."\","; }
        $out.="\"DISPLAY_NAME\":\"". $sn ."\",\"HOST_NAME\":\"". $hn ."\",";
        if ($sn eq $hn) {
    	    $out.="\"SERVICE_STATE\":\"". kSCbasic::GetStatusIcon($st,"host") ."\",";
        } else {
    	    $out.="\"SERVICE_STATE\":\"". kSCbasic::GetStatusIcon($st,"service") ."\",";
	}
        if ($hs eq "0") { $out.="\"HOST_STATE\":\"HOST ONLINE\","; } else { $out.="\"HOST_STATE\":\"HOST OFFLINE\","; }
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
        $out.="\"OUTPUT\":\"". kSCbasic::EncodeHTML($ot) ."\"";
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
        kSCpostgre::FillLiveticker($uid,$SCS[0][$c][2],$SCS[0][$c][5][0],$SCS[0][$c][4],$SCS[0][$c][1],$SCS[0][$c][3],kSCbasic::EncodeHTML($SCS[0][$c][6]));
    }
    # Host
    my @SCH = kSClive::ShowNewCriticalHosts($uid);
    for (my $c=0;$c<scalar(@{$SCH[0]});$c++) {
        kSCpostgre::FillLiveticker($uid,$SCH[0][$c][2],$SCH[0][$c][5][0],$SCH[0][$c][4],$SCH[0][$c][1],$SCH[0][$c][3],kSCbasic::EncodeHTML($SCH[0][$c][6]));
    }
    print kSChtml::ContentType("json");
    print "\"EXEC\":\"UPDATED\"";
}
#
sub ServiceStatusSelect {
    my $uid = shift;
    my $status = shift;
    my @HIF;
    my @SFL;
    # PreCheck
    if ($status eq "ao") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceOK($uid);
    } elsif ($status eq "aw") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWA($uid);
    } elsif ($status eq "ac") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCR($uid);
    } elsif ($status eq "au") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUN($uid);
    } elsif ($status eq "ap") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceNOK($uid);
    } elsif ($status eq "apnaoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceNOKNOACKOH($uid);
    } elsif ($status eq "apoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceNOKOHND($uid);
    } elsif ($status eq "woh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOHND($uid);
    } elsif ($status eq "coh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROHND($uid);
    } elsif ($status eq "uoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOHND($uid);
    } elsif ($status eq "apdh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceNOKOFFHND($uid);
    } elsif ($status eq "wnafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOFFHND($uid);
    } elsif ($status eq "cnafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROFFHND($uid);
    } elsif ($status eq "unafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOFFHND($uid);
    } elsif ($status eq "wnaoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOHNOACK($uid);
    } elsif ($status eq "waoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOHACK($uid);
    } elsif ($status eq "cnaoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROHNOACK($uid);
    } elsif ($status eq "caoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROHACK($uid);
    } elsif ($status eq "unaoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOHNOACK($uid);
    } elsif ($status eq "uaoh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOHACK($uid);
    } elsif ($status eq "wnafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOFFHNOACK($uid);
    } elsif ($status eq "wafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceWAOFFHACK($uid);
    } elsif ($status eq "cnafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROFFHNOACK($uid);
    } elsif ($status eq "cafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceCROFFHACK($uid);
    } elsif ($status eq "unafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOFFHNOACK($uid);
    } elsif ($status eq "uafh") {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceUNOFFHostsACK($uid);
    } else {
	@HIF = kSClive::HostFullInfo($uid);
	@SFL = kSClive::ServiceFullList($uid);
    }
    # Execution
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $HIF[0][$c][0] ."\",\"ADDRESS\":\"". $HIF[0][$c][1] ."\",\"STATE\":\"". $HIF[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."\",\"SRV_OK\":\"". $HIF[0][$c][4] ."\",\"SRV_WA\":\"". $HIF[0][$c][5] ."\",\"SRV_CR\":\"". $HIF[0][$c][6] ."\",\"SRV_UN\":\"". $HIF[0][$c][7] ."\",\"SRV_PE\":\"". $HIF[0][$c][8] ."\",\"ACK\":\"". $HIF[0][$c][9] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][10]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][11] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."\",\"SERVICELIST\":{";
	$out.="{\"NAME\":\"". $HIF[0][$c][0] ."\",\"CUSTOM_VAR\":\"". uc($HIF[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($HIF[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"ADDRESS\":\"". $HIF[0][$c][2] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($HIF[0][$c][3],"host") ."\",\"STATUS\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][4]) ."\",\"SRV_OK\":\"". $HIF[0][$c][5] ."\",\"SRV_WA\":\"". $HIF[0][$c][6] ."\",\"SRV_CR\":\"". $HIF[0][$c][7] ."\",\"SRV_UN\":\"". $HIF[0][$c][8] ."\",\"SRV_PE\":\"". $HIF[0][$c][9] ."\",\"ACK\":\"". $HIF[0][$c][10] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][11]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][12]) ."\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		#$out.="\"SERVICE_". $m ."\":{\"NAME\":\"". $SFL[0][$k][1] ."\",\"STATE\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". $SFL[0][$k][4] ."\",\"LONG_OUTPUT\":\"". $SFL[0][$k][5] ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\"},";
		$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"CMT\":\"";
		foreach my $cmt (@{$SFL[0][$k][8]}) {
		    $out.= $cmt .",";
		}
		$out = substr($out, 0, -1);
		$out.="\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\"}/\"CMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ServiceSearchList {
    my $uid = shift;
    my $searchstring = shift;
    my @HIF = kSClive::HostFullInfo($uid);
    my @SFL = kSClive::ServiceSearchList($uid,$searchstring);
    # Execution
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$HIF[0]});$c++) {
	my $m=0;
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $HIF[0][$c][0] ."\",\"ADDRESS\":\"". $HIF[0][$c][1] ."\",\"STATE\":\"". $HIF[0][$c][2] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][3]) ."\",\"SRV_OK\":\"". $HIF[0][$c][4] ."\",\"SRV_WA\":\"". $HIF[0][$c][5] ."\",\"SRV_CR\":\"". $HIF[0][$c][6] ."\",\"SRV_UN\":\"". $HIF[0][$c][7] ."\",\"SRV_PE\":\"". $HIF[0][$c][8] ."\",\"ACK\":\"". $HIF[0][$c][9] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][10]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][11] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][11]) ."\",\"SERVICELIST\":{";
	$out.="{\"NAME\":\"". $HIF[0][$c][0] ."\",\"CUSTOM_VAR\":\"". uc($HIF[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($HIF[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"ADDRESS\":\"". $HIF[0][$c][2] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($HIF[0][$c][3],"host") ."\",\"STATUS\":\"". $HIF[0][$c][3] ."\",\"LAST_CHECK_UTIME\":\"". $HIF[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][4]) ."\",\"SRV_OK\":\"". $HIF[0][$c][5] ."\",\"SRV_WA\":\"". $HIF[0][$c][6] ."\",\"SRV_CR\":\"". $HIF[0][$c][7] ."\",\"SRV_UN\":\"". $HIF[0][$c][8] ."\",\"SRV_PE\":\"". $HIF[0][$c][9] ."\",\"ACK\":\"". $HIF[0][$c][10] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($HIF[0][$c][11]) ."\",\"NEXT_CHECK_UTIME\":\"". $HIF[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($HIF[0][$c][12]) ."\",\"SERVICELIST\":[";
	for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	    if ($SFL[0][$k][0] eq $HIF[0][$c][0]) {
		#$out.="\"SERVICE_". $m ."\":{\"NAME\":\"". $SFL[0][$k][1] ."\",\"STATE\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". $SFL[0][$k][4] ."\",\"LONG_OUTPUT\":\"". $SFL[0][$k][5] ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\"},";
		$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"CMT\":\"";
		foreach my $cmt (@{$SFL[0][$k][8]}) {
		    $out.= $cmt .",";
		}
		$out = substr($out, 0, -1);
		$out.="\"},";
		$m++;
	    }
	}
	$out = substr($out, 0, -1);
	$out.="]},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"CMT\":\"}/\"CMT\":\"\"}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostStatusSelect {
    my $uid = shift;
    my $status = shift;
    my @AH;
    # PreCheck
    if ($status eq "up") {
	@AH = kSClive::HostUp($uid);
    } elsif ($status eq "do") {
	@AH = kSClive::HostDo($uid);
    } elsif ($status eq "un") {
	@AH = kSClive::HostUn($uid);
    } elsif ($status eq "nok") {
	@AH = kSClive::HostNok($uid);
    } elsif ($status eq "noknodt") {
	@AH = kSClive::HostNokNodt($uid);
    } elsif ($status eq "nokdt") {
	@AH = kSClive::HostNokDt($uid);
    } elsif ($status eq "donoack") {
	@AH = kSClive::HostDoNoack($uid);
    } elsif ($status eq "doack") {
	@AH = kSClive::HostDoAck($uid);
    } elsif ($status eq "unnoack") {
	@AH = kSClive::HostUnNoack($uid);
    } elsif ($status eq "unack") {
	@AH = kSClive::HostUnAck($uid);
    } elsif ($status eq "donacknodt") {
	@AH = kSClive::HostDoNoackNodt($uid);
    } elsif ($status eq "doacknodt") {
	@AH = kSClive::HostDoAckNodt($uid);
    } elsif ($status eq "donackdt") {
	@AH = kSClive::HostDoNoackDt($uid);
    } elsif ($status eq "doackdt") {
	@AH = kSClive::HostDoAckDt($uid);
    } elsif ($status eq "unnoacknodt") {
	@AH = kSClive::HostUnNoackNodt($uid);
    } elsif ($status eq "unacknodt") {
	@AH = kSClive::HostUnAckNodt($uid);
    } elsif ($status eq "unnoackdt") {
	@AH = kSClive::HostUnNoackDt($uid);
    } elsif ($status eq "unackdt") {
	@AH = kSClive::HostUnAckDt($uid);
    } else {
	@AH = kSClive::HostFullInfo($uid);
    }
    # Execution
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][2] ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AH[0][$c][3],"host") ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AH[0][$c][11]) ."\",";
        my @tmp = split(" ", uc($AH[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"LAST_CHECK_UTIME\":\"". $AH[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][4]) ."\",\"SRV_OK\":\"". $AH[0][$c][5] ."\",\"SRV_WA\":\"". $AH[0][$c][6] ."\",\"SRV_CR\":\"". $AH[0][$c][7] ."\",\"SRV_UN\":\"". $AH[0][$c][8] ."\",\"SRV_PE\":\"". $AH[0][$c][9] ."\",\"ACK\":\"". $AH[0][$c][10] ."\",\"NEXT_CHECK_UTIME\":\"". $AH[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][12]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostSearchList {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::HostSearchList($uid,$searchstring);
    # Execution
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	#$out.="\"HOST_". $c ."\":{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][2] ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"STATE\":\"". $AH[0][$c][3] ."\",\"HOST_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($AH[0][$c][3],"host") ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AH[0][$c][11]) ."\",";
        my @tmp = split(" ", uc($AH[0][$c][1][0]));
        if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\"";
        } elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\"";
        } else {
            $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
            $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\"";
        }
	$out.=",\"LAST_CHECK_UTIME\":\"". $AH[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][4]) ."\",\"SRV_OK\":\"". $AH[0][$c][5] ."\",\"SRV_WA\":\"". $AH[0][$c][6] ."\",\"SRV_CR\":\"". $AH[0][$c][7] ."\",\"SRV_UN\":\"". $AH[0][$c][8] ."\",\"SRV_PE\":\"". $AH[0][$c][9] ."\",\"ACK\":\"". $AH[0][$c][10] ."\",\"NEXT_CHECK_UTIME\":\"". $AH[0][$c][12] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][12]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseStatusSelect {
    my $uid = shift;
    my $status = shift;
    my @AD;
    # PreCheck
    if ($status eq "ao") {
	@AD = kSClive::DatabaseOK($uid);
    } elsif ($status eq "aw") {
	@AD = kSClive::DatabaseWA($uid);
    } elsif ($status eq "ac") {
	@AD = kSClive::DatabaseCR($uid);
    } elsif ($status eq "au") {
	@AD = kSClive::DatabaseUN($uid);
    } elsif ($status eq "ap") {
	@AD = kSClive::DatabaseNOK($uid);
    } elsif ($status eq "apnaoh") {
	@AD = kSClive::DatabaseNOKNOACKOH($uid);
    } elsif ($status eq "apaoh") {
	@AD = kSClive::DatabaseNOKACKOH($uid);
    } elsif ($status eq "apoh") {
	@AD = kSClive::DatabaseNOKOHND($uid);
    } elsif ($status eq "woh") {
	@AD = kSClive::DatabaseWAOHND($uid);
    } elsif ($status eq "coh") {
	@AD = kSClive::DatabaseCROHND($uid);
    } elsif ($status eq "uoh") {
	@AD = kSClive::DatabaseUNOHND($uid);
    } elsif ($status eq "apdh") {
	@AD = kSClive::DatabaseNOKOFFHND($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::DatabaseWAOFFHND($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::DatabaseCROFFHND($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::DatabaseUNOFFHND($uid);
    } elsif ($status eq "wnaoh") {
	@AD = kSClive::DatabaseWAOHNOACK($uid);
    } elsif ($status eq "waoh") {
	@AD = kSClive::DatabaseWAOHACK($uid);
    } elsif ($status eq "cnaoh") {
	@AD = kSClive::DatabaseCROHNOACK($uid);
    } elsif ($status eq "caoh") {
	@AD = kSClive::DatabaseCROHACK($uid);
    } elsif ($status eq "unaoh") {
	@AD = kSClive::DatabaseUNOHNOACK($uid);
    } elsif ($status eq "uaoh") {
	@AD = kSClive::DatabaseUNOHACK($uid);
    } elsif ($status eq "wnafh") {
	@AD = kSClive::DatabaseWAOFFHNOACK($uid);
    } elsif ($status eq "wafh") {
	@AD = kSClive::DatabaseWAOFFHACK($uid);
    } elsif ($status eq "cnafh") {
	@AD = kSClive::DatabaseCROFFHNOACK($uid);
    } elsif ($status eq "cafh") {
	@AD = kSClive::DatabaseCROFFHACK($uid);
    } elsif ($status eq "unafh") {
	@AD = kSClive::DatabaseUNOFFHNOACK($uid);
    } elsif ($status eq "uafh") {
	@AD = kSClive::DatabaseUNOFFHACK($uid);
    } else {
	@AD = kSClive::AllDatabases($uid);
    }
    # Execution
    my $out;
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	$out.="{";
        if ($AD[0][$c][2] =~ /_DBST_/i) {
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2], 10)) ."\"";
        } elsif ($AD[0][$c][2] =~ /_DBSTATUS/i) {
            $AD[0][$c][2] =~ s/_DBSTATUS//g;
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2],7))  ."\"";
        } else {
            $out.="\"NAME\":\"". $AD[0][$c][2] ."\"";
        }
        $out.=",\"HOST\":\"". $AD[0][$c][0] ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"HOST_STATE\":\"". $AD[0][$c][1] ."\",\"SERVICE_STATE\":\"". $AD[0][$c][3] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][3],"service") ."\",\"ACK\":\"". $AD[0][$c][7] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][4]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][8] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][8]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][5]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][6]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseSearchList {
    my $uid = shift;
    my $searchstring = shift;
    my @AD = kSClive::DatabaseSearchList($uid,$searchstring);
    my $out;
    for (my $c=0;$c<scalar(@{$AD[0]});$c++) {
	$out.="{";
        if ($AD[0][$c][2] =~ /_DBST_/i) {
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2], 10)) ."\"";
        } elsif ($AD[0][$c][2] =~ /_DBSTATUS/i) {
            $AD[0][$c][2] =~ s/_DBSTATUS//g;
            $out.="\"NAME\":\"". uc(substr($AD[0][$c][2],7))  ."\"";
        } else {
            $out.="\"NAME\":\"". $AD[0][$c][2] ."\"";
        }
        $out.=",\"HOST\":\"". $AD[0][$c][0] ."\",\"ICON\":\"". kSCbasic::GetHostIcon("db") ."\",\"URL\":\"". kSCbasic::GetHostUrl("db") ."\",\"HOST_STATE\":\"". $AD[0][$c][1] ."\",\"SERVICE_STATE\":\"". $AD[0][$c][3] ."\",\"SERVICE_STATE_ICON\":\"". kSCbasic::GetStatusIcon($AD[0][$c][3],"service") ."\",\"ACK\":\"". $AD[0][$c][7] ."\",\"LAST_CHECK_UTIME\":\"". $AD[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][4]) ."\",\"NEXT_CHECK_UTIME\":\"". $AD[0][$c][8] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AD[0][$c][8]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][5]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($AD[0][$c][6]) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ShowAllComments {
    my $uid = shift;
    my $out;
    my $cut = time;
    #
    # Get Data and fill central array
    my @CMT = kSClive::GetAllComments($uid);
    my @temp;
    for (my $c=0;$c<scalar(@{$CMT[0]});$c++) {
	if ($cut-2592000 < $CMT[0][$c][2]) {
    	    push @temp, [$CMT[0][$c][0],$CMT[0][$c][1],$CMT[0][$c][2],$CMT[0][$c][3],$CMT[0][$c][4]];
    	}
    }
    my @tmp = reverse sort {$a->[2] cmp $b->[2]} @temp;
    #
    # Get lines
    for (my $c=0;$c<scalar(@tmp);$c++) {
    	$out.="{\"AUTHOR\":\"". $tmp[$c][0] ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($tmp[$c][1]) ."\",\"TIMESTAMP\":\"". $tmp[$c][2] ."\",\"TIMESTAMP_ISO\":\"". kSCbasic::ConvertUt2Ts($tmp[$c][2]) ."\",\"SERVICE_NAME\":\"". $tmp[$c][3] ."\",\"HOST_NAME\":\"". $tmp[$c][4] ."\"},";
    }
    $out = substr($out, 0, -1);
    #
    # Output
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#