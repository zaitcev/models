//
// Glock(r) 42 grip extension "G42K"
//
// For use with ETS 9-round magazines.
//
// Copyright (c) 2019 Pete Zaitcev
//

use <g42k.scad>;

cutout_height = 4.5;

butt_width = f_butt_width();

difference () {
    g42k_base();

    // The main cut-out, a slant cube
    multmatrix(m = [[   1,   0,  -0.215, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {
        translate([-2, ((butt_width * 1.1)/2)*-1, -0.1])
            cube([34.3, butt_width * 1.1, cutout_height+0.1]);
    }

    // Scalloping for forceful removal of the magazine
    translate([0, butt_width/2 - 2.5, 4.5]) {
        rotate(-30, [1,0,0])
            cube([31.2, 5, 6]);
    }
    translate([0, (butt_width/2 + 1.3)*-1, 1.0]) {
        rotate(30, [1,0,0])
            cube([31.2, 5, 6]);
    }
}

// Ouch. When printing from ABS, the large overhang makes the part warp
// and detach from the automacally generated support lattice. We add a
// couple of columns that need to be cut away from the ready part.
translate([-1.5, (butt_width*0.29)*-1, 0])
    cylinder(cutout_height+0.1, 2, 1.5);
translate([-1.5, butt_width*0.29, 0])
    cylinder(cutout_height+0.1, 2, 1.5);
