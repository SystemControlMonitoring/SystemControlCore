#!/usr/bin/perl
#########################################################
#                                                       #
# HTML Framework für kVASy System Control               #
#                                                       #
#########################################################
use strict;
use warnings;
use LWP::Simple;
use Config::Properties;
# Name
package kSChtml;
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
sub ContentType {
    my $ct = shift;
    my $output;
    if ( ($ct eq "xml") || ($ct eq "XML") ) {
	$output.="Access-Control-Allow-Origin: *\n";
	$output.="Access-Control-Allow-Methods: *\n";
	$output.="Cache-Control: no-cache, no-store, max-age=0, must-revalidate\n";
	$output.="Content-type: application/xml; charset=utf-8\n\n";
	$output.="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    } elsif ( ($ct eq "json") || ($ct eq "JSON") ) {
	$output.="Access-Control-Allow-Origin: *\n";
	$output.="Access-Control-Allow-Methods: *\n";
	$output.="Cache-Control: no-cache, no-store, max-age=0, must-revalidate\n";
	$output.="Content-type: application/json; charset=utf-8\n\n";
    } elsif ( ($ct eq "text") || ($ct eq "TEXT") ) {
	$output.="Access-Control-Allow-Origin: *\n";
	$output.="Access-Control-Allow-Methods: *\n";
	$output.="Cache-Control: no-cache, no-store, max-age=0, must-revalidate\n";
	$output.="Content-type: text/plain; charset=utf-8\n\n";
    } elsif ( ($ct eq "html") || ($ct eq "HTML") ) {
	$output.="Access-Control-Allow-Origin: *\n";
	$output.="Access-Control-Allow-Methods: *\n";
	$output.="Cache-Control: no-cache, no-store, max-age=0, must-revalidate\n";
	$output.="Content-type: text/html; charset=utf-8\n\n";
	$output.="<!DOCTYPE html>\n";
    }
    return($output);
}
#
#
close ($CF);
#
1;