//
// Glock(r) 42 grip extension "G42K"
//
// For use with ETS 12-round magazines only.
//
// Copyright (c) 2019 Pete Zaitcev
//

use <g42k.scad>;

// XXX For whatever reason the constants defined in modules are not visible
// when the "use" statement is in effect. Duplicate for now.
mag_cav_width_rear = 19.0;

funnel_height = 8.0;

// This must match the mag_cavity() module precisely.
module sport_cavity (height) {

    front_r = 3.0;

    cav_width_rear = mag_cav_width_rear;
    cav_width_nose = 16.2;
    cav_length = 31.5;  // note that scalloping makes it longer

    translate ([0, 0, height]) mirror ([0, 0, 1]) {
        multmatrix(m = [[   1,   0,   0.23,  0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            hull () {
                // XXX This $fn has no effect for an unknown reason.
                // $fn = 18;
                translate([front_r, (cav_width_nose/2 - front_r)*-1, 0])
                    cylinder(height, front_r, front_r+2.0);
                translate([front_r, (cav_width_nose/2 - front_r), 0])
                    cylinder(height, front_r, front_r+2.0);

                translate([cav_length*0.33,
                           (cav_width_rear/2 - front_r)*-1, 0])
                    cylinder(height, front_r, front_r+2.0);
                translate([cav_length*0.33,
                           (cav_width_rear/2 - front_r), 0])
                    cylinder(height, front_r, front_r+2.0);

                rear_r = 1.0;
                // very small circles in the rear of the cavity
                $fn = 12;
                translate([cav_length - rear_r,
                           (cav_width_rear/2 - rear_r)*-1, 0])
                    cylinder(height, rear_r, rear_r+2.0);
                translate([cav_length - rear_r,
                           (cav_width_rear/2 - rear_r), 0])
                    cylinder(height, rear_r, rear_r+2.0);
            }
        }
    }
}

module sport_body (height) {
    butt_width = 26.6;

    side_r = 50;
    front_r = 13.6;
    back_r = 12.4;

    front_face = 10.3;
    rear_face = 25.8;

    // This mirror thing helps us to match the base exactly. We use the
    // same exact parameters from g42k, then skew with multimatrix.
    // The bottom remains where it was, matching the base. Then we mirror.
    translate ([0, 0, height]) mirror ([0, 0, 1]) {

        intersection () {

            multmatrix(m = [[   1,   0,   0.35,  0],
                            [   0,   1,   0,     0],
                            [   0,   0,   1,     0],
                            [   0,   0,   0,     1]])
            {
                // This translation distance has to have something to do with
                // butt_width and side_r... Maybe cos(side_r) == butt_width/2.
                // But we just hard-code it for now to the same 17.3 value.
                translate ([17.3, 0, 0]) {
                    intersection () {
                        $fn = 52;
                        translate([0, (side_r - butt_width/2)*-1, 0])
                            cylinder(height, side_r, side_r*1.014);
                        translate([0, side_r - butt_width/2, 0])
                            cylinder(height, side_r, side_r*1.014);
                    }
                }
            }

            multmatrix(m = [[   1,   0,  -0.01,  0],
                            [   0,   1,   0,    0],
                            [   0,   0,   1,    0],
                            [   0,   0,   0,    1]])
            {

                // Front strap
                translate([-1.7, ((butt_width * 1.1)/2)*-1, 0])
                    cube([100, butt_width * 1.1, height]);
            }

            multmatrix(m = [[   1,   0,   0.05, 0],
                            [   0,   1,   0,    0],
                            [   0,   0,   1,    0],
                            [   0,   0,   0,    1]])
            {
                union () {
                    $fn = 40;

                    // front bevel of a large radius
                    translate([front_face, 0, 0])
                        cylinder(height, front_r, front_r*1.02);
                    // wide cube
                    translate([front_face - 3, ((butt_width * 1.1)/2)*-1, 0])
                        cube([100, butt_width * 1.1, height]);
                }
            }

            multmatrix(m = [[   1,   0,  -0.25,  0],
                            [   0,   1,   0,    0],
                            [   0,   0,   1,    0],
                            [   0,   0,   0,    1]])
            {
                union () {
                    // back bevel of a large radius
                    translate([rear_face, 0, 0])
                        cylinder(height, back_r, back_r*1.3);
                    // wide cube
                    translate([(rear_face + 3) - 100,
                               ((butt_width * 1.1)/2)*-1, 0])
                        cube([100, butt_width * 1.1, height]);
                }
            }
        }
    }
}

module sport_funnel () {
    difference () {
        sport_body(funnel_height); 
        translate([0, 0, -0.1])
            sport_cavity(funnel_height+0.2);
    }
}

translate([0, 0, funnel_height])
    g42k_base();
sport_funnel();
