#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCcore/MOD/live';
use lib '/kSCcore/MOD/html';
use lib '/kSCcore/MOD/basic';
use lib '/kSCcore/MOD/http';
# Include Library
use kSClive;
use kSChtml;
use kSCbasic;
use kSChttp;
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
# Functions
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
	# Exec Command
        my $exec = kSClive::DelSvcDowntime($client,kSCbasic::EncodeHTML($check),$utime);
        #
        # Output
        print kSChtml::ContentType("json");
	print "{\"HOST_NAME\":\"". $client ."\",\"SERVICE_NAME\":\"". kSCbasic::EncodeHTML($check) ."\",\"CMD\":\"DEL_SVC_DOWNTIME\",\"EXEC\":\"SUCCESS\",\"TS\":\"". kSCbasic::ConvertUt2Ts($utime) ."\"}";
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
