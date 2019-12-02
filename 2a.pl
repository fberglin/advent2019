#!/usr/bin/perl

open($fh, "< 2.input") || die "Unable to open file: $!\n";
@input = <$fh>;
close($fh);

<<EOF
@input = "1,9,10,3,2,3,11,0,99,30,40,50";
@input = "2,4,4,5,99,0";
@input = "1,1,1,4,99,5,6,0,99";
@input = "2,3,0,3,99";
EOF
;

@list = split(/,/, @input[0]);
print "@list", "\n";

$list[1] = 12;
$list[2] = 2;

$pos = 0;

while (1) {
    $op = $list[$pos];
    print "p: $pos, op: $op\n";

    $p1 = $list[$pos + 1];
    $p2 = $list[$pos + 2];
    $r = $list[$pos + 3];

    $v1 = $list[$p1];
    $v2 = $list[$p2];

    print "p1: $p1, p2: $p2, r: $r\n";

    if (1 == $op) {
        $res = $v1 + $v2;
        print "v1: $v1, v2: $v2, sum: $res, r: $r\n";
        $list[$list[$pos + 3]] = $res;
    } elsif (2 == $op) {
        $res = $v1 * $v2;
        print "v1: $v1, v2: $v2, prod $res, r: $r\n";
        $list[$list[$pos + 3]] = $res;
    } elsif (99 == $op) {
        print "Stop\n";
        last;
    } else {
        print "Unknown op code at pos: $pos: $list[$pos]\n";
        last;
    }
    $pos += 4;
    print "\n";
}

print "@list", "\n";
print "Value at pos 0: $list[0]\n";

