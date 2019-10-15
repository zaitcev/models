//
// The main module for AR9MM family, SIG P250/P320/M17/M18
//

well_width = 22.60;
well_length = 60.75;        // main body without the bolt-stop rib

upp_len_off = 0.5;          // in front it's less space just because
upp_length = well_length - 1.5;

module body_lower ()
{
    corner_r = 2.0;
    lower_h = 74.0;

    union () {
        $fn = 12;
        difference () {
            // Main body
            // Corners must be chamfered, or this does not fit into magwell.
            translate([0, 0, lower_h*-1]) {
                hull () {
                    translate([(well_length/2 - corner_r)*-1,
                               (well_width/2 - corner_r), 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r)*-1,
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r),
                               (well_width/2 - corner_r), 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r),
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(lower_h, corner_r, corner_r);
                }
            }
            // AR magazine latch cutout
            translate([(well_length/2 - 10 - 10.0),
                       (well_width/2+0.1)*-1, (17.5+6.5)*-1]) {
                cube([10.0, 2.5, 6.5]);
            }
            // AR magazine latch chute, for easy insertion
            translate([(well_length/2 - 10 - 10.0),
                       (well_width/2 + 3.3)*-1, -3.5]) {
                rotate(-22, [1,0,0]) cube([10.0, 3, 5]);
            }
        }
        // AR magazine overtravel stop
        // This includes a little buttress, which replaces automatically
        // generated support lattice. Saves material, prints faster.
        translate([(well_length/2 - 10 - 10.0),
                   (well_width/2+1.1)*-1, (17.5+6.5+9.0)*-1]) {
            cube([10.0, 1.1+0.1, 9.0]);
        }
        translate([(well_length/2 - 10 - 10.0),
                   (well_width/2-0.14)*-1, (17.5+6.5+9.0+2.14)*-1]) {
            rotate(30, [1,0,0]) cube([10.0, 1.5, 2.5]);
        }
        // Bolt stop spine
        translate([(well_length/2 - 0.1), (11.0/2)*-1, lower_h*-1]) {
            cube([2.0+0.1, 11.0, lower_h]);
        }

        // The lower belt
        // This is necessary to keep front and rear together.
        translate([(well_length/2)*-1, (well_width/2 + 2.0)*-1, lower_h*-1]) {
            cube([well_length + 3.0, well_width + 2*2.0, 8.0]);
        }
    }
}

module body_upper ()
{

    difference () {

        union () {
            // The top part being narrower gives space for receiver rails.
            translate([(well_length/2 - upp_len_off)*-1,
                       (well_width/2-1.2)*-1, 0]) {
                cube([upp_length, well_width-(1.2*2), 8.1]);
            }
        }

        // Channel for the bottom of the bolt
        // Available bolt has the bottom sticking down just a little less.
        // We do not know yet if this is how all 9mm bolts are. Nonethless,
        // front part of the channel is a little shallower.

        translate([14*-1, -6.0/2, 8.1-2.5])
            cube([upp_length-15, 6.0, 2.5+0.1]);

        translate([((well_length/2 - upp_len_off) + 0.1)*-1, -5.4/2, 8.1-1.8])
            cube([16, 5.4, 1.8+0.1]);

        // Without this cut, bolt touches the rear of the top part just
        // slightly. This does not seem to hurt anything, but let's be safe.

        translate([33.5, 0, 7.5])
            rotate(-35, [0,1,0])
                cube([10, well_width, 10], center=true);

        // Feed ramp
        translate([-16.8, 0, 7.5])
            rotate(-50, [0,1,0])
                cylinder(7, 6.0, 5.5);
    }
}

//
// The main cavity is the complex hole into which the pistol magazine goes.
//
// It consists of the (main) body and a prism-like roof. We use hulls because
// the beveled edges at front are actually needed for a couple of reasons.
// First, they save the material in the critical parts near the feed ramp.
// Second, they prevent the magazine from tilting sideways when being inserted.
//

module main_cavity_roof (base_len, base_w, roof_th, fc_r) {

    hull () {

        multmatrix(m = [[   1,   0,   0,   0],
                        [   0,   1, -0.2,  0],
                        [   0,   0,   1,   0],
                        [   0,   0,   0,   1]]) {
            union () {
                translate([0, (base_w/2 - fc_r), 0]) {
                    translate([(base_len/2 - fc_r/2), 0, roof_th/2])
                        cube([fc_r, fc_r*2, roof_th], center=true);
                    translate([(base_len/2 - fc_r)*-1, 0, 0])
                        cylinder(roof_th, fc_r, fc_r);
                }
            }
        }

        multmatrix(m = [[   1,   0,   0,   0],
                        [   0,   1,  0.2,  0],
                        [   0,   0,   1,   0],
                        [   0,   0,   0,   1]]) {

            union () {
                translate([0, (base_w/2 - fc_r)*-1, 0]) {
                    translate([(base_len/2 - fc_r/2), 0, roof_th/2])
                        cube([fc_r, fc_r*2, roof_th], center=true);
                    translate([(base_len/2 - fc_r)*-1, 0, 0])
                        cylinder(roof_th, fc_r, fc_r);
                }
            }
        }
    }
}

module main_cavity_body (base_len, base_w, body_th, fc_r) {

    hull () {

        translate([0, (base_w/2 - fc_r), 0]) {
            translate([(base_len/2 - fc_r/2), 0, body_th/2])
                cube([fc_r, fc_r*2, body_th], center=true);
            translate([(base_len/2 - fc_r)*-1, 0, 0])
                cylinder(body_th, fc_r, fc_r);
        }

        translate([0, (base_w/2 - fc_r)*-1, 0]) {
            translate([(base_len/2 - fc_r/2), 0, body_th/2])
                cube([fc_r, fc_r*2, body_th], center=true);
            translate([(base_len/2 - fc_r)*-1, 0, 0])
                cylinder(body_th, fc_r, fc_r);
        }
    }
}

module main_cavity (total_h) {

    // The width of the magazine is 21.6 mm. However, given that material
    // bulges out when printed, we need a bit more.
    base_w = 22.7;
    base_len = 34.3;

    roof_th = 28.0;
    roof_w = 11.6;

    // Front Corner R: approximation
    fc_r = 5.0;

    multmatrix(m = [[   1,   0,  -0.33, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {

        difference () {

            union () {

                // We add a little cut on top for the topmost cartridge.
                translate([(base_len/2 - 8)*-1, (11.8/2)*-1,
                           (total_h - 0.1)]) {
                     cube([base_len - 8, 11.8, 5]);
                }

                translate([0, 0, (total_h - roof_th)]) {
                    main_cavity_roof(base_len, base_w, roof_th, fc_r);
                }

                translate([0, 0, 0]) {
                    main_cavity_body(base_len, base_w,
                                     (total_h - roof_th) + 0.1, fc_r);
                }
            }

            // This little extension both serves as an over-travel stop
            // and adds a little material to pad our small feed ramp.
            translate([(base_len/2 + 0.1)*-1, (19.0/2)*-1, (total_h - 8.3)]) {
                difference () {
                    // The "main" cut-out that forms the over-travel stop
                    // at the bottom and the feed ramp at the top.
                    cube([8.0, 19.0, 11]);
                    // The horizontal cylinder is for the follower when empty.
                    translate([9.3, -0.1, -0.7])
                        rotate(-90, [1, 0, 0])
                           cylinder(19.2, 8.3, 8.3, $fn=36);
                }
            }
        }
    }
}

// The root of the ejector is 1.38 thick, 7.5 wide. Length TBD.
module ejector_cavity () {

    depth = 30.0;  // excessive on purpose - should be called "cut_length"?

    union () {

        translate([16, -3.8, 5.0]) {

            rotate(60.0, [0, 1, 0]) {

                // The main pocket is a pocket at 60 degrees, documented
                // in ar9mm_02_ejector.xcf. We center the cube so that it
                // rotates in a predictable way.
                translate([(depth/2)*-1, (1.7/2)*-1, (7.9/2)*-1])
                    cube([depth, 1.7, 7.9]);

                // We also add an inspection hole.
                translate([depth/2, 0, 0])
                    rotate(90, [1, 0, 0])
                        cylinder(20, 3, 3);
            }
        }

    }
}

// This is the cut-out for the pistol magazine latch.
module latch_big_cut () {

    width1 = 8.8;
    width2 = 16.0;
    width3 = 27;

    difference () {
        union () {

            // A tall and narrow cut for the spring.
            translate([-20.0, (width1/2)*-1, -70.5])
                rotate(-5.0, [0,1,0])
                    cube([10, width1, 36.0]);

            // The main body, shaped as inverted "L".
            translate([-32.6, 0, -78.9]) {
                rotate(-5.0, [0,1,0])
                    union () {
                        translate([0, (width2/2)*-1, 0])
                            cube([16.8, width2, 44]);
                        translate([9.0, (width3/2)*-1, 36.5])
                            cube([14.0, width3, 7.5]);
                    }
            }

            // Removal of the support material above the latch bridge.
            translate([-16.9, 0, -30.9])
                rotate(40, [0,1,0])
                    cube([9.0, width3, 16], center=true);
        }

        // Removal of the support material above the button.
        translate([-28.1, 10.2, -35.2])
            rotate(40, [1,0,0])
                cube([5.1, 15, 15], center=true);
        translate([-28.1, -10.2, -35.2])
            rotate(-40, [1,0,0])
                cube([5.1, 15, 15], center=true);
    }
}

module latch_see_saw_side () {
    thickness = 2.0;
    hull () {
        cube([37.0, thickness, 3.0], center=true);
        translate([4.5, (thickness/2), 1.5])
            rotate(90, [1,0,0])
                cylinder(thickness, 2.0, 2.0);
    }
}

module latch_see_saw_bridge () {
    height = 4.0;
    difference () {
        union () {
            translate([-3.2, 0, 0])
                cube([4.5, 22.1, height], center=true);

            translate([0, -9.7, 0])
                cube([5.5, 2.7, height], center=true);
            translate([0, 9.7, 0])
                cube([5.5, 2.7, height], center=true);

            translate([-1.0, 8.7, 0])
                rotate(-45, [0,0,1])
                    cube([2.0, 3, height], center=true);
            translate([-1.0, -8.7, 0])
                rotate(45, [0,0,1])
                    cube([2.0, 3, height], center=true);
        }

        // Make a slanted side that alleviates the support material.
        translate([-7.0, 0, -0.1])
            rotate(-32, [0,1,0])
                cube([4.5, 22.3, 7.3], center=true);
    }
}

module latch_see_saw_button () {
    width = 14.0;
    translate([0, (width/2)*-1, 0.0])
        cube([3.0, width, 10.0]);
}

module latch_see_saw_spring () {
    width = 7.0;
    translate([-16.7, (width/2)*-1, -71.4]) {
        rotate(-8.5, [0,1,0]) {
            cube([3.0, width, 36.0]);
            translate([3.0/2, -3+width/2, 33])
                rotate(40, [1,0,0])
                    cube([3.0, 3, 6], center=true);
            translate([3.0/2, 3+width/2, 33])
                rotate(-40, [1,0,0])
                    cube([3.0, 3, 6], center=true);
        }
    }
}

// The overtravel stop is necessary for a couple of reasons.
// First, it prevents the user from breaking off the latch by mistake.
// Second, when the bolt presses the magazine down (it does so through the
// column of ammunition - it must never hit the magazine lips, of course),
// the see-saw starts extending outward. The overtravel stop supports it
// and makes it stronger.
module latch_see_saw_stop () {
    width = 20.0;
    thickness = 3.8;
    translate([0, (width/2)*-1, 0.0]) {
        difference () {
            cube([thickness, width, 7.0]);
            translate([-0.1, width/2, -5])
                rotate(90, [0,1,0])
                    cylinder(thickness+0.2, 9, 9);
        }
    }
}

module latch_see_saw () {
    union () {
        translate([-22.0, 0, -53.7])
            rotate(90.0, [0,1,0])
        {
            union () {
                translate([0, -5.7, 0])
                    latch_see_saw_side();
                translate([0, 5.7, 0])
                    latch_see_saw_side();
            }
        }
        translate([-18.0, 0, -36.1])
            rotate(-9.0, [0,1,0])
                latch_see_saw_bridge();
        translate([-24.0, 0, -74.0])
            latch_see_saw_button();
        translate([-29.0, 0, -69.0])
            latch_see_saw_stop();

        latch_see_saw_spring();
    }
}

module adapter_base () {
    difference () {
        union () {
            body_lower();
            body_upper();
        }

        translate([4.0, 0, -77.2])
            rotate(10, [0,1,0])
                main_cavity(83.7);

        latch_big_cut();

        // Text banners
        translate([-27.0, -13.0, -72.0])
            rotate(90, [1,0,0])
                linear_extrude(height=1.0) text("Fraurem", size=5);
        translate([18.0, -13.0, -72.0])
            rotate(90, [1,0,0])
                linear_extrude(height=1.0) text("SIG", size=5);
    }
}

module adapter () {
    union () {
        adapter_base();
        latch_see_saw();
    }
}
