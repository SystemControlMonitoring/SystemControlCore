#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/http';
use lib '/kSCcore/MOD/postgre';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSChttp;
use kSCpostgre;
use warnings;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
#
#
#
#
# Functions Services
#
sub ReCheck {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::ScheduleForcedSvcCheck($client,kSCbasic::EncodeHTML($check),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"SCHEDULE_FORCED_SVC_CHECK\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub AckSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::AcknowledgeSvcProblem($client,kSCbasic::EncodeHTML($check),kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime);
        #
        # Clear Liveticker
        kSCpostgre::DeleteLiveticker($client,$check);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"ACKNOWLEDGE_SVC_PROBLEM\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub RemAckSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::RemoveSvcAcknowledgement($client,kSCbasic::EncodeHTML($check),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"REMOVE_SVC_ACKNOWLEDGEMENT\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub ComSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::AddSvcComment($client,kSCbasic::EncodeHTML($check),kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"ADD_SVC_COMMENT\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub DwntmSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $datestart = shift;
    my $dateend = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::ScheduleSvcDowntime($client,kSCbasic::EncodeHTML($check),kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime,$datestart,$dateend);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"SCHEDULE_SVC_DOWNTIME\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\",\"DATE_START\":\"". kSCbasic::ConvertUt2Ts($datestart) ."\",\"DATE_END\":\"". kSCbasic::ConvertUt2Ts($dateend) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub RemDwntmSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Get Downtime ID
	my @ID = kSClive::GetDwntmID($client,$check,$uid);
	my $DwntmID=0;
	for (my $c=0;$c<scalar(@{$ID[0]});$c++) { $DwntmID = $ID[0][$c][0]; }
	#
	# Exec Command
        my $exec = kSClive::DelSvcDowntime($DwntmID,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"DEL_SVC_DOWNTIME\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"DOWNTIME_ID\":\"". $DwntmID ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub DeacNotSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::DisableSvcNotifications($client,kSCbasic::EncodeHTML($check),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"DISABLE_SVC_NOTIFICATIONS\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub AcNotSvc {
    #
    # Parameter
    my $client = shift;
    my $check = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::EnableSvcNotifications($client,kSCbasic::EncodeHTML($check),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"ENABLE_SVC_NOTIFICATIONS\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
#
#
# Functions Hosts
#
sub ReCheckHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::ScheduleForcedHostCheck($client,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"SCHEDULE_FORCED_HOST_CHECK\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub AckHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::AcknowledgeHostProblem($client,kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"ACKNOWLEDGE_HOST_PROBLEM\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub RemAckHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::RemoveHostAcknowledgement($client,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"REMOVE_HOST_ACKNOWLEDGEMENT\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub ComHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::AddHostComment($client,kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"ADD_HOST_COMMENT\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub DwntmHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $author = shift;
    my $comment = shift;
    my $datestart = shift;
    my $dateend = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::ScheduleHostDowntime($client,kSCbasic::EncodeHTML($author),kSCbasic::EncodeHTML($comment),$utime,$datestart,$dateend);
        #
        # Output
        print kSChtml::ContentType("json");
        $comment =~ s/[\n]+//g;
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"SCHEDULE_HOST_DOWNTIME\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"AUTHOR\":\"". kSCbasic::EncodeHTML($author) ."\",\"COMMENT\":\"". kSCbasic::EncodeHTML($comment) ."\",\"DATE_START\":\"". kSCbasic::ConvertUt2Ts($datestart) ."\",\"DATE_END\":\"". kSCbasic::ConvertUt2Ts($dateend) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub RemDwntmHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Get Downtime ID
	my @ID = kSClive::GetDwntmIDHost($client,$uid);
	my $DwntmID=0;
	for (my $c=0;$c<scalar(@{$ID[0]});$c++) { $DwntmID = $ID[0][$c][0]; }
	#
	# Exec Command
        my $exec = kSClive::DelHostDowntime($DwntmID,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"DEL_HOST_DOWNTIME\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\",\"DOWNTIME_ID\":\"". $DwntmID ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub DeacNotHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::DisableHostNotifications($client,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"DISABLE_HOST_NOTIFICATIONS\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
sub AcNotHost {
    #
    # Parameter
    my $client = shift;
    my $uid = shift;
    my $utime = time;
    #
    # Execution
    if ( kSClive::AccessHost($uid,$client) == "1" ) {
	#
	# Exec Command
        my $exec = kSClive::EnableHostNotifications($client,$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"CMD\":\"ENABLE_HOST_NOTIFICATIONS\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","5");
	print $out;
    }
}
#
#
#
#
#
#
#
#
# Output
#
# e = encoded, m = module
while($request->Accept() >= 0) {

if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","y") == 0) {
	ReCheck(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckSvc","y") == 0) {
	AckSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckSvc","y") == 0) {
	RemAckSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComSvc","y") == 0) {
	ComSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmSvc","y") == 0) {
	DwntmSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmSvc","y") == 0) {
	RemDwntmSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotSvc","y") == 0) {
	DeacNotSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotSvc","y") == 0) {
	AcNotSvc(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ch")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ReCheckHost","y") == 0) {
	ReCheckHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckHost","y") == 0) {
	AckHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckHost","y") == 0) {
	RemAckHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComHost","y") == 0) {
	ComHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmHost","y") == 0) {
	DwntmHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("ar")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmHost","y") == 0) {
	RemDwntmHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotHost","y") == 0) {
	DeacNotHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotHost","y") == 0) {
	AcNotHost(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cl")),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("u")));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","1");
	print $out;
    }
} elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
    if (kSCbasic::CheckUrlKeyValue("m","ReCheck","n") == 0) {
	ReCheck(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckSvc","n") == 0) {
	AckSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckSvc","n") == 0) {
	RemAckSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComSvc","n") == 0) {
	ComSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmSvc","n") == 0) {
	DwntmSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmSvc","n") == 0) {
	RemDwntmSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotSvc","n") == 0) {
	DeacNotSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotSvc","n") == 0) {
	AcNotSvc(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("ch"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ReCheckHost","n") == 0) {
	ReCheckHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AckHost","n") == 0) {
	AckHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemAckHost","n") == 0) {
	RemAckHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","ComHost","n") == 0) {
	ComHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DwntmHost","n") == 0) {
	DwntmHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("ar"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("ds"),kSCbasic::GetUrlKeyValue("de"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","RemDwntmHost","n") == 0) {
	RemDwntmHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","DeacNotHost","n") == 0) {
	DeacNotHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("m","AcNotHost","n") == 0) {
	AcNotHost(kSCbasic::GetUrlKeyValue("cl"),kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","2");
	print $out;
    }
} else {
    my $out = kSChtml::ContentType("json");
    $out.= kSCbasic::ErrorMessage("json","0");
    print $out;
}

}
#
# End
#
