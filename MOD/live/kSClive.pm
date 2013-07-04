#!/usr/bin/perl
#########################################################
#                                                       #
# MKLive Implementation für kVASy System Control        #
#                                                       #
#########################################################
use strict;
use Monitoring::Livestatus;
use LWP::Simple;
use Config::Properties;
# Name
package kSClive;
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
    socket => $properties->getProperty('live.socket')
);
#########################################################
#                                                       #
#                       Databases                       #
#                                                       #
#########################################################
sub AllDatabases {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseOK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWA {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCR {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUN {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseNOK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseNOKNOACKOH {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state > 0\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseNOKACKOH {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state > 0\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 1\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseNOKOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state > 0\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseNOKOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state > 0\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseWAOFFHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseCROFFHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseUNOFFHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub TaovServices {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nStats: state = 0\nStats: state = 0\nStats: host_state = 0\nStatsAnd: 2\nStats: state = 1\nStats: state = 1\nStats: host_state = 0\nStatsAnd: 2\nStats: state = 1\nStats: acknowledged = 0\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 1\nStats: acknowledged = 1\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 1\nStats: acknowledged = 0\nStats: host_state > 0\nStatsAnd: 3\nStats: state = 2\nStats: state = 2\nStats: host_state = 0\nStatsAnd: 2\nStats: state = 2\nStats: acknowledged = 0\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 2\nStats: acknowledged = 1\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 2\nStats: acknowledged = 0\nStats: host_state > 0\nStatsAnd: 3\nStats: state = 3\nStats: state = 3\nStats: host_state = 0\nStatsAnd: 2\nStats: state = 3\nStats: acknowledged = 0\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 3\nStats: acknowledged = 1\nStats: host_state = 0\nStatsAnd: 3\nStats: state = 3\nStats: acknowledged = 0\nStats: host_state > 0\nStatsAnd: 3\nStats: sum host_num_services_pending\nAuthUser: ". $uid);
    return ($out);
}
#
sub TaovHosts {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nStats: state = 0\nStats: state = 1\nStats: state = 1\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 1\nStats: acknowledged = 1\nStatsAnd: 2\nStats: state = 2\nStats: state = 2\nStats: acknowledged = 0\nStatsAnd: 2\nStats: state = 2\nStats: acknowledged = 1\nStatsAnd: 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub TaovDatabases {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nStats: state = 0\nStats: state = 0\nStats: host_state = 0\nStatsAnd: 2\nStats: state > 0\nStats: state > 0\nStats: host_state = 0\nStatsAnd: 2\nStats: state > 0\nStats: acknowledged = 0\nStats: host_state = 0\nStatsAnd: 3\nStats: state > 0\nStats: acknowledged = 1\nStats: host_state = 0\nStatsAnd: 3\nStats: state > 0\nStats: acknowledged = 0\nStats: host_state > 0\nStatsAnd: 3\nAuthUser: ". $uid);
    return ($out);
}
#
sub ShowCriticalHosts {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: last_check display_name host_name state host_state plugin_output\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ShowCriticalServices {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: last_check display_name host_name state host_state plugin_output\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ShowNewCriticalHosts {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: last_check display_name host_name state host_state custom_variable_values plugin_output\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nFilter: host_acknowledged = 0\nFilter: last_state = 0\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ShowNewCriticalServices {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: last_check display_name host_name state host_state host_custom_variable_values plugin_output\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nFilter: host_acknowledged = 0\nFilter: last_state = 0\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
#
#
#
# Hosts
#
sub HostFullInfo {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostUp {
    # Alle Hosts mit Status UP 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostDo {
    # Alle Hosts mit Status DOWN 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUn {
    # Alle Hosts mit Status UNREACHABLE 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostNok {
    # Alle Hosts die NICHT-OK sind 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostNokNodt {
    # Alle Hosts die NICHT-OK sind und nicht in einer DOWNTIME = Aktive Probleme 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state > 0\nFilter: scheduled_downtime_depth = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostNokDt {
    # Alle Hosts die NICHT-OK sind und in einer DOWNTIME = Passive Probleme 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state > 0\nFilter: scheduled_downtime_depth > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoNoack {
    # Alle Hosts DOWN - NOACK 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoAck {
    # Alle Hosts DOWN - ACK 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnNoack {
    # Alle Hosts UNREACHABLE - NOACK 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnAck {
    # Alle Hosts UNREACHABLE - ACK 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoNoackNodt {
    # Alle Hosts DOWN - NOACK, nicht in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoAckNodt {
    # Alle Hosts DOWN - ACK, nicht in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoNoackDt {
    # Alle Hosts DOWN - NOACK, in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostDoAckDt {
    # Alle Hosts DOWN - ACK, in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnNoackNodt {
    # Alle Hosts UNREACHABLE - NOACK, nicht in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnAckNodt {
    # Alle Hosts UNREACHABLE - ACK, nicht in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnNoackDt {
    # Alle Hosts UNREACHABLE - NOACK, in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HostUnAckDt {
    # Alle Hosts UNREACHABLE - ACK, in Downtime 
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#########################################################
#                                                       #
#                       Search                          #
#                                                       #
#########################################################
sub SearchHost {
    # Alle eingerichteten Hosts 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: host_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub SearchService {
    # Liste Alle Services zu einem gesuchten Host
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub SearchDatabase {
    # Liste Alle Datenbanken
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ ". $searchstring ."\nFilter: display_name ~ DBSTATUS\nFilter: display_name ~ DBST\nOr: 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub SearchHostgroup {
    # Liste Alle Datenbanken
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostgroups\nColumns: name alias \nFilter: alias != check_mk\nFilter: name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceSearchList {
    # Liste Alle Services zu einem gesuchten Host
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostSearchList {
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending acknowledged plugin_output next_check\nFilter: host_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub DatabaseSearchList {
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name host_state display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: display_name ~~ DBST\nFilter: display_name ~~ DBSTATUS\nOr: 2\nFilter: display_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#########################################################
#                                                       #
#                    Hosts By Group                     #
#                                                       #
#########################################################
sub HbgAllHosts {
    # Von der Hostgruppenauswahl 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgOk {
    # Alle Hosts mit Status UP 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDo {
    # Alle Hosts mit Status DOWN 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUn {
    # Alle Hosts mit Status UNREACHABLE 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgNok {
    # Alle Hosts die NICHT-OK sind 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgNokNodt {
    # Alle Hosts die NICHT-OK sind und nicht in einer DOWNTIME = Aktive Probleme 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state > 0\nFilter: scheduled_downtime_depth = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgNokDt {
    # Alle Hosts die NICHT-OK sind und in einer DOWNTIME = Passive Probleme 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state > 0\nFilter: scheduled_downtime_depth > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoNoack {
    # Alle Hosts DOWN - NOACK 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoAck {
    # Alle Hosts DOWN - ACK 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnNoack {
    # Alle Hosts UNREACHABLE - NOACK 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnAck {
    # Alle Hosts UNREACHABLE - ACK 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoNoackNodt {
    # Alle Hosts DOWN - NOACK, nicht in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoAckNodt {
    # Alle Hosts DOWN - ACK, nicht in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoNoackDt {
    # Alle Hosts DOWN - NOACK, in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgDoAckDt {
    # Alle Hosts DOWN - ACK, in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 1\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnNoackNodt {
    # Alle Hosts UNREACHABLE - NOACK, nicht in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnAckNodt {
    # Alle Hosts UNREACHABLE - ACK, nicht in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnNoackDt {
    # Alle Hosts UNREACHABLE - NOACK, in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged = 0\nAuthUser: ". $uid); 
    return ($out);
}
#
sub HbgUnAckDt {
    # Alle Hosts UNREACHABLE - ACK, in Downtime 
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostsbygroup\nColumns: host_name state last_check num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: hostgroup_name = ". $searchstring ."\nFilter: state = 2\nFilter: scheduled_downtime_depth > 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub HostService {
    # Liste Alle Services zu einem gesuchten Host
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: host_name = ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
#########################################################
#                                                       #
#                      Service                          #
#                                                       #
#########################################################
sub ServiceFullList {
    # Liste Alle Services
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceHostList {
    # Liste Alle Services zu einem gesuchten Host
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: host_name = ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceOK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWA {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCR {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUN {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceNOK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceNOKNOACKOH {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state > 0\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceNOKOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state > 0\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceNOKOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state > 0\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOFFHND {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state = 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceWAOFFHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 1\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceCROFFHACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 2\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOFFHNOACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged = 0\nAuthUser: ". $uid);
    return ($out);
}
#
sub ServiceUNOFFHostsACK {
    my $uid = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: host_name display_name state last_check plugin_output long_plugin_output acknowledged next_check\nFilter: state = 3\nFilter: host_state > 0\nFilter: scheduled_downtime_depth = 0\nFilter: host_scheduled_downtime_depth = 0\nFilter: acknowledged > 0\nAuthUser: ". $uid);
    return ($out);
}
########################################################
#                                                      #
# Check Function of Backends                           #
#                                                      #
########################################################
sub CheckIcingaBackendFunction {
    my $check = $ml->selectall_hashref("GET hosts\nColumns: name", "name", { AddPeer => 1 } );
    return ($check);
}
#
########################################################
#                                                      #
# Get Configurations                                   #
#                                                      #
########################################################
sub AccessHost {
    my $uid = shift;
    my $host = shift;
    my $cc=0;
    my @check = $ml->selectall_arrayref("GET hosts\nColumns: name\nFilter: name = ". $host ."\nAuthUser: ". $uid);
    for (my $c=0;$c<scalar(@{$check[0]});$c++) { $cc++; }
    return ($cc);
}
#
sub GetConfiguredDatabases {
    my $uid = shift;
    my $host = shift;
    my @check = $ml->selectall_arrayref("GET services\nColumns: display_name\nFilter: host_name = ". $host ."\nFilter: display_name ~ DBSTATUS\nFilter: display_name ~ DBST\nOr: 2\nAuthUser: ". $uid);
    return (@check);
}
#
########################################################
#                                                      #
# Get Host Information                                 #
#                                                      #
########################################################
sub GetHostSummary {
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hosts\nColumns: host_name custom_variable_values address state last_check next_check groups num_services_ok num_services_warn num_services_crit num_services_unknown num_services_pending\nFilter: host_name ~~ ". $searchstring ."\nAuthUser: ". $uid);
    return ($out);
}
#
sub GetHostServiceSummary {
    my $uid = shift;
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET services\nColumns: plugin_output\nFilter: host_name ~~ ". $searchstring ."\nFilter: display_name ~~ Check_MK\nFilter: display_name ~~ System_Uptime\nOr: 2\nAuthUser: ". $uid);
    return ($out);
}
#
sub GetGroupName {
    my $searchstring = shift;
    my $out = $ml->selectall_arrayref("GET hostgroups\nColumns: alias\nFilter: name ~~ ". $searchstring ."");
    return ($out);
}
#
close ($CF);
#
1;
