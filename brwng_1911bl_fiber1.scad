// Browning 1911-22/1911-380 (not "Pro"), the front sight with fiber optics

stock_width = 3.41;
stock_length = 12.7;
stock_height = 3.35; // rear only - remember that sight must be slanted

// The following two measurements set the slant when used with stock_height.
front_height = 2.47;
front_length = 10.54;
shear = (stock_height - front_height) / front_length;

rod_dia = 1.5 + 0.2;

module rod_channel () {
    // translate([0, (1.5/2)*-1, (1.5/2)*-1])
    //     cube([stock_length+0.2, 1.5, 1.5]);
    $fn = 9;
    rotate(90, [0, 1, 0])
        cylinder(stock_length+0.2, rod_dia/2, rod_dia/2);
}

module rod_slot () {
    translate([0, (rod_dia/2)*-1, 0])
        cube([stock_length*0.35, rod_dia, 7]);
}

// We center the whole part on the center of the attachment.
module main_body () {

    difference () {
        // The main body. Everything else attaches to it. Up is up for now.
        translate([(stock_length/2)*-1, (stock_width/2)*-1, 0])
            cube([stock_length, stock_width, stock_height]);

        // The rod cavity.
        // We double-translate this, so that multi-matrix applies to positive
        // values only, thus making it easier to figure out how much to
        // translate up (in z axis).
        translate([(stock_length/2 + 0.1)*-1, 0, 1.2]) {
            multmatrix(m = [[   1,   0,   0,   0],
                            [   0,   1,   0,   0],
                            [shear,  0,   1,   0],
                            [   0,   0,   0,   1]])
            {
                rod_channel();
            }
        }

        translate([0, 0, 1.2]) {
            multmatrix(m = [[   1,   0,   0,   0],
                            [   0,   1,   0,   0],
                            [shear,  0,   1,   0],
                            [   0,   0,   0,   1]])
            {
                // The two central slots
                translate([(stock_length*0.35 + 0.5)*-1, 0, 0])
                    rod_slot();
                translate([0.5, 0, 0])
                    rod_slot();

                // The two left slots
                left_offset = ((stock_width + rod_dia)/2 - 0.3)*-1;
                translate([(stock_length*0.35 + 0.5)*-1, left_offset, 0])
                    rod_slot();
                translate([0.5, left_offset, 0])
                    rod_slot();

                // The two right slots
                right_offset = (stock_width + rod_dia)/2 - 0.3;
                translate([(stock_length*0.35 + 0.5)*-1, right_offset, 0])
                    rod_slot();
                translate([0.5, right_offset, 0])
                    rod_slot();
            }
        }
    }
}

module latch_pawls () {
    // Total X is 8.34 at the ends of the pawls.
    tip_xlen = (8.34-7.53)/2 + 0.2;  // 0.2 for experiments
    tip_ylen = 2.85;

    pawl_r = 4.25;     // a big bevel, big radius for pawl tips
    pawl_r_sm = 3.8;   // a big bevel, small radius for pawl stems
    pawl_z = 2.78;

    difference () {
        intersection () {
            union () {
                translate([(7.53/2)*-1, (tip_ylen/2)*-1, 0])
                    cube([7.53, tip_ylen, pawl_z+0.1]);

                // Pawl tip front
                translate([(7.53/2 + tip_xlen)*-1, (tip_ylen/2)*-1,
                           pawl_z+0.1 - 0.72]) {
                    cube([tip_xlen + 0.1, tip_ylen, 0.72]);
                }
                // Pawl tip rear
                translate([7.53/2 - 0.1, (tip_ylen/2)*-1,
                           pawl_z+0.1 - 0.72]) {
                    cube([tip_xlen + 0.1, tip_ylen, 0.72]);
                }
            }

            // Big bevel
            $fn = 36;
            union () {
                translate([0, 0, pawl_z+0.1 - 0.72])
                    cylinder(pawl_z+0.1, pawl_r, pawl_r);
                cylinder(pawl_z+0.1, pawl_r_sm, pawl_r_sm);
            }
        }

        // Flex cut-out front
        translate([-2.2, ((2.88+0.2)/2)*-1, 0.7])
            cube([1.1, 2.88 + 0.2, 3.0]);
        // Flex cut-out rear
        translate([1.2, ((2.88+0.2)/2)*-1, 0.7])
            cube([1.1, 2.88 + 0.2, 3.0]);
    }
}

module whole_part () {
    translate([0, 0, stock_height]) {
        rotate(180, [1, 0, 0])
            main_body();
    }

    translate([0, 0, stock_height-0.1]) {
        latch_pawls();
    }
}

whole_part();
