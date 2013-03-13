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
#
# vi /var/lib/pgsql/data/pg_hba.conf
#
## "local" is for Unix domain socket connections only
##local   kscdb       kscdb                             trust
#local   all         all                               trust
## IPv4 local connections:
#host    kscdb       kscdb       127.0.0.1/32          trust
## IPv6 local connections:
#host    all         all         ::1/128               trust
#
sub DBConnect {
    my $dbh = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("db.name") .";host=". $properties->getProperty("db.host") .";port=". $properties->getProperty("db.port") .";", $properties->getProperty("db.user"), $properties->getProperty("db.pass")) or die "[". (localtime) ."] Unable to connect: $DBI::errstr\n";
    return ($dbh);
}
#
sub WhichHostIcon {
    my $htypsn = shift;
    my $HTYPICON;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("select HTYPICON from class_hosttypes where HTYPSN=?");
    $sth->execute($htypsn);
    while ( (my $IDen) = $sth->fetchrow_array() ) {
        $HTYPICON = $IDen;
    }
    return ($HTYPICON);
    $sth->finish;
    $dbh->disconnect;
}
#
close ($CF);
#
1;
