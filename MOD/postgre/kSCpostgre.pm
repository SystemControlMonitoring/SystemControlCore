#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use warnings;
use LWP::Simple;
use Config::Properties;
use DBI;
# Name
package kSCpostgre;
# Redirect Error Output
#########################################################
#                                                       #
#                  Read Configuration                   #
#                                                       #
#########################################################
open my $CF, '<', '/kSCcore/CFG/core.properties' or die "[". (localtime) ."] Kann Konfiguration '/kSCcore/CFG/core.properties' nicht öffnen!";
my $properties = Config::Properties->new();
$properties->load($CF);
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub DBConnect {
    my $dbh = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("db.name") .";host=". $properties->getProperty("db.host") .";port=". $properties->getProperty("db.port") .";", $properties->getProperty("db.user"), $properties->getProperty("db.pass")) or die "[". (localtime) ."] Unable to connect Database: $DBI::errstr\n";
    return ($dbh);
}
#
sub REPOConnect {
    my $repo = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("repo.name") .";host=". $properties->getProperty("repo.host") .";port=". $properties->getProperty("repo.port") .";", $properties->getProperty("repo.user"), $properties->getProperty("repo.pass")) or die "[". (localtime) ."] Unable to connect Repository: $DBI::errstr\n";
    return ($repo);
}
#
sub WhichHostIcon {
    my $htypsn = shift;
    my $HTYPICON;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("select HTYPICON from class_hosttypes where HTYPSN=?");
    $sth->execute(uc($htypsn));
    while ( (my $IDen) = $sth->fetchrow_array() ) {
        $HTYPICON = $IDen;
    }
    return ($HTYPICON);
    $sth->finish;
    $dbh->disconnect;
}
#
sub AllHostIcons {
    # Assoziatives Array KEY => VALUE
    my $HTYPICON;
    my %out=();
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("select HTYPSN,HTYPICON from class_hosttypes");
    $sth->execute();
    while ( (my $SN,my $IC) = $sth->fetchrow_array() ) {
        #$HTYPICON = $IDen;
        $out{$SN} = $IC;
        #print $IC.":".$SN."\n";
    }
    return (%out);
    $sth->finish;
    $dbh->disconnect;
}
#
sub FillLiveticker {
    my $uid = shift;
    my $hname = shift;
    my $cusv = shift;
    my $hstate = shift;
    my $sname = shift;
    my $sstate = shift;
    my $output = shift;
    my $utime = time;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("SELECT ltid FROM perf_liveticker WHERE ltus = encode('". $uid ."','base64') AND lthn = encode('". $hname ."','base64') AND ltcv = encode('". $cusv ."','base64') AND lths = encode('". $hstate ."','base64') AND ltsn = encode('". $sname ."','base64') AND ltst = encode('". $sstate ."','base64') AND ltot = encode('". $output ."','base64')") or die "[". (localtime) ."] Liveticker Fill Select Failed: $DBI::errstr\n";
    $sth->execute();
    if ($sth->rows == 1) {
	# nothing to do
    } else {
	$dbh->do("INSERT INTO perf_liveticker(LTUS,LTHN,LTCV,LTHS,LTSN,LTST,LTOT,LTTS) values (encode('". $uid ."','base64'),encode('". $hname ."','base64'),encode('". $cusv ."','base64'),encode('". $hstate ."','base64'),encode('". $sname ."','base64'),encode('". $sstate ."','base64'),encode('". $output ."','base64'),'". $utime ."')") or die "[". (localtime) ."] Liveticker Fill Insert Failed: $DBI::errstr\n";
    }
    $sth->finish;
    $dbh->disconnect;
    return 0;
}
#
sub CleanLiveticker {
    # Delete entries older then 30min
    my $utime = time;
    my $dbh = DBConnect();
    $dbh->do("DELETE FROM perf_liveticker WHERE LTTS < ". $utime-1800 ."") or die "[". (localtime) ."] Liveticker Cleaning Failed: $DBI::errstr\n";
    $dbh->disconnect;
    return 0;
}
#
sub SelectLiveticker {
    my $uid = shift;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("SELECT decode(lthn,'base64'),decode(ltcv,'base64'),decode(lths,'base64'),decode(ltsn,'base64'),decode(ltst,'base64'),decode(ltot,'base64'),ltts FROM perf_liveticker WHERE ltus = encode('". $uid ."','base64') ORDER BY ltts DESC") or die "[". (localtime) ."] Liveticker Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
close ($CF);
#
1;
