#!/usr/bin/perl

$input = "158126-624574";

($min, $max) = split "-", $input;

$count = 0;

for ($i=$min; $i<=$max; $i++) {
    $continue = 0;
    while ($i =~ m/((\d)\2+)/g) {
        $continue = 1 if length $1 == 2;
    }
    next if not $continue;

    $sorted = join "", sort split //, $i;
    next unless $sorted eq $i;

    $count++;
}

print "Count: $count\n";

