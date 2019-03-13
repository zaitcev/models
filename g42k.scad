//
// Glock(r) 42 grip extension "G42K"
//
// For use with ETS magazines only.
//
// Copyright (c) 2019 Pete Zaitcev
//

// linear_extrude(height=20)

module mag_cavity(height) {
    // very small circles in the cavity
    $fn = 18;

    front_r = 3.0;

    // The cavity in the gun is only 17.3 mm wide, but ETS magazines
    // are thicker outside of the grip.
    cav_width = 18.2;
    cav_length = 32.0;

    hull () {
        translate([front_r, (cav_width/2 - front_r)*-1, 0])
            cylinder(height, front_r, front_r);
        translate([front_r, (cav_width/2 - front_r), 0])
            cylinder(height, front_r, front_r);
        translate([cav_length-5, -cav_width/2, 0])
            cube([5, cav_width, height]);
    }
}

// This is just a big cube for now, which intrudes into front and back
// straps, where we don't have any material, so its shape is immaterial.
// We will fix it up later (the front is a little narrower than the back).
module grip_cavity(height) {
    cav_width = 22.0;
    translate([0, (cav_width/2)*-1, 0])
        cube([60, cav_width, height]);
}

translate([-19, 0, 25.0])
    grip_cavity(35.0);
multmatrix(m = [[   1,   0,  -0.205, 0],
                [   0,   1,   0,     0],
                [   0,   0,   1,     0],
                [   0,   0,   0,     1]])
{
    translate([0, 0, -0.1])
        mag_cavity(25.0+0.2);
}
