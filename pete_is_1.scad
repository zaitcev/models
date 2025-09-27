//
// The "Pete is" sign
//

side_th = 3.0;
side_w = 154;
side_h = 40;

wish_w = 2.0;

text_depth = 0.7;

module side_flat_in (w, h, th) {
    difference () {
        cube([w, h, th]);

        text_xoff = 18.0;
        text_yoff = 11.0;
        text_height = 2.5;
        text_dz = th - text_depth + 0.01;
        translate([text_xoff, text_yoff, text_dz]) {
            linear_extrude(height=text_depth) text("Pete is IN", size=20);
        }
    }
}

module side_flat_out (w, h, th) {
    difference () {
        cube([w, h, th]);

        text_xoff = 3.0;
        text_yoff = 11.0;
        text_height = 2.5;
        text_dz = th - text_depth + 0.01;
        translate([text_xoff, text_yoff, text_dz]) {
            linear_extrude(height=text_depth) text("Pete is OUT", size=20);
        }
    }
}

module wishbone () {
    // Side OUT
    rotate(-60, [1,0,0])
        cube([wish_w, side_h, side_th]);
    // Side IN
    translate([wish_w, 0, 0]) {
        rotate(180, [0,0,1])
            rotate(-60, [1,0,0])
                cube([wish_w, side_h, side_th]);
    }
    // Rooftop spine
    intersection () {
        rotate(90, [0,1,0])
            cylinder(wish_w, r=side_th, $fn=24);
        translate([0, side_th*-1, 0])
            cube([wish_w, side_th*2, side_th]);
    }
}

// The toblerone has to be exactly the same as the wishbone.
// It is crying for some sort of factorization. But unfortunately,
// it includes the lettering, which is easier to apply automatically
// at the correct location when a side is still laying flat.
module toblerone () {
    // Side OUT
    rotate(-60, [1,0,0])
        side_flat_out(side_w, side_h, side_th);
    // Side IN
    translate([side_w, 0, 0]) {
        rotate(180, [0,0,1])
            rotate(-60, [1,0,0])
                side_flat_in(side_w, side_h, side_th);
    }
    // Rooftop spine
    intersection () {
        rotate(90, [0,1,0])
            cylinder(side_w, r=side_th, $fn=24);
        translate([0, side_th*-1, 0])
            cube([side_w, side_th*2, side_th]);
    }
}

module assembly () {
    toblerone();

    hull() wishbone();
    translate([side_w - wish_w, 0, 0])
       hull() wishbone();
}

assembly();
