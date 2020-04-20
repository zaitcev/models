//
// RU9 family ejector
//

// The 1.34mm thick plate comes from a local hardware store.
// Closest American plates are:
//    16 Gauge = 1.588 mm
//    17 Gauge = 1.429 mm
//    18 Gauge = 1.270 mm
// 
thickness = 1.34;

module nose () {
    translate([3.0, 12.0, 0]) {
        rotate(60, [0,0,1]) {
            // Rotating around the zero corner helps to translate it around
            // precisely later, so move it where we want to rotate.
            translate([-2.5, 0, 0]) {
                cube([2.5, 9.0, thickness]);
            }
        }
    }
}

module stem () {
    translate([0, -3.0, 0])
        cube([3.0, 15.0, thickness]);
}

module root () {
    hull () {
        translate([0.0, -1.0, 0])
        cube([1.0, 1.0, thickness]);
        translate([0.0, (11.5+5.0)*-1, 0])
            cube([8.0, 11.5, thickness]);
    }
}

module main () {
    root();
    stem();
    nose();
}

main();
