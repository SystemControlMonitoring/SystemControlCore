#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/http';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSChttp;
use kSCpostgre;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
#
#
#
#
#
# Functions
#
sub SYSINFO {
    my $client = shift;
    my $uid = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetClientInfo($client,"6555","sysstat","SYSINFO");
	print kSChtml::ContentType("json");
	if ($info =~ /[Ww][Ii][Nn][Dd][Oo][Ww][Ss]/i || $info =~ /[Mm][Ii][Cc][Rr][Oo][Ss][Oo][Ff][Tt]/i) {
	    $info =~ s/{\"HOSTNAME\":/{\"TYPE\":\"WIN\",\"HOSTNAME\":/g;
	} else {
	    $info =~ s/{\"HOSTNAME\":/{\"TYPE\":\"LIN\",\"HOSTNAME\":/g;
	}
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
}
#
sub DBINFO {
    my $client = shift;
    my $uid = shift;
    my @check = kSClive::GetConfiguredDatabases($uid,$client);
    my $info;
    for (my $c=0;$c<scalar(@{$check[0]});$c++) {
	if ( $check[0][$c][0] =~ /_DBSTATUS/i ) {
	    my $dbname = substr($check[0][$c][0], index($check[0][$c][0], "_")+1);
	    $dbname = substr($dbname, 0, index($dbname, "_") );
	    #print $dbname;
	    $info .= kSChttp::GetDBInfo($client,"6555","oracledatabase","DBINFO",$dbname) .",";
	    $info =~ s/{\"/{\"DBNAME\":\"$dbname\",\"/g;
	} elsif ( $check[0][$c][0] =~ /_DBST_/i ) {
	    my $dbname = substr($check[0][$c][0], rindex($check[0][$c][0], "_")+1 );
	    #print $dbname;
	    $info .= kSChttp::GetDBInfo($client,"6555","oracledatabase","DBINFO",$dbname) .",";
	    $info =~ s/{\"/{\"DBNAME\":\"$dbname\",\"/g;
	}
    }
    $info = substr($info, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $info ."]";
}
#
sub GetWls {
    my $module = shift;
    my $client = shift;
    my $uid = shift;
    my $port = shift;
    my $info = kSChttp::GetWlsInfo($client,"6555","weblogic",$module,$port);
    print kSChtml::ContentType("json");
    print $info;
}
#
sub SysJqGrid {
    my $client = shift;
    my $uid = shift;
    my $module = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetJqGridClientInfo($client,"6555","sysstat",$module,$search,$rows,$page,$sidx,$sord);
	print kSChtml::ContentType("json");
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
}
#
sub ServiceHostList {
    my $uid = shift;
    my $client = shift;
    my @SFL = kSClive::ServiceHostList($uid,$client);
    my $out;
    for (my $k=0;$k<scalar(@{$SFL[0]});$k++) {
	$out.="{\"SERVICE_NAME\":\"". $SFL[0][$k][1] ."\",\"SERVICE_STATUS_ICON\":\"". kSCbasic::GetStatusIcon($SFL[0][$k][2],"service") ."\",\"SERVICE_STATUS\":\"". $SFL[0][$k][2] ."\",\"LAST_CHECK_UTIME\":\"". $SFL[0][$k][3] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][3]) ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][4]) ."\",\"LONG_OUTPUT\":\"". kSCbasic::EncodeHTML($SFL[0][$k][5]) ."\",\"ACK\":\"". $SFL[0][$k][6] ."\",\"NEXT_CHECK_UTIME\":\"". $SFL[0][$k][7] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($SFL[0][$k][7]) ."\",\"CMT\":\"";
	foreach my $cmt (@{$SFL[0][$k][8]}) {
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
sub HostSummary {
    my $uid = shift;
    my $hostname = shift;
    my @AH = kSClive::GetHostSummary($uid,$hostname);
    my @SIFO = kSClive::GetHostServiceSummary($uid,$hostname);
    my %AHI = kSCpostgre::AllHostIcons();
    my $out;
    # Exec
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"ADDRESS\":\"". $AH[0][$c][2] ."\",\"STATE\":\"". $AH[0][$c][3] ."\",\"STATE_ICON\":\"". kSCbasic::GetStatusIcon($AH[0][$c][3],"host") ."\",\"CUSTOM_VAR\":\"". uc($AH[0][$c][1][0]) ."\",";
	my @tmp = split(" ", uc($AH[0][$c][1][0]));
	if (kSCbasic::GetHostIcon($AHI{$tmp[0]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[0]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[0]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[0]) ."\"";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[1]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[1]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[1]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[1]) ."\"";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[2]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[2]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[2]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[2]) ."\"";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[3]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[3]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[3]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[3]) ."\"";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[4]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[4]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[4]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[4]) ."\"";
	} elsif (kSCbasic::GetHostIcon($AHI{$tmp[5]}) ne "") {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon($AHI{$tmp[5]}) ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl($AHI{$tmp[5]}) ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName($tmp[5]) ."\"";
	} else {
	    $out.="\"ICON\":\"". kSCbasic::GetHostIcon("ho") ."\",";
	    $out.="\"URL\":\"". kSCbasic::GetHostUrl("ho") ."\",";
	    $out.="\"DESC\":\"". kSCpostgre::WhichHostLongName("HOST") ."\"";
	}
	$out.=",\"LAST_CHECK_UTIME\":\"". $AH[0][$c][4] ."\",\"LAST_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][4]) ."\",\"NEXT_CHECK_UTIME\":\"". $AH[0][$c][5] ."\",\"NEXT_CHECK_ISO\":\"". kSCbasic::ConvertUt2Ts($AH[0][$c][5]) ."\",\"HOSTGROUPS\":\"";
	for (my $k=0;$k<scalar(@{$AH[0][$c][6]});$k++) {
	    if ($AH[0][$c][6][$k] ne "check_mk") {
		my @tmp = kSClive::GetGroupName($AH[0][$c][6][$k]);
		$out.= kSCbasic::EncodeHTML($tmp[0][0][0]) .",";
	    } else {
		$out.= "--";
	    }
	}
	$out = substr($out, 0, -1);
	$out.="\",";
	for (my $j=0;$j<scalar(@{$SIFO[0]});$j++) {
	    $SIFO[0][$j][0] = substr($SIFO[0][$j][0], index($SIFO[0][$j][0], "-")+2 );
	    if ($SIFO[0][$j][0] =~ /[aA][gG][eE][nN][tT]/i) {
		my @tmp = split(",", $SIFO[0][$j][0]);
		$tmp[0] =~ s/Agent version //g;
		$tmp[1] =~ s/ execution time //g;
		$out.="\"AGENT_VERSION\":\"". $tmp[0] ."\",\"EXEC_TIME\":\"". $tmp[1] ."\",";
	    } elsif ($SIFO[0][$j][0] =~ /[uU][pP] [sS][iI][nN][cC][eE]/i) {
		my @tmp = split(" \\(", $SIFO[0][$j][0]);
		$tmp[0] =~ s/up since //g;
		$tmp[0] =~ s/  / /g;
		$tmp[1] =~ s/\)//g;
		$out.="\"STARTUP\":\"". $tmp[0] ."\",\"UPTIME\":\"". $tmp[1] ."\",";
	    } else {
		$out.="\"AGENT_VERSION\":\"-\",\"EXEC_TIME\":\"-\",";
	    }
	}
	$out.="\"SRV_OK\":\"". $AH[0][$c][7] ."\",\"SRV_WA\":\"". $AH[0][$c][8] ."\",\"SRV_CR\":\"". $AH[0][$c][9] ."\",\"SRV_UN\":\"". $AH[0][$c][10] ."\",\"SRV_PE\":\"". $AH[0][$c][11] ."\"}";
    }
    # Output
    print kSChtml::ContentType("json");
    print $out;
}
#
sub OracleDB {
    my $client = shift;
    my $uid = shift;
    my $module = shift;
    my $db = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetJqGridODBInfo($client,"6555","oracledatabase",$module,$db,$search,$rows,$page,$sidx,$sord);
	print kSChtml::ContentType("json");
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
}
#
sub WLS {
    my $client = shift;
    my $uid = shift;
    my $module = shift;
    my $port = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetJqGridWlsInfo($client,"6555","weblogic",$module,$port,$search,$rows,$page,$sidx,$sord);
	print kSChtml::ContentType("json");
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
}
#
sub OracleDBAdmin {
    my $client = shift;
    my $uid = shift;
    my $cm = shift;
    my $db = shift;
    my $datestart = shift;
    my $dateend = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetODBAdmin($client,"6555","oracledatabase",$cm,$db,$datestart,$dateend);
	print kSChtml::ContentType("json");
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub LogAdmin {
    my $client = shift;
    my $uid = shift;
    my $cm = shift;
    my $log = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	if ($cm eq "DELOG") {
	    #
	    # Delete from Icinga Monitoring Logwatch Cache
	    my $file = kSCbasic::GetLogwatchPath() ."/". $client ."/". $log;
	    unlink $file;
	    #
	    # Delete from remote Client
	    my $info = kSChttp::GetLogAdmin($client,"6555","sysstat",$cm,$log);
	    #
	    #
	    $info =~ s/ReturnValue/rrv/g;
	    $info =~ s/}/,"lrv":"0"}/g;
	    #
	    print kSChtml::ContentType("json");
	    print $info;
	} else {
	    my $info = kSChttp::GetLogAdmin($client,"6555","sysstat",$cm,$log);
	    print kSChtml::ContentType("json");
	    print $info;
	}
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
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
	if (kSCbasic::CheckUrlKeyValue("m","SYSINFO","y") == 0) {
	    SYSINFO(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DBINFO","y") == 0) {
	    DBINFO(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","GETWLS","y") == 0) {
	    GetWls("GETWLS",kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("port")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLSINFO","y") == 0) {
	    GetWls("WLSINFO",kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("port")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SysJqGrid","y") == 0) {
	    SysJqGrid(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceHostList","y") == 0) {
	    ServiceHostList(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSummary","y") == 0) {
	    HostSummary(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDB","y") == 0) {
	    OracleDB(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("db")),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLS","y") == 0) {
	    WLS(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("port")),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","y") == 0) {
	    OracleDBAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("db")),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","LogAdmin","y") == 0) {
	    LogAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("log"));
	} else {
	    my $out = kSChtml::ContentType("json");
	    $out.= kSCbasic::ErrorMessage("json","1");
	    print $out;
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","SYSINFO","n") == 0) {
	    SYSINFO(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DBINFO","n") == 0) {
	    DBINFO(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","GETWLS","n") == 0) {
	    GetWls("GETWLS",kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("port"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLSINFO","n") == 0) {
	    GetWls("WLSINFO",kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("port"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SysJqGrid","n") == 0) {
	    SysJqGrid(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceHostList","n") == 0) {
	    ServiceHostList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("c"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSummary","n") == 0) {
	    HostSummary(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("c"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDB","n") == 0) {
	    OracleDB(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLS","n") == 0) {
	    WLS(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("port"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","n") == 0) {
	    OracleDBAdmin(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","LogAdmin","n") == 0) {
	    LogAdmin(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("log"));
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
