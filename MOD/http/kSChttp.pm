#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use LWP::Simple;
use Config::Properties;
# Name
package kSChttp;
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
sub GetClientInfo {
    my $ipaddr = shift;
    my $port = shift;
    my $api = shift;
    my $module = shift;
    #
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."?module=". $module ."");
    #
    return ($info);
}
#
sub GetDBInfo {
    my $ipaddr = shift;
    my $port = shift;
    my $api = shift;
    my $module = shift;
    my $db = shift;
    #
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."?module=". $module ."&db=". $db ."");
    #
    return ($info);
}
#
close ($CF);
#
1;
