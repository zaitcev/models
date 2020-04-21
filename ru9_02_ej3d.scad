//
// RU9 family
// 02: ejector, in 3D
//

use <ru9_02_ejector.scad>;

// The 1.34mm thick plate comes from a local hardware store.
// Closest American plates are:
//    16 Gauge = 1.588 mm
//    17 Gauge = 1.429 mm
//    18 Gauge = 1.270 mm
//
thickness = 1.34;

module main () {
    linear_extrude(height=thickness) ejector_2d();
}

main();
