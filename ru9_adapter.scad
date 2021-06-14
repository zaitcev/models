//
// The core module for Ruger PC Carbine adapters
//

// LOM C0: the lower cube zero
lom_c0_len = 48.0;
lom_c0_w = 29.2;
lom_c0_h = 38.0;

// Top C1: the top base cube 1, under "ribs"
top_c1_len = 62.0;
top_c1_w = 34.4;
top_c1_h = 3.2;
// "Rib"
top_c1r_len = 4.0;
top_c1r_w = top_c1_w;
top_c1r_h = 5.7-top_c1_h;
// Top C2: the center box
top_c2_len = top_c1_len;
top_c2_w = 28.6;
top_c2_h = 16.2;

// The top part of the adapter, above the zero plane
module top() {
    translate([lom_c0_len - top_c1_len, 0, 0]) {
        difference () {
            union () {
                // Main plate
                translate([0, (top_c1_w/2)*-1, 0])
                    cube([top_c1_len, top_c1_w, top_c1_h]);
                // "Ribs"
                effective_length = top_c1_len - top_c1r_len;
                for (pitch_base = [0 : effective_length/4 : top_c1_len]) {
                    translate([pitch_base, (top_c1r_w/2)*-1, top_c1_h])
                        cube([top_c1r_len, top_c1r_w, top_c1r_h]);
                }
                // Center box
                translate([0, (top_c2_w/2)*-1, 0])
                    cube([top_c2_len, top_c2_w, top_c2_h]);
                // Rest for the bolt stop transfer bar
                translate([0, -8.7, top_c2_h-0.1])
                    cube([3.2, 3.0, 3.5]);
            }

            // Cut for the bolt stop lever, accounts for its S-shape
            // This also truncates the rest for the bolt stop transfer bar.
            translate([-2.5, (top_c2_w/2 - 2.5)*-1, 10.8])
                rotate(-20.0, [0,0,1])
                    cube([20.0, 5.0, 9.0]);
            translate([4.4, (top_c2_w/2 + 0.2)*-1, 10.8])
                cube([6.0, 8.6 + 0.2, 5.5]);
            translate([-0.1, (top_c2_w/2 + 0.2)*-1, 10.8])
                cube([39.0, 5.0, 5.5]);
            translate([23.5, (top_c2_w/2 + 0.2)*-1, 10.8])
                cube([27.0, 3.0, 5.5]);

            // Cut for bolt stop transfer bar
            translate([6.7, -12.6, -0.4]) {
                rotate(-12.0, [0,1,0])
                    union () {
                        translate([0, 0, 3.0])
                            cube([1.8, 7.0, 18.0]);
                        cube([1.8, 4.0, 18.0]);
                    }
            }
        }
    }
}

// Lower Outer Mold, below the zero plane
module lom() {

    difference () {
        union () {

            translate([0, 0, lom_c0_h*-1]) {
                // The main body is a straight cube.
                translate([0, (lom_c0_w/2)*-1, 0])
                    cube([lom_c0_len, lom_c0_w, lom_c0_h + 0.1]);
            }

            // A litte slope in front, magazine intrudes into it.
            translate([0, 0, -18.0]) {
                rotate(-16.0, [0,1,0]) {
                    lom_slope_h = 19.1;
                    difference () {
                        translate([0, (lom_c0_w/2)*-1, 0])
                            cube([6.6, lom_c0_w, lom_slope_h]);
                        // Massive bevel is necessary.
                        translate([-0.1, (lom_c0_w/2 + 0.5), lom_slope_h/2])
                            rotate(-45.0, [0,0,1])
                                cube([5.0, 5.0, lom_slope_h + 0.2], center=true);
                        translate([-0.1, (lom_c0_w/2 + 0.5)*-1, lom_slope_h/2])
                            rotate(45.0, [0,0,1])
                                cube([5.0, 5.0, lom_slope_h + 0.2], center=true);
                    }
                }
            } // translate

            // Bottom slope
            translate([0, 0, (lom_c0_h + 6.2)*-1])
                rotate(-5.5, [0,1,0])
                    translate([0.6, ((lom_c0_w)/2)*-1, 0])
                        cube([lom_c0_len - 2.5, lom_c0_w, 6.2]);
        }

        translate([0, 0, (lom_c0_h + 6.0)*-1]) {
            union () {

                // Massive bevel is necessary.
                translate([-0.1, (lom_c0_w/2 + 0.5), (lom_c0_h - 7.0)/2 - 0.1])
                    rotate(-45.0, [0,0,1])
                        cube([5.0, 5.0, lom_c0_h - 7.0 + 0.1], center=true);
                translate([-0.1, (lom_c0_w/2 + 0.5)*-1, (lom_c0_h - 7.0)/2 - 0.1])
                    rotate(45.0, [0,0,1])
                        cube([5.0, 5.0, lom_c0_h - 7.0 + 0.1], center=true);

                // Little side indentations are necessary too.
                translate([10.0/2-0.1, (lom_c0_w/2), 10.0/2-0.1])
                    cube([10.0 + 0.1, 2.0, 16.0 + 0.1], center=true);
                translate([10.0/2-0.1, (lom_c0_w/2)*-1, 10.0/2-0.1])
                    cube([10.0 + 0.1, 2.0, 16.0 + 0.1], center=true);
            }
        }

        // Cutouts for the factory latch
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
