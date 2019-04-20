//
// Glock(r) 42 grip extension "G42K"
//
// For use with ETS magazines only.
//
// Copyright (c) 2019 Pete Zaitcev
//

// This version is intended for priting from ABS.

// maximum width from side to side
// We had 26.0 on No.2, which was too tight. The 26.6 is a scootch too
// wide, but we need that space for a 3M 144 glue strip.
function f_butt_width() = 26.6;

module main_body(height, base_height) {

    butt_width = f_butt_width();

    side_r = 50;
    front_r = 13.6;
    back_r = 12.4;

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
        multmatrix(m = [[   1,   0,  -0.204, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            union () {
                $fn = 40;
                translate([-6.9, 0, 0])
                    cylinder(base_height-1.0, front_r, front_r*1.08);
                // small edge bevelling cone
                translate([-6.9, 0, base_height-1.0])
                    cylinder(3, front_r*1.08, front_r*0.98);
                translate([-15.0, ((butt_width * 1.1)/2)*-1, 0])
                    cube([60, butt_width * 1.1, height]);
                translate([-20, ((butt_width * 1.1)/2)*-1, base_height+0.1])
                    cube([60, butt_width * 1.1, (height-base_height)+0.1] );
            }
        }

        // The back strap has a complex swell. We implement it using a typical
        // half-cylinder, through a union of a giant cube and a cylinder.
        multmatrix(m = [[   1,   0,   0.028, 0],
                        [   0,   1,   0,     0],
                        [   0,   0,   1,     0],
                        [   0,   0,   0,     1]])
        {
            union () {
                translate([back_r-3.9, 0, 0])
                    cylinder(height, back_r, back_r*0.6);
                translate([(60 - (back_r))*-1, ((butt_width * 1.1)/2)*-1, 0])
                    cube([60, butt_width * 1.1, height]);
            }
        }

        // The top cut is based on rotated cubes. We use a multmatrix for
        // most of the body, instead of rotation, but then we want two square
        // angle cuts at the top, for the magazine release. However,
        // that is not all. First issue, magazine latch cutouts are different
        // on left and right. Second issue, when glue strips are too thick,
        // side panels stick out and one can feel them with the hand.
        // We really should use some kind of cylinder for them, but for now
        // several 45 degree cubes do the job.
        translate([-21, butt_width*-1, -11.6]) {
            rotate(-14.5, [0, 1, 0]) {
                difference () {
                    // main top cut as a container cube
                    cube([60, butt_width*2, (height + 4.5) / cos(14)]);

                    // 45-degree bevel for the top
                    translate([9.7, -0.1, height + 10.0])
                        rotate(45, [0, 1, 0])
                            cube([10, butt_width*2+0.2, 10]);

                    // magazine latch right side
                    translate([-0.1, butt_width-0.1, height + 2.0])
                        cube([19.2, butt_width*2, 10]);

                    // 45-degree bevel for right side
                    translate([-1, butt_width-0.1, height + 4])
                        rotate(45, [0, 1, 0])
                            cube([10, butt_width*2, 10]);

                    // magazine latch left side
                    translate([-0.1, butt_width*-1, height + 3.0])
                        cube([19.2, butt_width*2, 10]);

                    // 45-degree bevel for left side
                    translate([-1, butt_width*-1, height + 5])
                        rotate(45, [0, 1, 0])
                            cube([10, butt_width*2, 10]);
                }
            }
        }
    }
}

// The magazine opening is a little tricky. The angle of the magazine and
// the angle of the grip on Glock 42 differ, so the front strap gets quite
// thin at the bottom. In addition, ETS magazines are thicker outside of the
// factory grip than the magazine well is (the well is only 17.3 mm wide).
// Finally, thanks to the reality of 3D printing, the printed well comes out
// narrower than the model. The actual magazine is 17.7 mm thick in the rear,
// but we need more. Fortunately, it narrows towards the nose.

function f_mag_cav_width_rear() = 19.0;

module mag_cavity(height) {

    front_r = 3.0;

    cav_width_rear = f_mag_cav_width_rear();
    cav_width_nose = 16.2;
    cav_length = 31.5;  // note that scalloping makes it longer

    multmatrix(m = [[   1,   0,  -0.215, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {
        union () {
            hull () {
                // XXX This $fn has no effect for an unknown reason.
                // $fn = 18;
                translate([front_r, (cav_width_nose/2 - front_r)*-1, 0])
                    cylinder(height, front_r, front_r);
                translate([front_r, (cav_width_nose/2 - front_r), 0])
                    cylinder(height, front_r, front_r);

                translate([cav_length*0.33,
                           (cav_width_rear/2 - front_r)*-1, 0])
                    cylinder(height, front_r, front_r);
                translate([cav_length*0.33,
                           (cav_width_rear/2 - front_r), 0])
                    cylinder(height, front_r, front_r);

                rear_r = 1.0;
                // very small circles in the rear of the cavity
                $fn = 12;
                translate([cav_length - rear_r,
                           (cav_width_rear/2 - rear_r)*-1, 0])
                    cylinder(height, rear_r, rear_r);
                translate([cav_length - rear_r,
                           (cav_width_rear/2 - rear_r), 0])
                    cylinder(height, rear_r, rear_r);

                // This is simple but somehow the shape of the hull changes.
                // translate([cav_length - 10, (cav_width_rear/2)*-1, 0])
                //     cube([10, cav_width_rear, height]);
            }

            // This little scalloping in the rear reduces friction.
            translate([1.0, ((cav_width_rear*0.7)/2)*-1, 0])
                cube([cav_length, cav_width_rear*0.7, height]);
        }
    }
}

// We will fix it up later (the front is a little narrower than the back).
module grip_cavity(height) {

    cav_width_rear = f_mag_cav_width_rear();
    cav_width = 22.6;

    // This multmatrix is for the front strap
    multmatrix(m = [[   1,   0,  -0.27, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {
        translate([0, (cav_width/2)*-1, 0])
            cube([65, cav_width, height]);
    }

    // Scalloping for the glue strip.
    translate([20, ((cav_width+0.9)/2)*-1, 15]) {
        rotate(-14.7, [0, 1, 0])
            cube([14, (cav_width+0.9), height]);
    }

    // Note that the grip cavity has a little extension down, negative by Y,
    // which forms the base of the butt plug. But wait, there's more! The wall
    // between this cut and the magazine well is too thin to pring, so we add
    // another extension to the cut that removes the wall.
    cut_width = 30;
    // No.1 used -6.6 depth. For No.2 we went to -5.5.
    translate([49.0, (cut_width/2)*-1, -5.8]) {
        multmatrix(m = [[  1,    0,  -0.27,  0],
                        [  0,    1,   0,     0],
                        [  0.35, 0,   1,     0],
                        [  0,    0,   0,     1]])
        {
            // main cut
            cube([26, cut_width, 10]);
            // wall cut
            translate([-4, (cut_width - cav_width_rear)/2, 0])
                cube([4+0.1, cav_width_rear, 10]);
        }
    }
}

// XXX Change the solid plug to C-shape.
module butt_plug () {
    $fn = 40;

    plug_r = 8.5;

    // N.B. This height is more than it sticks out from any point on the
    // plane where it sits. But we do not make it grow from the zero plane
    // because we don't want it to intrude into the magazine cavity.
    plug_height = 14;

    // This is the thickness of the plug's plane segment.
    plug_thickness = 6.5;

    intersection () {
        translate([0, plug_r*-1, 0])
            cube([plug_thickness+0.1, plug_r*2, plug_height]);
        translate([plug_thickness-plug_r, 0, 0])
            cylinder(plug_height, plug_r, plug_r);
    }
}

module g42k_base() {
    // there's an implicit union here

    difference () {

        // Note that the main body is heavily clipped on the top, so the actual
        // height is probably smaller. It's just the size that makes sure the
        // cavity is big enough to reach the top always.
        top_height = 44.0;

        base_height = 25.0;

        translate([17.3, 0, 0])
            main_body(top_height+base_height, base_height);

        translate([-20.2, 0, base_height])
            grip_cavity(top_height+0.1);

        // The front of the magazine well is the datum axis.
        translate([0, 0, -0.1])
            mag_cavity(base_height+0.2);
    }

    translate([30.0, 0, 17])
        rotate(-12, [0, 1, 0])
            butt_plug();
}
