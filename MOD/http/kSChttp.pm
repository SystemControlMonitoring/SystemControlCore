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
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."/?module=". $module ."");
    #
    #return ("http://". $ipaddr .":". $port ."/api/". $api ."?module=". $module ."");
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
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."/?module=". $module ."&db=". $db ."");
    #
    return ($info);
}
#
sub GetJqGridClientInfo {
    my $ipaddr = shift;
    my $port = shift;
    my $api = shift;
    my $module = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    #
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."/?module=". $module ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."");
    #
    return ($info);
}
#
sub GetJqGridODBInfo {
    my $ipaddr = shift;
    my $port = shift;
    my $api = shift;
    my $module = shift;
    my $db = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    #
    #my $info = "http://". $ipaddr .":". $port ."/api/". $api ."?module=". $module ."&db=". $db ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."";
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."/?module=". $module ."&db=". $db ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."");
    #
    return ($info);
}
#
sub GetODBAdmin {
    my $ipaddr = shift;
    my $port = shift;
    my $api = shift;
    my $module = shift;
    my $db = shift;
    my $datestart = shift;
    my $dateend = shift;
    #
    #my $info = "http://". $ipaddr .":". $port ."/api/". $api ."?module=". $module ."&db=". $db ."&_search=". $search ."&rows=". $rows ."&page=". $page ."&sidx=". $sidx ."&sord=". $sord ."";
    my $info = LWP::Simple::get("http://". $ipaddr .":". $port ."/api/". $api ."/?module=". $module ."&db=". $db ."&date_start=". $datestart ."&date_end=". $dateend ."");
    #
    return ($info);
}
#
close ($CF);
#
1;
