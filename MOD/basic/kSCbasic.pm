#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen fÃ¼r kVASy System Control             #
#                                                       #
#########################################################
use strict;
use LWP::Simple;
use Config::Properties;
use MIME::Base64 ();
use Digest::MD5;
use Cwd qw(realpath);
use FileHash::Entry;
# Name
package kSCbasic;
#########################################################
#                                                       #
#                  Read Configuration                   #
#                                                       #
#########################################################
open my $CF, '<', '/kSCcore/CFG/core.properties' or die "[". (localtime) ."] Kann Konfiguration '/kSCcore/CFG/core.properties' nicht Ã¶ffnen!";
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
    			if ( scalar(@KV) == 3 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2]);
    		    	} elsif ( scalar(@KV) == 4 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2] ."=". $KV[3]);
    		    	} elsif ( scalar(@KV) == 5 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4]);
    		    	} elsif ( scalar(@KV) == 6 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5]);
    		    	} elsif ( scalar(@KV) == 7 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6]);
    		    	} elsif ( scalar(@KV) == 8 ) {
    		    	    $value = DecodeBase64u6($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."=". $KV[7]);
    		    	} else {
    		    	    $value = DecodeBase64u6($KV[1]);
    		    	}
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
    			if ( scalar(@KV) == 3 ) {
    			    return ($KV[1] ."=". $KV[2]);
    			} elsif ( scalar(@KV) == 4 ) {
    			    return ($KV[1] ."=". $KV[2] ."=". $KV[3]);
    			} elsif ( scalar(@KV) == 5 ) {
    			    return ($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4]);
    			} elsif ( scalar(@KV) == 6 ) {
    			    return ($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5]);
    			} elsif ( scalar(@KV) == 7 ) {
    			    return ($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6]);
    			} elsif ( scalar(@KV) == 8 ) {
    			    return ($KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."=". $KV[7]);
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
    			if ( scalar(@KV) == 3 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."</value_". $i .">\n";
    			} elsif ( scalar(@KV) == 4 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."=". $KV[3] ."</value_". $i .">\n";
    			} elsif ( scalar(@KV) == 5 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."</value_". $i .">\n";
    			} elsif ( scalar(@KV) == 6 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."</value_". $i .">\n";
    			} elsif ( scalar(@KV) == 7 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."</value_". $i .">\n";
    			} elsif ( scalar(@KV) == 8 ) {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."=". $KV[7] ."</value_". $i .">\n";
    			} else {
    			    $return.="<key_". $i .">". $KV[0] ."</key_". $i .">\n<value_". $i .">". $KV[1] ."</value_". $i .">\n";
    			}
    		    } elsif ( ($out eq "json") || ($out eq "JSON") ) {
    			if ( scalar(@KV) == 3 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."\",";
    			} elsif ( scalar(@KV) == 4 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."=". $KV[3] ."\",";
    			} elsif ( scalar(@KV) == 5 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."\",";
    			} elsif ( scalar(@KV) == 6 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."\",";
    			} elsif ( scalar(@KV) == 7 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."\",";
    			} elsif ( scalar(@KV) == 8 ) {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."=". $KV[7] ."\",";
    			} else {
    			    $return.="\"KEY_". $i ."\":\"". $KV[0] ."\",\"VALUE_". $i ."\":\"". $KV[1] ."\",";
    			}
    		    } else {
    			if ( scalar(@KV) == 3 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."\n";
    			} elsif ( scalar(@KV) == 4 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."=". $KV[3] ."\n";
    			} elsif ( scalar(@KV) == 5 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."\n";
    			} elsif ( scalar(@KV) == 6 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."\n";
    			} elsif ( scalar(@KV) == 7 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."\n";
    			} elsif ( scalar(@KV) == 8 ) {
    			    $return.=" -> ". $KV[0] ." = ". $KV[1] ."=". $KV[2] ."=". $KV[3] ."=". $KV[4] ."=". $KV[5] ."=". $KV[6] ."=". $KV[7] ."\n";
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
    $out =~ s/Ä/&Auml;/g;
    $out =~ s/\x{008e}/&Auml;/g;
    $out =~ s/Ö/&Ouml;/g;
    $out =~ s/\x{0099}/&Ouml;/g;
    $out =~ s/Ü/&Uuml;/g;
    $out =~ s/\x{009a}/&Uuml;/g;
    $out =~ s/ä/&auml;/g;
    $out =~ s/\x{0084}/&auml;/g;
    $out =~ s/\x{4d20}/&auml;/g;
    $out =~ s/ö/&ouml;/g;
    $out =~ s/\x{0094}/&ouml;/g;
    $out =~ s/ü/&uuml;/g;
    $out =~ s/\x{0081}/&uuml;/g;
    $out =~ s/ß/&szlig;/g;
    $out =~ s/\x{00e1}/&szlig;/g;
    $out =~ s/\'/&apos;/g;
    $out =~ s/\\/\\\\/g; # Backslash
    $out =~ s/\"/&quot;/g; # AnfÃ¼hrungszeichen
    $out =~ s/\(/&lang;/g;  # Klammer Offen
    $out =~ s/\)/&rang;/g;  # Klammer SchlieÃŸen
    $out =~ s/,/./g;
    return ($out);
}
#
sub EncodeXML {
    my $out = shift;
    $out =~ s/Ä/&#196;/g;
    $out =~ s/\x{008e}/&#196;/g;
    $out =~ s/Ö/&#214;/g;
    $out =~ s/\x{0099}/&#214;/g;
    $out =~ s/Ü/&#220;/g;
    $out =~ s/\x{009a}/&#220;/g;
    $out =~ s/ä/&#228;/g;
    $out =~ s/\x{0084}/&#228;/g;
    $out =~ s/ö/&#246;/g;
    $out =~ s/\x{0094}/&#246;/g;
    $out =~ s/ü/&#252;/g;
    $out =~ s/\x{0081}/&#252;/g;
    $out =~ s/ß/&#223;/g;
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
sub ErrorMessage {
    my $ty = shift;
    my $ec = shift;
    my $out;
    if ( ($ty eq "xml") || ($ty eq "XML") ) {
        $out.="<error_". $ec .">\n<module>kSCbasic::CheckUrlKeyValue</module>";
        $out.= ErrorCode("xml",$ec);
        $out.="<urlpara>";
        $out.= PrintUrlKeyValue("xml");
	$out.="\n</urlpara>\n</error_". $ec .">\n";
    } elsif ( ($ty eq "json") || ($ty eq "JSON") ) {
	$out.="{\"ERROR_". $ec ."\":{\"MODULE\":\"kSCbasic::CheckUrlKeyValue,";
	$out.= ErrorCode("json",$ec);
	$out.=",\"URLPARA\":{";
	$out.= substr(PrintUrlKeyValue("json"), 0, -1);
	$out.="}}";
    } else {
	$out.="Error 500";
    }
    return ($out);
}
#
sub GetHostIcon {
    my $class = shift;
    return ($properties->getProperty("icon.". $class .""));
}
#
sub GetStatusIcon {
    my $class = shift;
    my $type = shift;
    return ($properties->getProperty($type .".icon.". $class .""));
}
#
sub ShowEnv {
    my $script = shift;
    print "#################################################################\n";
    print "# Script: ". $script ." running.\n";
    print "#################################################################\n";
    print "PID=$$\n\n";
}
#
sub GetPid {
    print $$;
}
#
sub GetDashboardConfig {
    my $tree = $properties->splitToTree(qr/\./, 'dashboard-starter');
    return $tree;
}
#
sub GetIcingaBackendConfig {
    my $gibc = $properties->splitToTree(qr/\./, 'live.peer');
    return $gibc;
}
#
sub HashFromString {
    my $md5_data = shift;
    my $md5_hash = Digest::MD5::md5_hex( $md5_data );
    return ($md5_hash);
}
#
sub HashFromFile {
    my $filename = shift;
    open (my $fh, '<', $filename) or die "Can't open '$filename': $!";
    binmode ($fh);
    return (Digest::MD5->new->addfile($fh)->hexdigest);
}
#
sub GetScriptPath {
    return (Cwd::realpath($0));
}
#
sub BuildScriptString {
    my $InputFile = shift;
    my $a = FileHash::Entry->alloc;
    $a->initFromStat ($InputFile) or die "Build Script String - No such File or directory.";
    my $ctime = $a->ctime;
    my $out = $InputFile .":". $ctime;
    return ($out);
}
#
close ($CF);
#
1;
