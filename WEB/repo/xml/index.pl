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
    print kSChtml::ContentType("xml");
    print "<dashboard>";
    while ( (my $tv1,my $tv2, my $tv3) = $sth->fetchrow_array()) {
	print "<link>\n";
	print "   <title>". kSCbasic::EncodeXML($tv1) ."</title>\n";
	print "   <desc>". kSCbasic::EncodeXML($tv2) ."</desc>\n";
	print "   <target>". kSCbasic::EncodeXML($tv3) ."</target>\n";
	print "</link>\n";
    }
    print "</dashboard>";
}
#
sub InsertDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY,VALUE1,VALUE2,VALUE3
    my $DashboardConfig = kSCbasic::GetDashboardConfig();
    #
    foreach my $key (keys %{$DashboardConfig}) {
	my @temp = split(";", $DashboardConfig->{$key});
	kSCpostgre::InsertRepository($uid,"DASHBOARD","STARTER",$temp[0],kSCbasic::EncodeXML($temp[1]),$temp[2]);
    }
    # Execution
    print kSChtml::ContentType("xml");
    print "<insert>COMPLETE</insert>";
}
#
sub DeleteDashboardAll {
    my $uid = shift;
    # USER,MODUL,KEY
    kSCpostgre::DeleteFromRepository($uid,"DASHBOARD","STARTER");
    # Execution
    print kSChtml::ContentType("xml");
    print "<delete>COMPLETE</delete>";
}
#
sub GetConfig {
    # Beispiel Funktion
    my $config = kSCbasic::GetDashboardConfig();
    print kSChtml::ContentType("text");
    foreach my $key (keys %{$config}) {
	print $config->{$key} ."\n";
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
if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","y") == 0) {
	SelectDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","y") == 0) {
	InsertDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","y") == 0) {
	DeleteDashboardAll(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","SelectDashboardAll","n") == 0) {
	SelectDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","InsertDashboardAll","n") == 0) {
	InsertDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeleteDashboardAll","n") == 0) {
	DeleteDashboardAll(kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","GetConfig","n") == 0) {
	GetConfig(kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("xml");
    $out.= kSCbasic::ErrorMessage("xml","0");
    print $out;
}
#
# End
#
