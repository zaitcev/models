//
// A stand for miniature computer BOSGAME AG40
// One side strut
//

hole_h = 3.0;
hole_w = 2.5;

// Length of the strut between the stands halves (not the pitch).
strut_len = 66.0;

module strut () {
    translate([(strut_len/2)*-1, (1.0/2)*-1, 0])
        cube([strut_len, hole_h + 1.0, hole_w + 0.6]);
    translate([((strut_len + 6.0)/2)*-1, 0.1, 0])
        cube([strut_len + 6.0, hole_h-0.2, hole_w-0.2]);
}

strut();
