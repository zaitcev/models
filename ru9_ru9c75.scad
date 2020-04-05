//
// RU9C75
// Ruger PC Carbine, CZ-75 adapter
//

// use <ru9_adapter.scad>;

// Lower Outer Mold
module lom() {

    // LOM C0: the lower cube zero
    lom_c0_len = 48.0;
    lom_c0_w = 29.2;
    lom_c0_h = 37.0;

    difference () {
        union () {

            translate([0, 0, lom_c0_h*-1]) {
                difference () {
                    // The main body is a straight cube.
                    translate([0, (lom_c0_w/2)*-1, 0])
                        cube([lom_c0_len, lom_c0_w, lom_c0_h + 0.1]);

                    // Massive bevel is necessary.
                    translate([-0.1, (lom_c0_w/2 + 0.1), (lom_c0_h - 11.0)/2 - 0.1])
                        rotate(-45.0, [0,0,1])
                            cube([5.0, 5.0, lom_c0_h - 11.0 + 0.1], center=true);
                    translate([-0.1, (lom_c0_w/2 + 0.1)*-1, (lom_c0_h - 11.0)/2 - 0.1])
                        rotate(45.0, [0,0,1])
                            cube([5.0, 5.0, lom_c0_h - 11.0 + 0.1], center=true);

                    // Little side indentations are necessary too.
                    translate([10.0/2-0.1, (lom_c0_w/2), 10.0/2-0.1])
                        cube([10.0 + 0.1, 2.0, 10.0 + 0.1], center=true);
                    translate([10.0/2-0.1, (lom_c0_w/2)*-1, 10.0/2-0.1])
                        cube([10.0 + 0.1, 2.0, 10.0 + 0.1], center=true);
                }
            }

            // A litte slope in front, magazine intrudes into it.
            translate([0, 0, -18.0]) {
                rotate(-17.0, [0,1,0]) {
                    lom_slope_h = 20.0;
                    difference () {
                        translate([0, (lom_c0_w/2)*-1, 0])
                            cube([6.6, lom_c0_w, lom_slope_h]);
                        // Massive bevel is necessary.
                        translate([-0.1, (lom_c0_w/2 + 0.1), lom_slope_h/2])
                            rotate(-45.0, [0,0,1])
                                cube([5.0, 5.0, lom_slope_h + 0.2], center=true);
                        translate([-0.1, (lom_c0_w/2 + 0.1)*-1, lom_slope_h/2])
                            rotate(45.0, [0,0,1])
                                cube([5.0, 5.0, lom_slope_h + 0.2], center=true);
                    }
                }
            } // translate
        }

        // Latch cutouts
        lom_latch_r = 6.8;
        translate([4.0, (lom_c0_w/2 - 4.8)*-1, -10.0]) {
            rotate(-17.0, [0,1,0])
                rotate(90.0, [1,0,0])
                    union () {
                        cylinder(4.8 + 0.1, lom_latch_r, lom_latch_r);
                        translate([-7.0, -lom_latch_r, 0])
                            cube([7.0, lom_latch_r*2, 4.8 + 0.1]);
                    }
        }
        translate([4.0, (lom_c0_w/2 - 4.8), -10.0]) {
            rotate(-17.0, [0,1,0])
               rotate(-90.0, [1,0,0])
                    union () {
                        cylinder(4.8 + 0.1, lom_latch_r, lom_latch_r);
                        translate([-7.0, -lom_latch_r, 0])
                            cube([7.0, lom_latch_r*2, 4.8 + 0.1]);
                    }
        }
    }
}

module adapter () {
    lom();
}

module main () {
    adapter();
}

main();
