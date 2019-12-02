#!/usr/bin/perl

open($fh, "< 1.input") || die "Unable to open file: $!\n";
@input = <$fh>;
close($fh);

# @input = ( 12, 14, 1969, 100756 );

$totalFuel = 0;

foreach $mass (@input) {
    $totalFuel += int($mass / 3) - 2;
}

print "Total fuel needed: $totalFuel\n";

