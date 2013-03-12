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
#                       Functions                       #
#                                                       #
#########################################################
sub ContentType {
    my $ct = shift;
    my $output;
    if ( ($ct eq "xml") || ($ct eq "XML") ) {
	$output.="Content-type: application/xml; charset=utf-8\n\n";
	$output.="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    } elsif ( ($ct eq "json") || ($ct eq "JSON") ) {
	$output.="Content-type: application/json; charset=utf-8\n\n";
    } elsif ( ($ct eq "text") || ($ct eq "TEXT") ) {
	$output.="Content-type: text/plain; charset=utf-8\n\n";
    } elsif ( ($ct eq "html") || ($ct eq "HTML") ) {
	$output.="Content-type: text/html; charset=utf-8\n\n";
	$output.="<!DOCTYPE html>\n";
    }
    return($output);
}
#
#
close ($CF);
close STDERR;
#
1;