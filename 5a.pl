#!/usr/bin/perl

open($fh, "< 5.input") || die "Unable to open file: $!\n";
@input = <$fh>;
close($fh);

<<EOF
@input = "1002,4,3,4,33";
EOF
;

@list = split(/,/, @input[0]);

$pos = 0;

$inputValue = 1;

print "@list", "\n";

$output = "";

while (1) {
    $instruction = $list[$pos];

    $mode1 = 0;
    $mode2 = 0;
    $mode3 = 0;
    $op = 0;

    if (length $instruction == 1 or length $instruction == 2) {
        $op = $instruction;
    } elsif (length $instruction == 3) {
        $instruction =~ m/(\d)(\d\d)/;
        $mode1 = $1;
        $op = $2;
    } elsif (length $instruction == 4) {
        $instruction =~ m/(\d)(\d)(\d\d)/;
        $mode1 = $2;
        $mode2 = $1;
        $op = $3;
    } else {
        $instruction =~ m/(\d)(\d)(\d)(\d\d)/;
        $mode1 = $3;
        $mode2 = $2;
        $mode = $1;
        $op = $4;
    }

    $arg1 = $list[$pos + 1];
    $arg2 = $list[$pos + 2];
    $arg3 = $list[$pos + 3];

    $value1 = 0;
    $value2 = 0;

    if ($mode1 == 0) {
        $value1 = $list[$arg1];
    } else {
        $value1 = $arg1;
    }

    if ($mode2 == 0) {
        $value2 = $list[$arg2];
    } else {
        $value2 = $arg2;
    }

    if ($mode3 == 0) {
        $value3 = $list[$arg3];
    } else {
        $value3 = $arg3;
    }

    print "in: $instruction, op: $op, arg1: $arg1, arg2: $arg2, arg3: $arg3, val1: $value1, val2: $value2, val3: $value3\n";

    if (1 == $op) {
        $res = $value1 + $value2;
        # print "Putting $res in $arg3\n";
        $list[$arg3] = $res;
        $pos += 4;
    } elsif (2 == $op) {
        $res = $value1 * $value2;
        # print "Putting $res in $arg3\n";
        $list[$arg3] = $res;
        $pos += 4;
    } elsif (3 == $op) {
        $list[$arg1] = $inputValue;
        $pos += 2;
    } elsif (4 == $op) {
        $output .= $value1;
        # print ">> $output\n";
        $pos += 2;
    } elsif (99 == $op) {
        print "Stop\n";
        print $output, "\n";
        last;
    } else {
        print "Unknown op code at pos: $pos: $list[$pos]\n";
        last;
    }
}

