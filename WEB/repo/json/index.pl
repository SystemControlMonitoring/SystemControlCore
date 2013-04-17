#!/usr/bin/perl
#
# Include Library Path
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/postgre';
# Include Library
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
sub SelectDashboardAll {
    my $uid = shift;
    my $sth = kSCpostgre::SelectDashboardAll($uid);
    my $out;
    while ( (my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	$out.="{\"TITLE\":\"". kSCbasic::EncodeHTML($tv1) ."\",\"DESC\":\"". kSCbasic::EncodeHTML($tv2) ."\",\"TARGET\":\"". kSCbasic::EncodeHTML($tv3) ."\"},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub InsertDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY,VALUE1,VALUE2,VALUE3
    kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER","Datenbanken",kSCbasic::EncodeHTML("Eine Übersicht über alle eingerichteten Datenbanken."),"db.jsp");
    kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER","Forms/Reports",kSCbasic::EncodeHTML("Eine Übersicht über alle eingerichteten Forms/Reports Umgebungen."),"fr.jsp");
    kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER","SOA/BAM",kSCbasic::EncodeHTML("Eine Übersicht über alle eingerichteten SOA/BAM Umgebungen."),"sb.jsp");
    kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER","BI",kSCbasic::EncodeHTML("Eine Übersicht über alle eingerichteten BI Umgebungen."),"bi.jsp");
    kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER","WebServices",kSCbasic::EncodeHTML("Eine Übersicht über alle eingerichteten WebServices."),"ws.jsp");
    # Execution
    print kSChtml::ContentType("json");
    print "{\"INSERT\":\"COMPLETE\"}";
}
#
sub DeleteDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteFromRepository($uid,"DASHBOARD","STARTER");
    # Execution
    print kSChtml::ContentType("json");
    print "{\"DELETE\":\"COMPLETE\"}";
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
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","y") == 0) {
	SelectDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","y") == 0) {
	InsertDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","y") == 0) {
	DeleteDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","n") == 0) {
	SelectDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","n") == 0) {
	InsertDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","n") == 0) {
	DeleteDashboardAll(kSCbasic::GetUrlKeyValue("u"));
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
