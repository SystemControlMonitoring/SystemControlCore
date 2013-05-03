#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/http';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSChttp;
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
sub TT {
    print kSChtml::ContentType("text");
    my @check = kSClive::GetConfiguredDatabases("sbaresel","dbwindo.siv.de");
    for (my $c=0;$c<scalar(@{$check[0]});$c++) {
	if ( $check[0][$c][0] =~ /_DBSTATUS/i ) {
	    my $dbname = substr($check[0][$c][0], index($check[0][$c][0], "_")+1);
	    $dbname = substr($dbname, 0, index($dbname, "_") );
	    print $dbname;
	} elsif ( $check[0][$c][0] =~ /_DBST_/i ) {
	    my $dbname = substr($check[0][$c][0], rindex($check[0][$c][0], "_")+1 );
	    print $dbname;
	}
    }
}
#
sub SYSINFO {
    my $client = shift;
    my $uid = shift;
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	my $info = kSChttp::GetClientInfo($client,"6555","Wmic.cpl","SYSINFO");
	print kSChtml::ContentType("json");
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
	    $info .= kSChttp::GetDBInfo($client,"6555","OracleDB.cpl","DBINFO",$dbname) .",";
	    $info =~ s/{\"/{\"DBNAME\":\"$dbname\",\"/g;
	} elsif ( $check[0][$c][0] =~ /_DBST_/i ) {
	    my $dbname = substr($check[0][$c][0], rindex($check[0][$c][0], "_")+1 );
	    #print $dbname;
	    $info .= kSChttp::GetDBInfo($client,"6555","OracleDB.cpl","DBINFO",$dbname) .",";
	    $info =~ s/{\"/{\"DBNAME\":\"$dbname\",\"/g;
	}
    }
    $info = substr($info, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $info ."]";

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
	my $info = kSChttp::GetJqGridClientInfo($client,"6555","Wmic.cpl",$module,$search,$rows,$page,$sidx,$sord);
	print kSChtml::ContentType("json");
	print $info;
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
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
	} elsif (kSCbasic::CheckUrlKeyValue("m","SysJqGrid","y") == 0) {
	    SysJqGrid(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
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
	} elsif (kSCbasic::CheckUrlKeyValue("m","SysJqGrid","n") == 0) {
	    SysJqGrid(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","TT","n") == 0) {
	    TT();
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
