//
// Glock(r) 42 grip extension "G42K"
//
// For use with ETS magazines only.
//
// Copyright (c) 2019 Pete Zaitcev
//

// linear_extrude(height=20)

module side_plates(height) {
    // maximum width from side to side
    butt_width = 26;

    side_r = 50;
    front_r = 14;
    back_r = 12;

    intersection () {

        // This multmatrix is for the front strap
        multmatrix(m = [[   1,   0,  -0.27, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            intersection () {
                $fn = 52;
                translate([0, (side_r - butt_width/2)*-1, 0])
                    cylinder(height, side_r, side_r);
                translate([0, side_r - butt_width/2, 0])
                    cylinder(height, side_r, side_r);
                // Front strap slope
                translate([-19, ((butt_width * 1.1)/2)*-1, 0])
                    cube([100, butt_width * 1.1, height]);
            }
        }

        // Additional bevelling for the front strap
        multmatrix(m = [[   1,   0,  -0.23, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            union () {
                translate([-6.5, 0, 0])
                    cylinder(height, front_r, front_r);
                translate([-6.5, ((butt_width * 1.1)/2)*-1, 0])
                    cube([60, butt_width * 1.1, height]);
                translate([-20, ((butt_width * 1.1)/2)*-1, 25.1])
                    cube([60, butt_width * 1.1, height]);
            }
        }

        // The back strap has a complex swell
        multmatrix(m = [[   1,   0,   0.028, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            union () {
                translate([back_r-3.5, 0, 0])
                    cylinder(height, back_r, back_r*0.6);
                translate([(60 - (back_r))*-1, ((butt_width * 1.1)/2)*-1, 0])
                    cube([60, butt_width * 1.1, height]);
            }
        }
    }
}

module mag_cavity(height) {

    front_r = 3.0;
    rear_r = 1.5;

    // The cavity in the gun is only 17.3 mm wide, but ETS magazines
    // are thicker outside of the grip.
    cav_width = 18.2;
    cav_length = 32.0;

    multmatrix(m = [[   1,   0,  -0.205, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {
        hull () {
            // very small circles in the cavity
            $fn = 18;
            translate([front_r, (cav_width/2 - front_r)*-1, 0])
                cylinder(height, front_r, front_r);
            translate([front_r, (cav_width/2 - front_r), 0])
                cylinder(height, front_r, front_r);
            // very small circles in the cavity
            $fn = 12;
            // translate([cav_length-5, -cav_width/2, 0])
            //    cube([5, cav_width, height]);
            translate([cav_length - rear_r, (cav_width/2 - rear_r)*-1, 0])
                cylinder(height, rear_r, rear_r);
            translate([cav_length - rear_r, (cav_width/2 - rear_r), 0])
                cylinder(height, rear_r, rear_r);
        }
    }
}

// We will fix it up later (the front is a little narrower than the back).
module grip_cavity(height) {
    cav_width = 22.0;
    translate([0, (cav_width/2)*-1, 0])
        cube([65, cav_width, height]);

    cut_width = 30;
    translate([49, (cut_width/2)*-1, -6.6]) {
        multmatrix(m = [[  1,    0,  -0.27,  0],
                        [  0,    1,   0,     0],
                        [  0.35, 0,   1,     0],
                        [  0,    0,   0,     1]])
        {
            cube([26, cut_width, 10]);
        }
    }

    // This wall seems too thin to print, so let's cut it.
    mag_cav_width = 18.2;
    translate([45.2, (mag_cav_width/2)*-1, -6.5])
        cube([4, mag_cav_width, 10]);
}

difference () {
    translate([17.5, 0, 0])
        side_plates(35.0+25.0);

    translate([-20, 0, 25.0])
        grip_cavity(35.0+0.1);

    translate([0, 0, -0.1])
        mag_cavity(25.0+0.2);
}
