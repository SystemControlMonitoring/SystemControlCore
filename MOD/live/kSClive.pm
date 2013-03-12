#!/usr/bin/perl
#########################################################
#                                                       #
# MKLive Implementation für kVASy System Control        #
#                                                       #
#########################################################
use strict;
use warnings;
use Monitoring::Livestatus;
use LWP::Simple;
use Config::Properties;
# Name
package kSClive;
# Redirect Error Output
open STDERR, '>>/kSCcore/LOG/error.log';
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
#              Set Monitoring Environment               #
#                                                       #
#########################################################
my $ml = Monitoring::Livestatus->new(
    name	=> $properties->getProperty('live.name'),
    verbose 	=> $properties->getProperty('live.vbos'),
    keepalive	=> $properties->getProperty('live.kplv'),
    peer	=> [
	{
    	    name => $properties->getProperty('live.peer.1.name'),
    	    peer => $properties->getProperty('live.peer.1.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.2.name'),
	    peer => $properties->getProperty('live.peer.2.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.3.name'),
	    peer => $properties->getProperty('live.peer.3.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.4.name'),
	    peer => $properties->getProperty('live.peer.4.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.5.name'),
	    peer => $properties->getProperty('live.peer.5.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.6.name'),
	    peer => $properties->getProperty('live.peer.6.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.7.name'),
	    peer => $properties->getProperty('live.peer.7.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.8.name'),
	    peer => $properties->getProperty('live.peer.8.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.9.name'),
	    peer => $properties->getProperty('live.peer.9.addr'),
	},
	{
	    name => $properties->getProperty('live.peer.10.name'),
	    peer => $properties->getProperty('live.peer.10.addr'),
	}
    ],
);
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub HostFullInfo {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostUp {
    # Alle Hosts mit Status UP 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDo {
    # Alle Hosts mit Status DOWN 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUn {
    # Alle Hosts mit Status UNREACHABLE 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostNok {
    # Alle Hosts die NICHT-OK sind 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostNokNodt {
    # Alle Hosts die NICHT-OK sind und nicht in einer DOWNTIME = Aktive Probleme 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state > 0\nFilter: scheduled_downtime_depth = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostNokDt {
    # Alle Hosts die NICHT-OK sind und in einer DOWNTIME = Passive Probleme 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state > 0\nFilter: scheduled_downtime_depth > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoNoack {
    # Alle Hosts DOWN - NOACK 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoAck {
    # Alle Hosts DOWN - ACK 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnNoack {
    # Alle Hosts UNREACHABLE - NOACK 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnAck {
    # Alle Hosts UNREACHABLE - ACK 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoNoackNodt {
    # Alle Hosts DOWN - NOACK, nicht in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoAckNodt {
    # Alle Hosts DOWN - ACK, nicht in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoNoackDt {
    # Alle Hosts DOWN - NOACK, in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostDoAckDt {
    # Alle Hosts DOWN - ACK, in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnNoackNodt {
    # Alle Hosts UNREACHABLE - NOACK, nicht in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnAckNodt {
    # Alle Hosts UNREACHABLE - ACK, nicht in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnNoackDt {
    # Alle Hosts UNREACHABLE - NOACK, in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HostUnAckDt {
    # Alle Hosts UNREACHABLE - ACK, in Downtime 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub SearchHost {
    # Alle eingerichteten Hosts 
    "GET hosts\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: host_name ~~ " + searchstring + "\nAuthUser: " + getUser() + "\n";
}
#########################################################
#                                                       #
#                    Hosts By Group                     #
#                                                       #
#########################################################
sub HbgAllHosts {
    # Von der Hostgruppenauswahl 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgOk {
    # Alle Hosts mit Status UP 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDo {
    # Alle Hosts mit Status DOWN 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUn {
    # Alle Hosts mit Status UNREACHABLE 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgNok {
    # Alle Hosts die NICHT-OK sind 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgNokNodt {
    # Alle Hosts die NICHT-OK sind und nicht in einer DOWNTIME = Aktive Probleme 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state > 0\nFilter: scheduled_downtime_depth = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgNokDt {
    # Alle Hosts die NICHT-OK sind und in einer DOWNTIME = Passive Probleme 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state > 0\nFilter: scheduled_downtime_depth > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoNoack {
    # Alle Hosts DOWN - NOACK 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoAck {
    # Alle Hosts DOWN - ACK 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnNoack {
    # Alle Hosts UNREACHABLE - NOACK 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnAck {
    # Alle Hosts UNREACHABLE - ACK 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoNoackNodt {
    # Alle Hosts DOWN - NOACK, nicht in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoAckNodt {
    # Alle Hosts DOWN - ACK, nicht in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoNoackDt {
    # Alle Hosts DOWN - NOACK, in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgDoAckDt {
    # Alle Hosts DOWN - ACK, in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnNoackNodt {
    # Alle Hosts UNREACHABLE - NOACK, nicht in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnAckNodt {
    # Alle Hosts UNREACHABLE - ACK, nicht in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnNoackDt {
    # Alle Hosts UNREACHABLE - NOACK, in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: " + getUser() + "\n"; 
}
#
sub HbgUnAckDt {
    # Alle Hosts UNREACHABLE - ACK, in Downtime 
    "GET hostsbygroup\nColumns: host_name state custom_variable_values last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = " + searchstring + "\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: " + getUser() + "\n"; 
}
#
#
close ($CF);
close STDERR;
#
1;
