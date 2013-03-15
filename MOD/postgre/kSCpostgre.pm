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
close ($CF);
#
1;
