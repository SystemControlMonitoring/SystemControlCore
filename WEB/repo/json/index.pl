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
    my $DashboardConfig = kSCbasic::GetDashboardConfig();
    #
    foreach my $key (keys %{$DashboardConfig}) {
        my @temp = split(";", $DashboardConfig->{$key});
	kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER",$temp[0],kSCbasic::EncodeHTML($temp[1]),$temp[2]);
    }
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
