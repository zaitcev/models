//
// A collector replacement for a rain barrel, grate
//
// This unit replaces the grate on top of the barrel.
// The intent is to allow a removal of the grate without tools.
//

grate_th = 2.0;

// Size of the hole is selected to be smaller than the usual grain
// that gets knocked off shingles. From the printing perspective,
// the larger is the better.
hole_d = 2.2;

module hole_belt (r, dphi) {
    for (phi = [0 : dphi : 360]) {
        rotate(phi, [0,0,1])
            translate([r, 0, -0.01])
                cylinder(grate_th + 0.02, hole_d/2, hole_d/2, $fn=12);
    }
}

module holes () {
    hole_belt(3.0, 60);
    hole_belt(6.0, 36);
    // hole_belt(9.0, 24);
    hole_belt(12.0, 18);
    hole_belt(15.0, 15);
    hole_belt(18.0, 12);
    // hole_belt(21.0, 10);
    hole_belt(24.0, 9);
    hole_belt(27.0, 8);
    hole_belt(30.0, 7.5);
    // hole_belt(33.0, 6);
    hole_belt(36.0, 5);
    hole_belt(39.0, 5);
    hole_belt(42.0, 4.5);
}

module ridge (r) {
    difference () {
        cylinder(grate_th + 2.0, r=r+1.0, $fn=36);
        translate([0, 0, -0.01])
            cylinder(grate_th + 2.0 + 0.02, r=r-1.0, $fn=36);
    }
}

module grate () {
    // Main part is basically a flat coolander
    difference () {
        cylinder(grate_th, r=46.0, $fn=36);
        holes();
    }
    // Stiffening ridges
    ridge(33.0);
    ridge(45.0);
    ridge(21.0);
    ridge(9.0);
}

grate();
