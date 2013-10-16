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
	if (kSCbasic::CheckUrlKeyValue("m","ListHosts","y") == 0) {
	    ListHosts(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListServices","y") == 0) {
	    ListServices(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListDatabases","y") == 0) {
	    ListDatabases(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListMiddleware","y") == 0) {
	    ListMiddleware(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHostgroups","y") == 0) {
	    ListHostgroups(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::GetUrlKeyValue("searchstring"));
	} else {
	    my $out = kSChtml::ContentType("json");
	    $out.= kSCbasic::ErrorMessage("json","1");
	    print $out;
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","ListHosts","n") == 0) {
	    ListHosts(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListServices","n") == 0) {
	    ListServices(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListDatabases","n") == 0) {
	    ListDatabases(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListMiddleware","n") == 0) {
	    ListMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHostgroups","n") == 0) {
	    ListHostgroups(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
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
sub ListHosts {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::SearchHost($uid,$searchstring);
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"CUST_VAL\":\"". $AH[0][$c][1][0] ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}
#
sub ListServices {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::SearchService($uid,$searchstring);
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="{\"NAME\":\"". $AH[0][$c][1] ."\",\"HOST\":\"". $AH[0][$c][0] ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}
#
sub ListDatabases {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::SearchDatabase($uid,$searchstring);
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
        if ($AH[0][$c][1] =~ /_DBST_/i) {
            $out.="{\"NAME\":\"". uc(substr($AH[0][$c][1], 10)) ."\"";
        } elsif ($AH[0][$c][1] =~ /_DBSTATUS/i) {
            $AH[0][$c][1] =~ s/_DBSTATUS//g;
            $out.="{\"NAME\":\"". uc(substr($AH[0][$c][1],7))  ."\"";
        } else {
            $out.="{\"NAME\":\"". $AH[0][$c][1] ."\"";
        }
	$out.=",\"HOST\":\"". $AH[0][$c][0] ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}
#
sub ListMiddleware {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::SearchMiddleware($uid,$searchstring);
    my $out; my $dbname;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	if ($AH[0][$c][1] =~ /WLS_SRV_/i) {
	    $dbname = uc(substr($AH[0][$c][1], 8));
	} else {
	    $dbname = $AH[0][$c][1];
	}
        $out.="{\"NAME\":\"". $dbname ."\",\"HOST\":\"". $AH[0][$c][0] ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}
#
sub ListHostgroups {
    my $uid = shift;
    my $searchstring = shift;
    my @AH = kSClive::SearchHostgroup($uid,$searchstring);
    my $out;
    for (my $c=0;$c<scalar(@{$AH[0]});$c++) {
	$out.="{\"NAME\":\"". $AH[0][$c][0] ."\",\"ALIAS\":\"". $AH[0][$c][1] ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print $out;
}