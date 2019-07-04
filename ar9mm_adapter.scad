//
// Basic adapter
//

well_width = 22.80;
well_length_main = 60.75;   // main body without the bolt-stop rib

upp_len_off = 3.0;          // in front it's less space just because
upp_length = well_length_main - 5.0;

module body_lower ()
{
    rotate(180, [0, 1, 0]) {
        union () {
            difference () {
                // Main body
                translate([-well_length_main/2, -well_width/2, 0])
                    cube([well_length_main, well_width, 73]);
                // Magazine latch cutout
                translate([(well_length_main/2 - 10)*-1,
                           (well_width/2+0.1)*-1, 17.5]) {
                    cube([10.0, 3.5, 6.5]);
                }
            }
            // Magazine overtravel stop
            translate([(well_length_main/2 - 10)*-1,
                       (well_width/2+1.1)*-1, 17.5+6.5]) {
                cube([10.0, 1.1+0.1, 9.0]);
            }
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
