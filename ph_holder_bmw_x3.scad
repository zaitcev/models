//
// A smartphone holder for 2019 BMW X3
//

// The 2019 BMW X3 has a "tablet"-like housing for
// the infotainment screen, which is what we clamp.
// Its bezel has additional thickness that we use.
bmw_x3_2019_depth = 18.0;
bmw_x3_2019_bezel = 16.0;
bmw_x3_2019_angle = 28.0;  // degrees

// initial was 38?
bmw_x3_cluster_to_dash = 48;

clamp_length = 62;
clamp_set_height = 25;

// These dimensions are for LG V20.
phone_width = 75.8;
phone_depth = 8.1;
phone_basket_height = 80; // not the full height of phone

// The thickness of basket's walls.
thickness = 1.5;

// Let's start with a simple basket made out of
// cubes, with some intersections to punch out.
// Then, we add stiffener ribs.

module basket_rib(length, dia) {
    $fn = 12;
    rad = dia/2;

    // This intersection makes a half-cylinder.
    intersection () {
        cylinder(length, rad, rad);
        translate([-1*(rad+0.1), 0, 0])
            cube([(rad+0.1)*2, rad+0.1, length]);
    }
}

// The width, depth, height determine the sizes of the
// pocket for the cellphone, so they are internal
// measurements of the basket.
module basket(width, depth, height) {
    bezel = 4.0;
    conn_width = 15;
    conn_depth = depth + thickness;

    difference() {
        difference() {

            // Main body
            difference() {
                cube([width + 2*thickness,
                      depth + 2*thickness,
                      height + thickness]);
                translate([thickness,
                           thickness,
                           thickness]) {
                    cube([width, depth, height+0.1]);
                }
            }

            // Front panel cutout
            translate([thickness+bezel, -0.1,
                       thickness+bezel]) {
                cube([width - 2*bezel,
                      thickness + 0.2,
                      height + 0.1 - bezel]);
            }
        }

        // Power connector cutout
        translate([thickness + width/2 - conn_width/2,
                   -0.1, -0.1])
            cube([conn_width,
                  conn_depth + 0.1,
                  bezel + 0.2]);
    }

    // We add a rib on top, just to be nice.
    // The basket is stiff enough without it.
    rib_dia = thickness * 3.5;
    translate ([0, depth + thickness*2 - 0.1,
                height + thickness - rib_dia/2]) {
        rotate (90, [0, 1, 0]) {
            // Making it shorter by 1.1 deconflicts it
            // with the clamp.
            basket_rib(width + thickness*2 - 1.1,
                       rib_dia);
        }
    }

    // We add a rib along the bottom in order to
    // complensate the cutout for power connector.
    translate ([0, 0.1, bezel + 2.0]) {
        rotate (90, [0, 1, 0]) {
            rotate (180, [0, 0, 1])
                basket_rib(width + thickness*2, rib_dia);
        }
    }
}

// The rear plate is absurdly complex because it
// has a concave edge. And it only works when tilted
// by the global angle, too.
module clamp_rear_plate(thickness, length) {
    difference () {
        union () {
            // outside edge
            hull () {
                translate ([0, 0, 20])
                    cube([4.0, thickness, length-20]);
                translate ([21, thickness, 51])
                    rotate (90, [1, 0, 0])
                        cylinder(thickness, 12, 12);
                translate ([30.4, thickness, 42.1])
                    rotate (90, [1, 0, 0])
                        cylinder(thickness, 8, 8);
                translate ([13, thickness, 20])
                    rotate (90, [1, 0, 0])
                        cylinder(thickness, 8, 8);
            }
            // bottom edge
            hull () {
                cube([4.0, thickness, length]);
                translate ([11.5, 0, length-15])
                    cube([10, thickness, 10]);
                translate ([12, thickness, 12.7])
                    rotate (90, [1, 0, 0])
                        cylinder(thickness, 8, 8);
                translate ([5.8, thickness, 5.4])
                    rotate (90, [1, 0, 0])
                        cylinder(thickness, 4.5, 4.5);
            }
        }
        // concave cutout
        hull () {
            translate ([50, thickness+0.1, 35])
                rotate (90, [1, 0, 0])
                    cylinder(thickness+0.2, 8, 8);
            translate ([36.2, thickness+0.1, 17.3])
                rotate (90, [1, 0, 0])
                    cylinder(thickness+0.2, 16, 16);
        }
    }
}

// The clamp is translated and rotated separately
// just make the design clearer. The body of he clamp
// extends somewhat beyond the bezel and the rear
// bevel radius.
module clamp_body(depth, bezel, length) {
    thickness = 2.0;  // clamp's "wall" or outline
    clamp_ridge_radius = 3;

    // spine
    cube([thickness, depth + thickness*2, length]);
    // front
    cube([bezel + thickness + clamp_ridge_radius*0.95,
          thickness, length]);
    // back
    translate([0, depth+thickness, 0])
        clamp_rear_plate(thickness, length);

    translate ([thickness + bezel,
                thickness - clamp_ridge_radius*0.5,
                0]) {
        // This intersection makes a half-cylinder.
        intersection () {
            cylinder(length,
                     clamp_ridge_radius,
                     clamp_ridge_radius);
            translate([-1*(clamp_ridge_radius+0.1), 0, 0])
                cube([clamp_ridge_radius*2 + 0.1,
                      clamp_ridge_radius + 0.1,
                      length]);
        }
    }
}

// This module is responsible for taking the clamp_body
// and moving it where it belongs.
module clamp_located(depth, bezel, angle) {
    // We used to translate right (by x) for a derivative
    // of phone_width and sin(angle). It turned out to be
    // a mistake. The actual translation distance is
    // determined by the BMW dash, so the phone is wedged
    // against the instrument cluster.
    translate ([bmw_x3_cluster_to_dash,
                phone_depth + thickness*2 - 0.5,
                clamp_set_height]) {
        rotate (angle, [0, 1, 0])
            clamp_body(depth, bezel, clamp_length);
    }
}

basket(phone_width, phone_depth, phone_basket_height);
clamp_located(bmw_x3_2019_depth, bmw_x3_2019_bezel,
              bmw_x3_2019_angle);
