// Mooney M20E anunciator bezel, single light
// Use a black material for this.

// The original has outside corners nicely beveled,
// but we aren't going to bother, because walls are
// too thin for common desktop printers.

body_width = 11.6;
body_length = 43.0;
body_height = 8.2;

wall_thick = 1.20;

glass_width = 9.18;  // with the film folded around
glass_length = 25.0;
glass_thick = 1.7;

screw_dist = 32.8;
screw_dia = 4.3;

use <mooney_anun_common.scad>;

// woops, let's print without a supporting material
rotate (180, [1,0,0]) {

    difference () {
        // Main body
        cube([body_width, body_length, body_height]);

        // Main cavity - 7.6 mm thick
        translate([wall_thick,
                   (body_length-(glass_length+0.5))/2,
                   -0.1]) {
            cube([body_width-(wall_thick*2),
                  glass_length+0.5,
                  body_height-0.5]);
        }

        // Window
        translate([(body_width-(glass_width-2.0))/2,
                   (body_length-(glass_length-2.0))/2,
                   body_height-2.0]){
            cube([glass_width-2.0,
                  glass_length-2.0,
                  2.1]);
        }

        // Side lobes - thicker for screws, 6.8 mm thick
        translate([wall_thick, wall_thick, -0.1]) {
            cube([body_width-(wall_thick*2),
                  body_length-(wall_thick*2),
                  body_height-1.8]);
        }

        // Screw holes
        translate([body_width/2,
                   (body_length-screw_dist)/2,
                   body_height-2.4]) {
            hole(screw_dia, 2.5);
        }
        translate([body_width/2,
                   (body_length-screw_dist)/2 + screw_dist,
                   body_height-2.4]) {
            hole(screw_dia, 2.5);
        }

        // Mysterious cut-outs
        // The location of these cut-outs correspond to
        // the light, so perhaps the idea was to provide
        // cooling. But the bulb is under a thick strip
        // of plexiglass, so it does not work that way.
        translate([-0.1, 23.7,-0.1]) {
            cube([body_width+0.2, 8, 1.4]);
        }
    }
}
