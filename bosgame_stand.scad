//
// A stand for miniature computer BOSGAME AG40
// One standing half
//

in_w = 24.0;
out_w = in_w + 2.5*2;
main_th = 9.0;
leg_h = 8.0;
leg_w = 3.0;

arm_base_h = 3.0;
arm_side_h = arm_base_h + 7.0;

hole_h = 3.0;
hole_w = 2.5;

module stand_arm () {
    // base
    translate([0, 0, 0])
        cube([(out_w - in_w)/2 + 3.0, main_th, arm_base_h]);
    // Actual arm
    translate([0, 0, 0])
        cube([(out_w - in_w)/2, main_th, arm_side_h]);
    // Nub
    translate([0, 0, arm_side_h - 0.8])
        cube([(out_w - in_w)/2 + 0.3, main_th, 0.8]);
}

module stand_mold () {

    // arms
    translate([(out_w/2)*-1, 0, leg_h + 4.0])
        stand_arm();
    mirror([1,0,0])
        translate([(out_w/2)*-1, 0, leg_h + 4.0])
            stand_arm();
    // main base
    translate([(out_w/2)*-1, 0, leg_h])
        cube([out_w, main_th, 4.0 + 0.01]);
    // legs
    translate([out_w/2 - leg_w, 0, 0])
        cube([leg_w, main_th, leg_h + 0.01]);
    translate([(out_w/2)*-1, 0, 0])
        cube([leg_w, main_th, leg_h + 0.01]);
}

module stand () {
    difference () {
        stand_mold();

        translate([(in_w/2 - hole_w/2), -0.01, leg_h + 1.9])
            cube([hole_w, main_th + 0.02, hole_h]);
        translate([(in_w/2 + hole_w/2)*-1, -0.01, leg_h + 1.9])
            cube([hole_w, main_th + 0.02, hole_h]);
    }
}

// // Design Only
// stand();
rotate(90.0, [1,0,0]) stand();
