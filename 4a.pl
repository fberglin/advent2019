#!/usr/bin/perl

$input = "158126-624574";

($min, $max) = split("-", $input);

$count = 0;

for ($i=$min; $i<=$max; $i++) {
    $i =~ m/(\d)\1/ or next;

    $sorted = join(//, sort { $a <=> $b } split(//, $i));
    next unless $sorted eq $i;

    $count++;
}

print "Count: $count\n";

