//
// An extended bottom plate for the ETS 9-round magazine for Glock 42
//
// Copyright (c) 2019 Pete Zaitcev
//

// This is only an approximation. Actually the grip is a little narrower
// in the front than in the back. So, it mostly serves as a comment.
grip_w = 21.3;

module outer_sleeve () {
    strap_h = 27.2;
    front_r = 5.0;

    rear_r = 2.0;

    base_mr = 3.0;
    base_h = 7.0 - base_mr * 2;
    fr_base_r = 5.0;
    base_w = grip_w - base_mr * 2 + 4.0;

    off1 = grip_w / 2 - front_r;
    off2 = grip_w / 2 - rear_r;

    off_b1 = base_w / 2 - fr_base_r;

    // The main, taller part of the wrapping grip
    hull () {

        // This multmatrix is for the front strap.
        multmatrix(m = [[   1,   0,  -0.27,  0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {

            translate([0, off1, strap_h/2])
                cylinder(strap_h, front_r, front_r, center=true);
            translate([0, off1*-1, strap_h/2])
                cylinder(strap_h, front_r, front_r, center=true);
        }

        // The tilt of the rear cut differs and matches the magazine.
        multmatrix(m = [[   1,   0,  -0.215, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            translate([25.0, off2, strap_h/2])
                cylinder(strap_h, rear_r, rear_r, center=true);
            translate([25.0, off2*-1, strap_h/2])
                cylinder(strap_h, rear_r, rear_r, center=true);
        }
    }

    // The base that adds rigidity and serves as a handle at the bottom
    minkowski () {
        hull () {
            translate([-0.5, off_b1, base_h/2 + base_mr])
                cylinder(base_h, fr_base_r, fr_base_r, center=true);
            translate([-0.5, off_b1*-1, base_h/2 + base_mr])
                cylinder(base_h, fr_base_r, fr_base_r, center=true);
            translate([23.0, 0, base_h/2 + base_mr])
                cube([3, base_w, base_h], center=true);
        }
        sphere(base_mr, $fn = 12);
    }
}

module main_cavity () {

    rail_h = 2.4;
    rail_w = 18.8;
    rail_r = 5.0;
    off_rail = rail_w/2 - rail_r;

    flange_h = 2.1; // actual 2.32, but material prints wider
    flange_w = 16.8;
    flange_r = 4.6;
    off_flange = flange_w/2 - flange_r;

    cav_d = 40;    // magazine depth (at horizontal) is 30.6
    cav_w = 17.6;  // remember that the nose is narrower, to be done later
    cav_h = 28;    // bigger than strap_h
    cav_r = 4.0;
    off_cav_2 = cav_w/2 - cav_r;
    off_cav_1 = cav_w/2 - cav_r - 1.5;  // nose is significantly narrower

    translate([0, 0, 0]) {
        hull () {
            translate([-0.5, off_rail, rail_h/2])
                cylinder(rail_h, rail_r, rail_r, center=true);
            translate([-0.5, off_rail*-1, rail_h/2])
                cylinder(rail_h, rail_r, rail_r, center=true);
            translate([26.0, 0, rail_h/2])
                cube([3, rail_w, rail_h], center=true);
        }
    }

    translate([0, 0, rail_h - 0.1]) {
        hull () {
            translate([-0.5, off_flange, flange_h/2])
                cylinder(flange_h, flange_r, flange_r, center=true);
            translate([-0.5, off_flange*-1, flange_h/2])
                cylinder(flange_h, flange_r, flange_r, center=true);
            translate([26.0, 0, flange_h/2])
                cube([3, flange_w, flange_h], center=true);
        }
    }

    translate([-1.6, 0, rail_h + flange_h - 0.2]) {

        multmatrix(m = [[   1,   0,  -0.215, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            hull () {

                // front
                translate([0, off_cav_1, cav_h/2])
                    cylinder(cav_h, cav_r, cav_r, center=true);
                translate([0, off_cav_1*-1, cav_h/2])
                    cylinder(cav_h, cav_r, cav_r, center=true);

                // middle
                translate([7.0, off_cav_2, cav_h/2])
                    cylinder(cav_h, cav_r, cav_r, center=true);
                translate([7.0, off_cav_2*-1, cav_h/2])
                    cylinder(cav_h, cav_r, cav_r, center=true);

                // rear
                translate([27.0, 0, cav_h/2])
                    cube([3, cav_w, cav_h], center=true);
            }
        }
    }

    
}

module outer_mold () {

    difference () {

        outer_sleeve();

        // 2.5 is the thickness of the bottom of the factory plate
        translate([0, 0, 2.5])
            main_cavity();

        // XXX Inspection cut
        translate([-9, -13, -0.1])
            cube([10, 10, 10]);
    }
}

outer_mold();
