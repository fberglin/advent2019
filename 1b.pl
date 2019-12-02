#!/usr/bin/perl

open($fh, "< 1.input") || die "Unable to open file: $!\n";
@input = <$fh>;
close($fh);

# @input = ( 12, 14, 1969, 100756 );

$totalFuel = 0;

foreach $mass (@input) {
    $fuel = calculateFuelNeeded($mass);
    # print "Fuel needed for mass: $mass: $fuel\n";
    $totalFuel += $fuel;
}

print "Total fuel needed: $totalFuel\n";

sub calculateFuelNeeded(@) {
    my $mass = shift;
    my $fuel = int($mass / 3) - 2;

    if ($fuel <= 0) {
        return 0;
    }

    return $fuel + calculateFuelNeeded($fuel);
}

