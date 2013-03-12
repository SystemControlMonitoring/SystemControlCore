#!/usr/bin/perl
#
use strict;
use warnings;
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/html';
use kSCbasic;
use kSChtml;
use Cwd qw(realpath);
# Redirect Error Output
open STDERR, '>>/kSCcore/LOG/error.log';
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
		print "{\"KERNEL_VERSION\":\"". $_ ."\"}\n";
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
} else {
    print kSChtml::ContentType("html");
    foreach ( sort(kSCbasic::ListReadme($scriptpath)) ) {
	open(DAT, $_) or die "[". (localtime) ."] Kann Datei nicht öffnen!\n";
	my @raw_data=<DAT>;
	close(DAT);
	foreach (@raw_data) {
	    print $_ ."\n";
	}
    }
}
#
close STDERR;