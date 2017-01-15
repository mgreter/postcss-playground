#!/usr/bin/perl

# runs all tests 10 times and prints medians

use strict;
use warnings;
use IPC::Run3;

my %results = (
	'sass-nested' => [0, 0],
	'sass-extend' => [0, 0],
	'sass-for-loop' => [0, 0],
	'postcss-nested' => [0, 0],
	'postcss-extend' => [0, 0],
	'postcss-for-loop' => [0, 0],
);


for (my $i = 0; $i < 10; $i++) {

	foreach my $task (keys %results) {

		run3("gulp " . $task, undef, \ my $out, \ my $err);
		warn $err if defined $err && $err ne "";
		if ($out =~ /Finished .*? after ((?:[0-9]*[.])?[0-9]+)\s*([mu]?s)/) {
			my $time = $1;
			$time /= 1000 ** 1 if ($2 eq "ms");
			$time /= 1000 ** 2 if ($2 eq "us");
			$results{$task}->[0] += $time;
			$results{$task}->[1] ++;
		} else {
			die "error parsing result: $out\n";
		}

	}

}

foreach my $task (keys %results) {
	my $rv = $results{$task};
	print $task, ": ", $rv->[0] / $rv->[1], "s\n";
}