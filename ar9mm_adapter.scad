//
// The main module for AR9MM family
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

        translate([((well_length/2 - upp_len_off) + 0.1)*-1, -5.0/2, 8.1-1.5])
            cube([16, 5.0, 1.5+0.1]);

        // Feed ramp
        translate([-16.0, 0, 7.5])
            rotate(-50, [0,1,0])
                cylinder(7, 6.0, 5.5);
    }
}

// This is the complex hole into which the pistol magazine goes.
module main_cavity (total_h) {

    // The width of the magazine is 21.3 mm. However, given that material
    // bulges out when printed, we need a bit more.
    base_w = 22.4;
    base_len = 33.0;

    roof_th = 22.0;
    roof_w = 11.6;

    multmatrix(m = [[   1,   0,  -0.215, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {

        difference () {

            union () {

                // We add a little cut on top, because our prism below is
                // too small.
                translate([(base_len/2 - 10)*-1, (11.8/2)*-1,
                           (total_h - 0.1)]) {
                     cube([base_len - 10, 11.8, 5]);
                }

                // The top part is a prism, using the example layout for
                // polyhedron from the OpenSCAD manual. However, we also
                // shear it a little. Bottom layout is counter-clockwise:
                //    A   D
                //    B   C

                translate([(base_len/2)*-1, (base_w/2)*-1,
                           (total_h - roof_th)]) {

                    a1 = [0,        0, 0];
                    b1 = [base_len, 0, 0];
                    c1 = [base_len, base_w, 0];
                    d1 = [0,        base_w, 0];

                    a2 = a1 + [0, ((base_w - roof_w)/2),    roof_th];
                    b2 = b1 + [0, ((base_w - roof_w)/2),    roof_th];
                    c2 = c1 + [0, ((base_w - roof_w)/2)*-1, roof_th];
                    d2 = d1 + [0, ((base_w - roof_w)/2)*-1, roof_th];

                    faces = [[0,1,2,3], [4,5,1,0], [7,6,5,4],
                             [5,6,2,1], [6,7,3,2], [7,4,0,3]];

                    polyhedron([a1, b1, c1, d1, a2, b2, c2, d2], faces);
                }

                translate([(base_len/2)*-1, (base_w/2)*-1, 0]) {
                    cube([base_len, base_w, (total_h - roof_th) + 0.1]);
                }
            }

            // This little extension both serves as an over-travel stop
            // and adds a little material to pad our small feed ramp.
            translate([(base_len/2 + 0.1)*-1, (19.0/2)*-1, (total_h - 8.5)]) {
                difference () {
                    $fn = 30;
                    // The "main" cut-out that forms the over-travel stop
                    // at the bottom and the feed ramp at the top.
                    cube([5.0, 19.0, 11]);
                    // The vertical cylinder is a channel for the bullet tip.
                    translate([6.0, 19.0/2, -0.1]) cylinder(11.2, 5.0, 3.5);
                    // The horizontal cylinder is for the follower when empty.
                    translate([6.0, -0.1, -2.0])
                        rotate(-90, [1, 0, 0])
                            cylinder(19.2, 5.0, 5.0);
                    // This extra cut was originally done because the magazine
                    // is not symmetric: the right side lip is taller and hits
                    // the ramp buttress. However, we found that this cut
                    // removes the support material, so we extended it all
                    // the way across, including the left side.
                    translate([2.2, 2, 1.0])
                        rotate(35, [0,1,0])
                            cube([2, 15, 7]);
                }
            }

            // These "side wings" prevent the magazine from tilting sideways
            // while being inserted. It's mostly for user's convenience.
            translate([(base_len/2)*-1, ((base_w + 20.5)/2)*-1, 0]) {
                rotate(45, [0,0,1])
                    cube([10, 10, (total_h)]);
            }
            translate([(base_len/2)*-1, ((base_w - 7.9)/2), 0]) {
                rotate(45, [0,0,1])
                    cube([10, 10, (total_h)]);
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

// This side extension is needed because the side walls are
// much too thin to be reliably printed on basic equipment.
// So, we destroy side walls on purpose. Of course, we leave
// the lower belt intact. The width of this has to be large
// enough to affect the overtravel stop of the AR magazine.

module technical_side_cut () {

    // Bottom layout is counter-clockwise:
    //    A   D
    //    B   C

    tech_x = 28.7;
    tech_y = 27;
    tech_z1 = 54.4;
    tech_z2 = 52.0;

    translate([-11.7, (tech_y/2)*-1, -66.0]) {

        a1 = [     0,      0, 0];
        b1 = [tech_x,      0, 0];
        c1 = [tech_x, tech_y, 0];
        d1 = [     0, tech_y, 0];

        a2 = a1 + [-6.7,  0, tech_z1];
        b2 = b1 + [-6.55,  0, tech_z2];
        c2 = c1 + [-6.55,  0, tech_z2];
        d2 = d1 + [-6.7,  0, tech_z1];

        faces = [[0,1,2,3], [4,5,1,0], [7,6,5,4],
                 [5,6,2,1], [6,7,3,2], [7,4,0,3]];

        polyhedron([a1, b1, c1, d1, a2, b2, c2, d2], faces);
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
            translate([-30.0, (width1/2)*-1, -70.5])
                rotate(-6.0, [0,1,0])
                    cube([15, width1, 36.0]);

            // The main body, shaped as inverted "L".
            translate([-32.8, 0, -75.5]) {
                rotate(-3.0, [0,1,0])
                    union () {
                        translate([0, (width2/2)*-1, 0])
                            cube([15, width2, 44]);
                        translate([9.0, (width3/2)*-1, 36.5])
                            cube([11.0, width3, 7.5]);
                    }
            }

            // Removal of the support material above the latch bridge.
            translate([-17.1, 0, -27.3])
                rotate(40, [0,1,0])
                    cube([9.0, width3, 18], center=true);
        }

        // Removal of the support material above the button.
        translate([-28.1, 10.2, -32.3])
            rotate(40, [1,0,0])
                cube([4.0, 15, 15], center=true);
        translate([-28.1, -10.2, -32.3])
            rotate(-40, [1,0,0])
                cube([4.0, 15, 15], center=true);
    }
}

module latch_see_saw_side () {
    thickness = 2.0;
    hull () {
        cube([41.0, thickness, 3.0], center=true);
        translate([3.0, (thickness/2), 1.5])
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
                cube([6.0, 2.7, height], center=true);
            translate([0, 9.7, 0])
                cube([6.0, 2.7, height], center=true);

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
    translate([-17.8, (width/2)*-1, -73.0]) {
        rotate(-6.9, [0,1,0]) {
            cube([3.0, width, 40.0]);
            translate([3.0/2, -3+width/2, 37])
                rotate(40, [1,0,0])
                    cube([3.0, 3, 6], center=true);
            translate([3.0/2, 3+width/2, 37])
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
        translate([-23.3, 0, -53.4])
            rotate(92.0, [0,1,0])
        {
            union () {
                translate([0, -5.7, 0])
                    latch_see_saw_side();
                translate([0, 5.7, 0])
                    latch_see_saw_side();
            }
        }
        translate([-18.5, 0, -33.7])
            rotate(-7.0, [0,1,0])
                latch_see_saw_bridge();
        translate([-25.5, 0, -74.0])
            latch_see_saw_button();
        translate([-30.2, 0, -69.0])
            latch_see_saw_stop();

        latch_see_saw_spring();
    }
}

module adapter () {
    difference () {
        union () {
            body_lower();
            body_upper();
        }

        ejector_cavity();

        translate([2.0, 0, -75.7])
            rotate(5, [0,1,0])
                main_cavity(83.7);

        technical_side_cut();

        latch_big_cut();

        // XXX design observation and a measurement hole - do not print
        // translate([-25.5, 0, -3.8])
        //    cube([5, 20, 5]);

        // Text banners
        translate([-27.0, -13.0, -72.0])
            rotate(90, [1,0,0])
                linear_extrude(height=1.0) text("Fraurem", size=5);
        translate([15.0, -13.0, -72.0])
            rotate(90, [1,0,0])
                linear_extrude(height=1.0) text("PPQ", size=5);
    }
}

module main () {
    union () {
        adapter();
        latch_see_saw();
    }
}
