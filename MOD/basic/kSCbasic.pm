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
use MIME::Base64 ();
# Name
package kSCbasic;
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
sub ConvertUt2Ts {
    my $ut = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($ut);
    my $out = sprintf "%04d-%02d-%02d %02d:%02d:%02d", $year+=1900, $mon+=1, $mday, $hour, $min, $sec;
    return($out) ;
}
#
sub ListReadme {
    my $dir = shift;
    my @files;
    opendir(DIR, $dir) or die $!;
    while(defined (my $file = readdir(DIR)))
    {
        if(-d "$file")
        {
            my $sdir = $file;
            opendir(newDIR, $file) or die $!;
            while(defined ($file = readdir(newDIR)))
            {
        	push(@files, "./". $sdir ."/". $file) if $file =~ /\.readme$/;
            }
    	    closedir(newDIR);
	}
    }
    return @files;
}
#
sub ListFile {
    my $dir = shift;
    my $fil = shift;
    my @files;
    opendir(DIR, $dir) or die $!;
    while(defined (my $file = readdir(DIR)))
    {
        if(-d "$file")
        {
            my $sdir = $file;
            opendir(newDIR, $file) or die $!;
            while(defined ($file = readdir(newDIR)))
            {
        	push(@files, "./". $sdir ."/". $file) if $file =~ /$fil/;
            }
    	    closedir(newDIR);
	}
    }
    return @files;
}
#
sub CheckUrlKeyValue {
    my $key = shift;
    my $vlu = shift;
    my $b64u6 = shift;
    my $i=0;
    foreach my $var (sort(keys(%ENV))) {
        my $val = $ENV{$var};
        $val =~ s|\n|\\n|g;
        $val =~ s|"|\\"|g;
        if ($var eq "QUERY_STRING") {
    	    if ( $val ne "" ) {
    		my @QS = split("&", $val);
    		foreach (@QS) {
    		    my @KV = split("=", $_);
    		    my $value;
    		    if ($b64u6 eq "y") {
    			$value = DecodeBase64u6($KV[1]);
    		    } else {
    			$value = $KV[1];
    		    }
    		    if ( ($KV[0] eq $key) && ($value eq $vlu) ) {
    			$i++;
    		    }
    		}
    	    }
    	}
    }
    #
    if ($i == 1) { return 0; } else { return 2; }
}
#
sub GetUrlKeyValue {
    my $key = shift;
    foreach my $var (sort(keys(%ENV))) {
        my $val = $ENV{$var};
        $val =~ s|\n|\\n|g;
        $val =~ s|"|\\"|g;
        if ($var eq "QUERY_STRING") {
    	    if ( $val ne "" ) {
    		my @QS = split("&", $val);
    		foreach (@QS) {
    		    my @KV = split("=", $_);
    		    if ($KV[0] eq $key) {
    			if ( scalar(@KV) > 2 ) {
    			    return ($KV[1] ."=". $KV[2]);
    			} else {
    			    return ($KV[1]);
    			}
    		    }
    		}
    	    }
    	}
    }
}
#
sub PrintUrlKeyValue {
    my $out = shift;
    my $i = 0;
    my $return;
    foreach my $var (sort(keys(%ENV))) {
        my $val = $ENV{$var};
        $val =~ s|\n|\\n|g;
        $val =~ s|"|\\"|g;
        if ($var eq "QUERY_STRING") {
    	    if ( $val ne "" ) {
    		#print "${var}=\"${val}\"\n";
    		my @QS = split("&", $val);
    		foreach (@QS) {
    		    my @KV = split("=", $_);
    		    if ( ($out eq "xml") || ($out eq "XML") ) {
    			if ( scalar(@KV) > 2 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."</value_". $i .">\n";
    			} else {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."</value_". $i .">\n";
    			}
    		    } elsif ( ($out eq "json") || ($out eq "JSON") ) {
    			if ( scalar(@KV) > 2 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."\",";
    			} else {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."\",";
    			}
    			
    		    } else {
    			if ( scalar(@KV) > 2 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."\n";
    			} else {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."\n";
    			}
    		    }
    		    $i++;
    		}
    	    }
    	}
    }
    return ($return);
}
#
sub DecodeBase64u6 {
    my $encoded = shift;
    my $decoded = substr($encoded, 0, -6);
    $decoded = MIME::Base64::decode($decoded);
    return ($decoded);
}
#
sub EncodeBase64u6 {
    my $decoded = shift;
    #my $encoded = substr($encoded, 0, -6);
    my $encoded = MIME::Base64::encode($decoded);
    return ($encoded ."Ab6Dej");
}
#
sub EncodeHTML {
    my $out = shift;
    $out =~ s/�/&Auml;/g;
    $out =~ s/\x{008e}/&Auml;/g;
    $out =~ s/�/&Ouml;/g;
    $out =~ s/\x{0099}/&Ouml;/g;
    $out =~ s/�/&Uuml;/g;
    $out =~ s/\x{009a}/&Uuml;/g;
    $out =~ s/�/&auml;/g;
    $out =~ s/\x{0084}/&auml;/g;
    $out =~ s/�/&ouml;/g;
    $out =~ s/\x{0094}/&ouml;/g;
    $out =~ s/�/&uuml;/g;
    $out =~ s/\x{0081}/&uuml;/g;
    $out =~ s/�/&szlig;/g;
    $out =~ s/\x{00e1}/&szlig;/g;
    return ($out);
}
#
sub EncodeXML {
    my $out = shift;
    $out =~ s/�/&#196;/g;
    $out =~ s/\x{008e}/&#196;/g;
    $out =~ s/�/&#214;/g;
    $out =~ s/\x{0099}/&#214;/g;
    $out =~ s/�/&#220;/g;
    $out =~ s/\x{009a}/&#220;/g;
    $out =~ s/�/&#228;/g;
    $out =~ s/\x{0084}/&#228;/g;
    $out =~ s/�/&#246;/g;
    $out =~ s/\x{0094}/&#246;/g;
    $out =~ s/�/&#252;/g;
    $out =~ s/\x{0081}/&#252;/g;
    $out =~ s/�/&#223;/g;
    $out =~ s/\x{00e1}/&#223;/g;
    $out =~ s/</&lt;/g;
    $out =~ s/>/&gt;/g;
    $out =~ s/&/&amp;/g;
    $out =~ s/\"/&quot;/g;
    $out =~ s/\'/&apos;/g;
    return ($out);
}
#
sub ErrorCode {
    my $out = shift;
    my $eco = shift;
    my $c = "mess.ERROR_". $eco;
    my $EM;
    if ( ($out eq "xml") || ($out eq "XML") ) {
	$EM.="<message>". $properties->getProperty($c) ."</message>\n";
    } elsif ( ($out eq "json") || ($out eq "JSON") ) {
	$EM.="\"MESSAGE\":\"". $properties->getProperty($c) ."\"";
    } else {
	$EM.=" -> ". $properties->getProperty($c);
    }
    return ($EM);
}
#
sub GetHostIcon {
    my $class = shift;
    #return ($properties->getProperty("icon.". $class);
    return ($properties->getProperty("icon.". $class .""));
}
#
close ($CF);
close STDERR;
#
1;
