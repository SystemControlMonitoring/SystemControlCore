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
use Encode;
use JSON qw( decode_json );
# Name
package kSCjson;
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
sub CheckIcinga {
    my $url_dbinfo = "http://localhost:". $PORT ."/api/OracleDB.cpl?module=DBINFO&db=". $name ."";
    my $dbinfo = get( $url_dbinfo );
    die "Could not get $url_dbinfo!" unless defined $dbinfo;
    my $decoded_dbinfo = decode_json( $dbinfo );
}
#
close ($CF);
#
1;
