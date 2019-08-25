//
// A holder for USB cables when used to charge devices
//

in_width = 16.0;
in_length = 30.0;
in_depth = 0.7;

base_height = in_depth + 1.7;

module holder_base () {
    // The base is open on one short side (with a 1.6 mm extension)
    // in order to admit the tongue of a Command glue strip.
    difference () {
        translate([0, 0, base_height/2])
            cube([in_length+2.0, in_width+2.0, base_height], center=true);
        translate ([1.6/2, 0, in_depth/2 - 0.1])
            cube([in_length + 1.6, in_width, in_depth], center=true);
    }
}

module holder_fixture () {
    fixture_r = 10.0;
    fixture_th = 11.0;
    fixture_ext = 6.0;

    // translate([0, in_width/2, base_height]) {
        union () {

            // The half-cylinder with cutouts
            difference () {
                // The main body half-cylinder
                intersection () {
                    cylinder(fixture_th, fixture_r, fixture_r);
                    translate([0, (fixture_r/2)*-1, fixture_th/2]) {
                        cube([fixture_r*2, fixture_r, fixture_th], center=true);
                    }
                }
                // Cutout for the Mini-B or Micro-B connector
                cylinder(fixture_th - 2.0, fixture_r*0.8, fixture_r*0.8);
                // Cutout for the USB cable
                cable_r = 5.0;
                translate([0, (fixture_r/2)*-1, fixture_th - cable_r/2])
                    cube([cable_r, fixture_r + 0.1, fixture_th], center=true);
            }

            // The little extension border
            difference () {
                translate([fixture_r*-1, 0, 0])
                    cube([fixture_r*2, fixture_ext, fixture_th]);
                // Cutout for the Mini-B or Micro-B connector in the extension
                translate([(fixture_r*0.8)*-1, -0.1, 0])
                    cube([(fixture_r*0.8)*2, fixture_ext + 0.2,
                          fixture_th - 2.0]);
                // Cutout for the USB cable in the extension
                translate([0, fixture_r*0.8 - 0.5, fixture_th - 2.0 - 0.1])
                    cylinder(2.0 + 0.2, fixture_r*0.8, fixture_r*0.8);
            }
        }
    // }
}

module holder () {
    // It's better to print on the side, so flip it.
    translate ([0, 0, (in_width+2.0)/2]) rotate(90, [1,0,0]) {
        union () {
            holder_base();
            translate([0, 1.7, base_height])
                holder_fixture();
        }
    }
}

holder();
