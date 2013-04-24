#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use LWP::Simple;
use Config::Properties;
use DBI;
# Name
package kSCpostgre;
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
sub DBConnect {
    my $dbh = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("db.name") .";host=". $properties->getProperty("db.host") .";port=". $properties->getProperty("db.port") .";", $properties->getProperty("db.user"), $properties->getProperty("db.pass")) or die "[". (localtime) ."] Unable to connect Database: $DBI::errstr\n";
    return ($dbh);
}
#
sub REPOConnect {
    my $repo = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("repo.name") .";host=". $properties->getProperty("repo.host") .";port=". $properties->getProperty("repo.port") .";", $properties->getProperty("repo.user"), $properties->getProperty("repo.pass")) or die "[". (localtime) ."] Unable to connect Repository: $DBI::errstr\n";
    return ($repo);
}
#
sub WhichHostIcon {
    my $htypsn = shift;
    my $HTYPICON;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("select HTYPICON from class_hosttypes where HTYPSN=?");
    $sth->execute(uc($htypsn));
    while ( (my $IDen) = $sth->fetchrow_array() ) {
        $HTYPICON = $IDen;
    }
    return ($HTYPICON);
    $sth->finish;
    $dbh->disconnect;
}
#
sub AllHostIcons {
    # Assoziatives Array KEY => VALUE
    my $HTYPICON;
    my %out=();
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("select HTYPSN,HTYPICON from class_hosttypes");
    $sth->execute();
    while ( (my $SN,my $IC) = $sth->fetchrow_array() ) {
        #$HTYPICON = $IDen;
        $out{$SN} = $IC;
        #print $IC.":".$SN."\n";
    }
    return (%out);
    $sth->finish;
    $dbh->disconnect;
}
#
sub FillLiveticker {
    my $uid = shift;
    my $hname = shift;
    my $cusv = shift;
    my $hstate = shift;
    my $sname = shift;
    my $sstate = shift;
    my $output = shift;
    my $utime = time;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("SELECT ltid FROM perf_liveticker WHERE ltus = encode('". $uid ."','base64') AND lthn = encode('". $hname ."','base64') AND ltcv = encode('". $cusv ."','base64') AND lths = encode('". $hstate ."','base64') AND ltsn = encode('". $sname ."','base64') AND ltst = encode('". $sstate ."','base64') AND ltot = encode('". $output ."','base64')") or die "[". (localtime) ."] Liveticker Fill Select Failed: $DBI::errstr\n";
    $sth->execute();
    if ($sth->rows == 1) {
	# nothing to do
    } else {
	$dbh->do("INSERT INTO perf_liveticker(LTUS,LTHN,LTCV,LTHS,LTSN,LTST,LTOT,LTTS) values (encode('". $uid ."','base64'),encode('". $hname ."','base64'),encode('". $cusv ."','base64'),encode('". $hstate ."','base64'),encode('". $sname ."','base64'),encode('". $sstate ."','base64'),encode('". $output ."','base64'),'". $utime ."')") or die "[". (localtime) ."] Liveticker Fill Insert Failed: $DBI::errstr\n";
    }
    $sth->finish;
    $dbh->disconnect;
    return 0;
}
#
sub CleanLiveticker {
    # Delete entries older then 30min
    my $utime = time;
    $utime = $utime - 1800;
    my $dbh = DBConnect();
    $dbh->do("DELETE FROM perf_liveticker WHERE LTTS < ". $utime ."") or die "[". (localtime) ."] Liveticker Cleaning Failed: $DBI::errstr\n";
    $dbh->disconnect;
    return 0;
}
#
sub SelectLiveticker {
    my $uid = shift;
    my $dbh = DBConnect();
    my $sth = $dbh->prepare("SELECT decode(lthn,'base64'),decode(ltcv,'base64'),decode(lths,'base64'),decode(ltsn,'base64'),decode(ltst,'base64'),decode(ltot,'base64'),ltts FROM perf_liveticker WHERE ltus = encode('". $uid ."','base64') ORDER BY ltts DESC") or die "[". (localtime) ."] Liveticker Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
sub SelectDashboardAll {
    my $uid = shift;
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT decode(tv1,'base64'),decode(tv2,'base64'),decode(tv3,'base64') FROM repo_config WHERE tus = encode('". $uid ."','base64') AND tmd = encode('DASHBOARD','base64') ORDER BY tid ASC") or die "[". (localtime) ."] Repo Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
sub InsertRepository {
    # Insert into Web Repository
    my $tus = shift;
    my $tmd = shift;
    my $tky = shift;
    my $tv1 = shift;
    my $tv2 = shift;
    my $tv3 = shift;
    # Execution
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT tid FROM repo_config WHERE tus = encode('". $tus ."','base64') AND tmd = encode('". $tmd ."','base64') AND tky = encode('". $tky ."','base64') AND tv1 = encode('". $tv1 ."','base64') AND tv2 = encode('". $tv2 ."','base64') AND tv3 = encode('". $tv3 ."','base64')") or die "[". (localtime) ."] Repo Insert Select Failed: $DBI::errstr\n";
    $sth->execute();
    if ($sth->rows == 1) {
	# nothing to do
    } else {
	$dbh->do("INSERT INTO repo_config(tus,tmd,tky,tv1,tv2,tv3) VALUES (encode('". $tus ."','base64'),encode('". $tmd ."','base64'),encode('". $tky ."','base64'),encode('". $tv1 ."','base64'),encode('". $tv2 ."','base64'),encode('". $tv3 ."','base64')) ") or die "[". (localtime) ."] Repo Insert Failed: $DBI::errstr\n";
    }
    $sth->finish;
    $dbh->disconnect;
    return 0;
}
#
sub DeleteFromRepository {
    # Insert into Web Repository
    my $tus = shift;
    my $tmd = shift;
    my $tky = shift;
    # Execution
    my $dbh = REPOConnect();
    $dbh->do("DELETE FROM repo_config WHERE tus = encode('". $tus ."','base64') AND tmd = encode('". $tmd ."','base64') AND tky = encode('". $tky ."','base64')") or die "[". (localtime) ."] Delete From Repo Failed: $DBI::errstr\n";
    $dbh->disconnect;
    return 0;
}
#
sub CheckHash {
    # Get Variables
    #
    # StringHash -> /Filepath/index.pl:ctime
    my $StringHash = shift;
    #
    # FileHash -> Hash of Content of /Filepath/index.pl
    my $FileHash = shift;
    #
    my $StoredFileHash="";
    # Execution
    my $dbh = DBConnect();
    #
    if ($properties->getProperty("initial-version") == 9999) {
	return 0;
    } else {
	#
	my $sth = $dbh->prepare("SELECT decode(value,'base64') FROM config WHERE key = encode('". $StringHash ."','base64')") or die "[". (localtime) ."] Check Hash Select Failed: $DBI::errstr\n";
	$sth->execute();
	if ($sth->rows == 1) {
	    while ( (my $value) = $sth->fetchrow_array() ) {
    		$StoredFileHash = $value;
    	    }
	} else {
	    if ($properties->getProperty("initial-version") == 1) {
		$dbh->do("INSERT INTO config(key,value) VALUES (encode('". $StringHash ."','base64'),encode('". $FileHash ."','base64')) ") or die "[". (localtime) ."] Check Hash Insert Failed: $DBI::errstr\n";
		$StoredFileHash = $FileHash;
	    }
	}
	$sth->finish;
	$dbh->disconnect;
	#
	# Check selected Hash
	if ($StoredFileHash eq $FileHash) {
	    return 0;
	} else {
	    return 2;
	}
    }
    #
}
#
close ($CF);
#
1;
