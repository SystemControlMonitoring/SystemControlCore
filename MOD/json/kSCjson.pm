#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
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
sub CheckPostgresProcess {
    my %decoded_info=();
    #
    if ( $properties->getProperty("db.host") eq $properties->getProperty("repo.host") ) {
	my $url = "http://". $properties->getProperty("db.host") .":". $properties->getProperty("db.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc1Byb2Nlc3M=HnL9H7";
	my $info = LWP::Simple::get( $url );
	die "Could not get $url!" unless defined $info;
	$decoded_info{$properties->getProperty("db.host")}{'name'} = $properties->getProperty("db.cname");
	$decoded_info{$properties->getProperty("db.host")}{'result'} = JSON::decode_json( $info );
    } else {
	# First KSCDB Check
	my $dburl = "http://". $properties->getProperty("db.host") .":". $properties->getProperty("db.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc1Byb2Nlc3M=HnL9H7";
	my $dbinfo = LWP::Simple::get( $dburl );
	die "Could not get $dburl!" unless defined $dbinfo;
	$decoded_info{$properties->getProperty("db.host")}{'name'} = $properties->getProperty("db.cname");
	$decoded_info{$properties->getProperty("db.host")}{'result'} = JSON::decode_json( $dbinfo );
	# Second REPO Check
	my $reurl = "http://". $properties->getProperty("repo.host") .":". $properties->getProperty("repo.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc1Byb2Nlc3M=HnL9H7";
	my $reinfo = LWP::Simple::get( $reurl );
	die "Could not get $reurl!" unless defined $reinfo;
	$decoded_info{$properties->getProperty("repo.host")}{'name'} = $properties->getProperty("repo.cname");
	$decoded_info{$properties->getProperty("repo.host")}{'result'} = JSON::decode_json( $reinfo );
    }
    return (\%decoded_info);
}
#
sub CheckPostgresOpenPorts {
    my %decoded_info=();
    #
    if ( $properties->getProperty("db.host") eq $properties->getProperty("repo.host") ) {
	my $url = "http://". $properties->getProperty("db.host") .":". $properties->getProperty("db.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc09wZW5Qb3J0cw==Lk99Uu";
	my $info = LWP::Simple::get( $url );
	die "Could not get $url!" unless defined $info;
	$decoded_info{$properties->getProperty("db.host")}{'name'} = $properties->getProperty("db.cname");
	$decoded_info{$properties->getProperty("db.host")}{'result'} = JSON::decode_json( $info );
    } else {
	# First KSCDB Check
	my $dburl = "http://". $properties->getProperty("db.host") .":". $properties->getProperty("db.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc09wZW5Qb3J0cw==Lk99Uu";
	my $dbinfo = LWP::Simple::get( $dburl );
	die "Could not get $dburl!" unless defined $dbinfo;
	$decoded_info{$properties->getProperty("db.host")}{'name'} = $properties->getProperty("db.cname");
	$decoded_info{$properties->getProperty("db.host")}{'result'} = JSON::decode_json( $dbinfo );
	# Second REPO Check
	my $reurl = "http://". $properties->getProperty("repo.host") .":". $properties->getProperty("repo.cport") ."/l4pg/json/?e=1&m=Q2hlY2tQb3N0Z3Jlc09wZW5Qb3J0cw==Lk99Uu";
	my $reinfo = LWP::Simple::get( $reurl );
	die "Could not get $reurl!" unless defined $reinfo;
	$decoded_info{$properties->getProperty("repo.host")}{'name'} = $properties->getProperty("repo.cname");
	$decoded_info{$properties->getProperty("repo.host")}{'result'} = JSON::decode_json( $reinfo );
    }
    return (\%decoded_info);
}
#
sub CheckXinetdProcess {
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'live.peer');
    foreach my $key (keys %{$gibc}) {
	# Get Conn Variables
	my $host = substr( $gibc->{$key}->{'addr'}, 0, index( $gibc->{$key}->{'addr'}, ":" ) );
	my $port = $gibc->{$key}->{'cport'};
	# Execution
	my $url = "http://". $host .":". $port ."/l4ica/json/?e=1&m=Q2hlY2tYaW5ldGRQcm9jZXNzVjK74H";
	my $info = LWP::Simple::get( $url );
	die "Could not get $url!" unless defined $info;
	$decoded_info{$host}{'name'} = $gibc->{$key}->{'name'};
	$decoded_info{$host}{'result'} = JSON::decode_json( $info );
    }
    #
    return (\%decoded_info);
}
#
sub CheckIcingaProcess {
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'live.peer');
    foreach my $key (keys %{$gibc}) {
	# Get Conn Variables
	my $host = substr( $gibc->{$key}->{'addr'}, 0, index( $gibc->{$key}->{'addr'}, ":" ) );
	my $port = $gibc->{$key}->{'cport'};
	# Execution
	my $url = "http://". $host .":". $port ."/l4ica/json/?e=1&m=Q2hlY2tJY2luZ2FQcm9jZXNzKlkd89";
	my $info = LWP::Simple::get( $url );
	die "Could not get $url!" unless defined $info;
	$decoded_info{$host}{'name'} = $gibc->{$key}->{'name'};
	$decoded_info{$host}{'result'} = JSON::decode_json( $info );
    }
    #
    return (\%decoded_info);
}
#
sub CheckIcingaOpenPorts {
    my %decoded_info=();
    my $gibc = $properties->splitToTree(qr/\./, 'live.peer');
    foreach my $key (keys %{$gibc}) {
	# Get Conn Variables
	my $host = substr( $gibc->{$key}->{'addr'}, 0, index( $gibc->{$key}->{'addr'}, ":" ) );
	my $port = $gibc->{$key}->{'cport'};
	# Execution
	my $url = "http://". $host .":". $port ."/l4ica/json/?e=1&m=Q2hlY2tJY2luZ2FPcGVuUG9ydHM=Wk27Uu";
	my $info = LWP::Simple::get( $url );
	die "Could not get $url!" unless defined $info;
	$decoded_info{$host}{'name'} = $gibc->{$key}->{'name'};
	$decoded_info{$host}{'result'} = JSON::decode_json( $info );
    }
    #
    return (\%decoded_info);
}
#
close ($CF);
#
1;
