#!/usr/bin/env perl
# -*- coding: utf-8 -*-
use strict;
use warnings;
use Getopt::Long qw(:config no_ignore_case autoabbrev);
use Time::Local;
use POSIX qw(strftime);
use List::Util qw(product);
 
my $from_ymdhms = "20160101";
my $to_ymdhms   = "20160201";
my $add;
my $step = "d"; # y:year, m:month, d:day, H:hour, M:min, S:sec
GetOptions (
    "from|ymdhms=s" => \$from_ymdhms,
    "to=s"          => \$to_ymdhms,
    "add=s"         => \$add,
    "step=s"        => \$step,
    );
 
if (defined $add) {
    print add_ymdhms($from_ymdhms, $add, $step)."\n";
} else {
    for (my $t = trim_ymdhms($from_ymdhms, $step);
	 $t < trim_ymdhms($to_ymdhms, $step);
	 $t = add_ymdhms($t, 1, $step)) {
	print "$t\n";
    }
}

sub trim_ymdhms {
    my $v = index("ymdHMS", $_[1]);
    $_[0] =~ /^((\d{4})(\d\d){$v})/ ? $1 : die "ymdHMS format error";
}
sub utime2ymdhms { strftime("%Y%m%d%H%M%S", localtime($_[0])) }
sub ymdhms2utime {
    $_[0] =~ /^(\d{4})(\d\d)?(\d\d)?(\d\d)?(\d\d)?(\d\d)?/
	? timelocal($6||0, $5||0, $4||0, $3||1, ($2||1)-1, $1) : 0;
}
sub add_ymdhms {
    my ($ymdhms, $add, $step) = @_;
    if ($step eq "m") {
	my ($y, $m) = $ymdhms =~ /^(\d{4})(\d\d)/;
	my $nm = $add + $m - 1;
	return sprintf("%4d%02d", $y + $nm / 12, $nm % 12 + 1);
    }
    my $step_sec = product((1, 60, 60, 24)[0..index("SMHd", $step)]);
    my $ut = ymdhms2utime($ymdhms) + $add * $step_sec;
    return trim_ymdhms(utime2ymdhms($ut), $step);
}
