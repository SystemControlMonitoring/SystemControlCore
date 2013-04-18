#!/usr/bin/perl
#
use strict;
use warnings;
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/live';
use kSCbasic;
use kSChtml;
use kSClive;
use Cwd qw(realpath);
use Data::Dumper;
#
my $scriptpath = substr(realpath($0), 0, -9);
#
#
if (kSCbasic::CheckUrlKeyValue("cv","g") == 0) {
    print kSChtml::ContentType("json");
    foreach ( sort(kSCbasic::ListFile($scriptpath,"00.readme")) ) {
	open(DAT, $_) or die "[". (localtime) ."] Kann Datei nicht öffnen!\n";
	my @raw_data=<DAT>;
	close(DAT);
	foreach (@raw_data) {
	    if ( $_ =~ /<!--KERNEL_VERSION/ ) {
		$_ =~ s/[\r\n\t]+//g;
		$_ = substr($_, index($_, ":")+1, index($_, "--")-5);
		print "{\"KERNEL_VERSION\":\"". $_ ."\"}";
	    }
	}
    }
} elsif (kSCbasic::CheckUrlKeyValue("mv","g") == 0) {
    my $out;
    print kSChtml::ContentType("json");
    foreach ( sort(kSCbasic::ListReadme($scriptpath)) ) {
	open(DAT, $_) or die "[". (localtime) ."] Kann Datei nicht öffnen!\n";
	my @raw_data=<DAT>;
	close(DAT);
	foreach (@raw_data) {
	    if ( $_ =~ /<!--.*_VERSION/ ) {
		$_ =~ s/[\r\n\t]+//g;
		my $ver = substr($_, index($_, ":")+1, index($_, "--")-5);
		my $dsc = substr($_, 4, index($_, ":")-4);
		$out.="\"". $dsc ."\":\"". $ver ."\",";
	    }
	}
    }
    $out = substr($out, 0, -1);
    print "{". $out ."}\n";
} elsif (kSCbasic::CheckUrlKeyValue("ks","g") == 0) {
    #
    #
    # Check Icinga Backends
    #
    my $out;
    my %temp;
    my %host;
    my $single_host;
    print kSChtml::ContentType("text");
    # Get Configured Backends
    my $config = kSCbasic::GetIcingaBackendConfig();
    foreach my $key (keys %{$config}) {
	my %para = ( addr => $config->{$key}->{'addr'});
	push ( @{$host{ $config->{$key}->{'name'} }}, \%para );
	# Take effect only on single host backends.
	$single_host = $config->{$key}->{'name'};
    }
    # Check Icinga Backend
    my $CIBF = kSClive::CheckIcingaBackendFunction();
    foreach my $key (keys %{$CIBF}) {
	# Single Host Config
	if ( $CIBF->{$key}->{'peer_name'} =~ /Monitoring Cluster/i ) {
	    my %stat = ( status => "0" );
	    push ( @{$host{ $single_host }}, \%stat );
	    last; # break loop
	} else {
	    if (exists $temp{ $CIBF->{$key}->{'peer_key'} }) {
		# skip duplicate
	    } else {
		# Eliminate duplicates
		my %desc = ( name => $CIBF->{$key}->{'peer_name'}, addr => $CIBF->{$key}->{'peer_addr'} );
		push ( @{$temp{ $CIBF->{$key}->{'peer_key'} }}, \%desc );
		# Add to Host Hash
		my %stat = ( status => "0" );
		push ( @{$host{ $CIBF->{$key}->{'peer_name'} }}, \%stat );
	    }
	}
    }
    # Debug
    #print Dumper \%host;
    #print Dumper \%temp;
    foreach my $key (keys %host) {
	if ($host{$key}[1]->{'status'} eq "0") {
	    print $key ."-". $host{$key}[0]->{'addr'} ."-ONLINE\n";
	} else {
	    print $key ."-". $host{$key}[0]->{'addr'} ."-OFFLINE\n";
	}
    }
    # ------------
    #
    #
    #
} else {
    print kSChtml::ContentType("html");
    foreach ( sort(kSCbasic::ListReadme($scriptpath)) ) {
	open(DAT, $_) or die "[". (localtime) ."] Kann Datei nicht öffnen!\n";
	my @raw_data=<DAT>;
	close(DAT);
	foreach (@raw_data) {
	    print $_;
	}
    }
    print "<center><font size=2>SIV.AG</font></center><br></br>\n";
}
#