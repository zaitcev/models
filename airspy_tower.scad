//
// airspy_tower.scad
// The tower pedestal for AirSpy
//
// Copyright (c) 2020 Pete Zaitcev

// The main size is the diagonal of the case, or internal diameter of the cup.
dia_int = 45.2;
dia_ext_top = dia_int + 3.0;
dia_ext_bottom = 55.0;

// The device is this high off the base, in order to accomodata USB cables.
height_shelf = 48.0;

cut_height = height_shelf - 12.0;

module design () {
    difference () {
        cylinder(height_shelf+20.0, dia_ext_bottom/2, dia_ext_top/2);

        // This is the cup where the device sit
        translate([0, 0, height_shelf])
            cylinder(20.0+0.1, dia_int/2, dia_int/2);

        // The bottom cut for USB cables and air circulation
        union () {
            translate([0, 0, -0.1])
                cylinder(height_shelf+0.2, (dia_int-1.6)/2, (dia_int-1.6)/2);
            translate([0, 0, 4.0]) {
                intersection () {
                    cylinder(cut_height+0.1,
                             dia_ext_bottom/2 + 0.1, dia_ext_bottom/2 + 0.1);
                    // What we really want here is a sector, but making that
                    // is more trouble than it's worth.
                    union () {
                        cube([dia_ext_bottom/2 + 0.1, dia_ext_bottom/2 + 0.1,
                             cut_height]);
                        rotate(180, [0,0,1])
                            cube([dia_ext_bottom/2 + 0.1,
                                 dia_ext_bottom/2 + 0.1, cut_height]);
                    }
                }
            }
        }
    }
}

design();
