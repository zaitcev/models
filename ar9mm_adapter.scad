//
// Basic adapter
//

well_width = 22.80;
well_length_main = 60.75;   // main body without the bolt-stop rib

upp_len_off = 3.0;          // in front it's less space just because
upp_length = well_length_main - 5.0;

module body_lower ()
{
    corner_r = 2.0;

    union () {
        $fn = 12;
        difference () {
            // Main body
            // Corners must be chamfered, or this does not fit into magwell.
            translate([0, 0, -73]) {
                hull () {
                    translate([(well_length_main/2 - corner_r)*-1,
                               (well_width/2 - corner_r), 0])
                        cylinder(73, corner_r, corner_r);
                    translate([(well_length_main/2 - corner_r)*-1,
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(73, corner_r, corner_r);
                    translate([(well_length_main/2 - corner_r),
                               (well_width/2 - corner_r), 0])
                        cylinder(73, corner_r, corner_r);
                    translate([(well_length_main/2 - corner_r),
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(73, corner_r, corner_r);
                }
            }
            // Magazine latch cutout
            translate([(well_length_main/2 - 10 - 10.0),
                       (well_width/2+0.1)*-1, (17.5+6.5)*-1]) {
                cube([10.0, 3.5, 6.5]);
            }
        }
        // Magazine overtravel stop
        translate([(well_length_main/2 - 10 - 10.0),
                   (well_width/2+1.1)*-1, (17.5+6.5+9.0)*-1]) {
            cube([10.0, 1.1+0.1, 9.0]);
        }
        // Bolt stop spine
        translate([(well_length_main/2 - 0.1), (11.0/2)*-1, -73]) {
            cube([2.0+0.1, 11.0, 73]);
        }
    }
}

module body_upper ()
{

    union () {
        translate([(well_length_main/2 - upp_len_off)*-1,
                   -well_width/2, 0]) {
            cube([upp_length, well_width, 4.3]);
        }

        // This protrusion being separate gives space for receiver rails.
        translate([(well_length_main/2 - upp_len_off)*-1,
                   (well_width/2-1.2)*-1, 4.3]) {
            cube([upp_length, well_width-(1.2*2), 3.8]);
        }
    }
}

difference () {
    union () {
        body_lower();
        body_upper();
    }

    // Cut a large hole inside in order to save the material and print faster
    union () {
        translate([(well_length_main/2 - 5)*-1,
                   (well_width/2 - 3)*-1, (73+0.1)*-1])
            cube([well_length_main - 5*2, well_width - 3*2, 73+0.1]);
        translate([(well_length_main/2 - 5)*-1,
                   (well_width/2 - 4)*-1, 0.1*-1])
            cube([well_length_main - 5*2, well_width - 4*2, 8.1+0.2]);
    }
}
