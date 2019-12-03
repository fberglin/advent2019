#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 3.input") || die "Unable to open file: $!\n";
@input = <$fh>;
close($fh);

<<EOF
@input = ( "R75,D30,R83,U83,L12,D49,R71,U7,L72",
           "U62,R66,U55,R34,D71,R55,D58,R83" );
@input = ( "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
           "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7" );
@input = ( "R8,U5,L5,D3",
           "U7,R6,D4,L4" );
EOF
;

@wire_1 = split(/,/, $input[0]);
@wire_2 = split(/,/, $input[1]);

%grid = ();

$grid{"0,0"} = "o";

fillGrid(\%grid, \@wire_1, "A");
fillGrid(\%grid, \@wire_2, "B");

$minDistance = 1e6;

foreach $p (keys %grid) {
    if ($grid{$p} eq "+") {
        ($x, $y) = split(/,/, $p);
        # print "$x,$y\n";
        $distance = abs($x) + abs($y);
        if ($distance < $minDistance) {
            $minDistance = $distance;
        }
    }
}

print "Min distance: $minDistance\n";

# exit;

$minX = 1e6;
$minY = 1e6;
$maxX = 0;
$maxY = 0;

foreach $p (keys %grid) {
    ($x, $y) = split(/,/, $p);
    if ($x < $minX) { $minX = $x; };
    if ($x > $maxX) { $maxX = $x; };
    if ($y < $minY) { $minY = $y; };
    if ($y > $maxY) { $maxY = $y; };
}

print "Grid size: $minX,$minY : $maxX,$maxY\n";

exit;

for ($y=$maxY; $y>=$minY; $y--) {
    for ($x=$minX; $x<=$maxX; $x++) {
        if (defined($grid{"$x,$y"})) {
            print $grid{"$x,$y"};
        } else {
            print " ";
        }
    }
    print "\n";
}

sub fillGrid(@) {
    my $grid = shift;
    my $path = shift;
    my $name = shift;

    my $x = 0;
    my $y = 0;

    foreach $op (@{$path}) {
        $op =~ m/(\w)(\d+)/ or die "Unknown pattern: '$op'\n";
        my $dir = $1;
        my $distance = $2;

        for (1 ... $distance) {
            if ($dir eq "U") {
                $y++;
            } elsif ($dir eq "D") {
                $y--;
            } elsif ($dir eq "R") {
                $x++;
            } else {
                $x--;
            }
            if (defined($grid->{"$x,$y"})) {
                if ($name eq $grid->{"$x,$y"}) {
                    $grid->{"$x,$y"} = "#";
                } else {
                    $grid->{"$x,$y"} = "+";
                }
            } else {
                $grid->{"$x,$y"} = $name;
            }
        }
    }
    $grid->{"$x,$y"} = "X";
}

