//
// Basic adapter for PPQ
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
        translate([-19.0, 0, 7.5])
            rotate(-50, [0,1,0])
                cylinder(7, 4.5, 4.5);
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

                    faces = [
                        [0,1,2,3],
                        [4,5,1,0],
                        [7,6,5,4],
                        [5,6,2,1],
                        [6,7,3,2],
                        [7,4,0,3]];

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
                    translate([6.0, 19.0/2, -0.1]) cylinder(11.2, 5.5, 3.5);
                    // The horizontal cylinder is for the follower when empty.
                    translate([6.0, -0.1, -2.0])
                        rotate(-90, [1, 0, 0])
                            cylinder(19.2, 5.0, 5.0);
                    // Right hand side has a lip, needs clearance.
                    translate([2.2, 13.5, 1.0])
                        rotate(35, [0,1,0])
                            cube([2, 3.5, 7]);
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

// translate([(base_len/2 - 3.9)*-1,
//            ((base_w + 4)/2)*-1, 12.0 + 0.2]) {
//     cube([base_len - 3.9, base_w + 4,
//           total_h - roof_th - 12.0]);
// }

module technical_side_cut () {

    // The top part is a prism, using the example layout for
    // polyhedron from the OpenSCAD manual. However, we also
    // shear it a little. Bottom layout is counter-clockwise:
    //    A   D
    //    B   C

    tech_x = 28.6;
    tech_y = 27;
    tech_z1 = 52.7;
    tech_z2 = 50.3;

    translate([-11.8, (tech_y/2)*-1, -66.0]) {

        a1 = [     0,      0, 0];
        b1 = [tech_x,      0, 0];
        c1 = [tech_x, tech_y, 0];
        d1 = [     0, tech_y, 0];

        a2 = a1 + [-6.6,  0, tech_z1];
        b2 = b1 + [-6.2,  0, tech_z2];
        c2 = c1 + [-6.2,  0, tech_z2];
        d2 = d1 + [-6.6,  0, tech_z1];

        faces = [
            [0,1,2,3],
            [4,5,1,0],
            [7,6,5,4],
            [5,6,2,1],
            [6,7,3,2],
            [7,4,0,3]];

        polyhedron([a1, b1, c1, d1, a2, b2, c2, d2], faces);
    }

}

difference () {
    union () {
        body_lower();
        body_upper();
    }

    ejector_cavity();

    translate([2.0, 0, -76.9])
        rotate(5, [0,1,0])
            main_cavity(83.5);

    technical_side_cut();

    // Inspection hole for the prototype, matches pistol magazine latch
    translate([-22.0, -7, -36.5])
        rotate(-6.8, [0,1,0])
            cube([10, 20, 4.8]);

    // XXX design observation and a measurement hole
    // translate([-25.5, 0, -3.8])
    //     cube([5, 20, 5]);

    translate([-27.0, -13.0, -72.0])
        rotate(90, [1,0,0])
            linear_extrude(height=1.0) text("Fraurem", size=5);
    translate([15.0, -13.0, -72.0])
        rotate(90, [1,0,0])
            linear_extrude(height=1.0) text("PPQ", size=5);
}
