// A hanger for a shoe horn
// This design requires a supporting material.

module side(thickness) {
    intersection () {
        rotate(37, [0,1,0]) translate([-4,0,0]) {
            cube([100, thickness, 62.5]);
        }
        cube([40, thickness, 50]);
    }
}

translate ([0, 24-6, 0]) {
    side(6);
}
translate ([0, -24, 0]) {
    side(6);
}

// base cross-bar with hanging holes
module hole(dia) {
    $fa = 8; // for some reason this does not work
    $fs = 0.6;
    union () {
        cylinder(6.2, dia/2, dia/2);
        translate ([0,0, 4.6]) {
            cylinder(1.6, dia/2, (dia*2.5)/2);
        }
    }
}
difference () {
    translate ([0,-23,0]) cube([12, 46, 6]);
    translate ([6, 13.5,-0.1]) hole(3.5);
    translate ([6, -13.5,-0.1]) hole(3.5);
}
translate ([30,-23,0]) cube([10, 46, 2]);

// hanging bar
translate ([33, -23, 44]) {
    rotate (-90, [1,0,0]) cylinder(46, 7, 7);
}
