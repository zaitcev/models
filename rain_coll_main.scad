//
// A collector replacement for a rain barrel, body
//
// This unit replaces the grate on top of the barrel.
// The intent is to allow a removal of the grate without tools.
//

base_pitch = 114.3;
base_th = 2.4;

barrel_h = 30.0;
step_h = base_th + 4.0;

hole_d = 5.3;
corner_r = 6.0;

module mould () {

    // The flat base
    hull () {
        translate([base_pitch/2, base_pitch/2, 0])
            cylinder(base_th, r=corner_r, $fn=12);
        translate([(base_pitch/2)*-1, base_pitch/2, 0])
            cylinder(base_th, r=corner_r, $fn=12);
        translate([(base_pitch/2)*-1, (base_pitch/2)*-1, 0])
            cylinder(base_th, r=corner_r, $fn=12);
        translate([base_pitch/2, (base_pitch/2)*-1, 0])
            cylinder(base_th, r=corner_r, $fn=12);
    }

    // The barrel
    cylinder(barrel_h, 55.0, 53.0, $fn=36);
}

// // Design Only
// use <rain_coll_grate.scad>;

module main () {

    difference () {
        mould();

        // Corner holes
        // The stupidly low $fn is there to deal with printer crashing.
        translate([base_pitch/2, base_pitch/2, -0.01])
            cylinder(base_th + 0.02, r=hole_d/2, $fn=6);
        translate([(base_pitch/2)*-1, base_pitch/2, -0.01])
            cylinder(base_th + 0.02, r=hole_d/2, $fn=6);
        translate([(base_pitch/2)*-1, (base_pitch/2)*-1, -0.01])
            cylinder(base_th + 0.02, r=hole_d/2, $fn=6);
        translate([base_pitch/2, (base_pitch/2)*-1, -0.01])
            cylinder(base_th + 0.02, r=hole_d/2, $fn=6);

         // Large center hole with a step
        translate([0, 0, step_h])
            cylinder(barrel_h + 0.01 - step_h, 47.0, 50.0, $fn=36);
        translate([0, 0, -0.01])
            cylinder(step_h + 0.02, 45.0, 45.0, $fn=36);

        // Removal cut-out
        translate([(18.0/2)*-1, -60.0, step_h - 2.0])
            cube([18.0, 60.0, barrel_h + 0.01 - (step_h - 2.0)]);
    }

    // // Design Only
    // translate([0, 0, 12.0])
    //     color("pink")
    //         grate();
}

main();
