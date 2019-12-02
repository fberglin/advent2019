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
@org = @list;

$target = 19690720;

foreach $noun (0 ... 99) {
    foreach $verb (0 ... 99) {
        @list = @org;
        $pos = 0;

        $list[1] = $noun;
        $list[2] = $verb;

        # print "@list\n";

        while (1) {
            $op = $list[$pos];

            $p1 = $list[$pos + 1];
            $p2 = $list[$pos + 2];
            $r = $list[$pos + 3];

            $v1 = $list[$p1];
            $v2 = $list[$p2];

            if (1 == $op) {
                $res = $v1 + $v2;
                $list[$list[$pos + 3]] = $res;
            } elsif (2 == $op) {
                $res = $v1 * $v2;
                $list[$list[$pos + 3]] = $res;
            } elsif (99 == $op) {
                last;
            } else {
                print "Unknown op code at pos: $pos: $list[$pos]\n";
                last;
            }
            $pos += 4;
        }
        # print "N: $noun, V: $verb, Result: $list[0]\n";

        if ($list[0] == $target) {
            print "Noun: $noun, Verb: $verb, Sum: ", 100 * $noun + $verb, "\n";
            exit(1);
        }
    }
}


