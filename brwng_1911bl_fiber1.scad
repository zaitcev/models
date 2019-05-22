// Browning 1911-22/1911-380 (not "Pro"), the front sight with fiber optics

// The fiber rod is 1.5 mm or 0.060".

stock_width = 3.26;
stock_length = 12.7;
stock_height = 3.35; // rear only - remember that sight must be slanted

// The following two measurements set the slant when used with stock_height.
// front_height = 2.47;
// front_length = 10.54;
// shear = (stock_height - front_height) / front_length;

// We do not repeat the shear of the stock front sight, because it's far
// in excess of the sight line. Instead, we aim the rod (almost) along
// the sight line, so it transmits the most lights to the shooter's eye.
// The top is sheared just a smidge more, so it can't be seen when aiming,
// but not more than that.
shear_rod = 0.015;
shear_top = shear_rod + 0.001;

rod_dia = 1.5 + 0.2;

// The measured pawl_z is 2.78. However, we have to print on a brim,
// and then remove the material with a file. So, we increase pawl_z
// by the thickness of the brim.
pawl_z = 3.0;

// The measured pawl_y is 2.85 in the thinnest part, 2.88 at the widest,
// but these sizes make the the sight wobble a bit. We set it thicker.
pawl_y = 2.9;

module rod_channel () {
    $fn = 9;
    rotate(90, [0, 1, 0])
        cylinder(stock_length+0.2, rod_dia/2, rod_dia/2);
}

module rod_slot (slot_length) {

    // translate([0, (rod_dia*1.3)/2)*-1, 0])
    //     cube([slot_length, rod_dia*1.3, 7]);

    // This version cuts away the sides, in order to collect more light.
    // But it cannot be too long, or the loops become fragile.
    translate([0, ((stock_width+0.2)/2)*-1, 0]) {
        union () {
            cube([slot_length, stock_width+0.2, 7]);
            translate([0, 0, 0]) {
                rotate(-10, [0, 1, 0])
                    cube([2, stock_width+0.2, 7]);
            }
            translate([slot_length, 0, 0]) {
                rotate(10, [0, 1, 0])
                    translate([-2, 0, 0])
                        cube([2, stock_width+0.2, 7]);
            }
        }
    }
}

// We center the whole part on the center of the attachment.
module main_body () {

    difference () {
        // The main body. Everything else attaches to it. Up is up for now.
        intersection () {
            translate([(stock_length/2)*-1, (stock_width/2)*-1, 0])
                cube([stock_length, stock_width, stock_height]);
            translate([(stock_length/2)*-1, (stock_width/2)*-1,
                       (shear_top*stock_length)*-1])
                multmatrix(m = [[        1,   0,   0,   0],
                                [        0,   1,   0,   0],
                                [shear_top,   0,   1,   0],
                                [        0,   0,   0,   1]])
                {
                    cube([stock_length, stock_width, stock_height]);
                }
        }

        // The rod channel.
        translate([(stock_length/2 + 0.1)*-1, 0,
                    stock_height - stock_width/2 + 0.04]) {
            multmatrix(m = [[        1,   0,   0,   0],
                            [        0,   1,   0,   0],
                            [shear_rod,   0,   1,   0],
                            [        0,   0,   0,   1]])
            {
                rod_channel();
            }
        }

        translate([0, 0, 1.2]) {
            multmatrix(m = [[        1,   0,   0,   0],
                            [        0,   1,   0,   0],
                            [shear_rod,   0,   1,   0],
                            [        0,   0,   0,   1]])
            {
                slot_length = stock_length*0.7;
                translate([(slot_length/2 + 0.1)*-1, 0, 0.25])
                    rod_slot(slot_length);
            }
        }

        // Slant the front for pure aesthetics.
        translate([-9.5, 0, 0.8]) {
            rotate(10, [0,1,0])
                translate([0, ((stock_width+0.2)/2)*-1, 0])
                    cube([3, stock_width+0.2, 7]);
        }
    }
}

module latch_pawls () {
    tip_xlen = 0.8;
    tip_ylen = pawl_y;
    // Measured difference is 2.06, but somehow we need less.
    tip_zlen = pawl_z - 1.92;

    pawl_r = 4.25;     // a big bevel, big radius for pawl tips
    pawl_r_sm = 3.8;   // a big bevel, small radius for pawl stems

    difference () {
        intersection () {
            union () {
                translate([(7.63/2)*-1, (tip_ylen/2)*-1, 0])
                    cube([7.63, tip_ylen, pawl_z+0.1]);

                // Pawl tip front
                // (this is currently removed for the ease of installation)
                // translate([(7.63/2 + tip_xlen)*-1, (tip_ylen/2)*-1, 0]) {
                //    cube([tip_xlen + 0.1, tip_ylen, tip_zlen]);
                // }

                // Pawl tip rear
                translate([7.63/2 - 0.1, (tip_ylen/2)*-1, 0]) {
                    cube([tip_xlen + 0.1, tip_ylen, tip_zlen]);
                }
            }

            // Big bevel
            $fn = 36;
            union () {
                translate([0, 0, 0])
                    cylinder(tip_zlen, pawl_r, pawl_r);
                translate([0, 0, tip_zlen])
                    cylinder(pawl_z+0.1, pawl_r_sm, pawl_r_sm);
            }
        }

    }
}

module support_leg () {
    $fn = 6;
    cylinder(pawl_z+0.1, 0.6, 0.6);
}

module whole_part () {
    translate([0, 0, pawl_z]) {
        main_body();
    }

    translate([0, 0, 0]) {
        latch_pawls();
    }

    translate([ 5.3,  1, 0]) support_leg();
    translate([ 5.3, -1, 0]) support_leg();
    translate([-5.3,  1, 0]) support_leg();
    translate([-5.3, -1, 0]) support_leg();
}

whole_part();
