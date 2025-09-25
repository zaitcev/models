//
// The "Pete is" sign
//

side_th = 2.0;
side_w = 152;
side_h = 40;

text_depth = 0.7;

module side_flat_in () {
    difference () {
        cube([side_w, side_h, side_th]);

        text_xoff = 17.0;
        text_yoff = 11.0;
        text_height = 2.5;
        text_dz = side_th - text_depth + 0.01;
        translate([text_xoff, text_yoff, text_dz]) {
            linear_extrude(height=text_depth) text("Pete is IN", size=20);
        }
    }
}

module side_flat_out () {
    difference () {
        cube([side_w, side_h, side_th]);

        text_xoff = 2.0;
        text_yoff = 11.0;
        text_height = 2.5;
        text_dz = side_th - text_depth + 0.01;
        translate([text_xoff, text_yoff, text_dz]) {
            linear_extrude(height=text_depth) text("Pete is OUT", size=20);
        }
    }
}

module assembly () {
    rotate(-60, [1,0,0])
        side_flat_out();
    translate([side_w, 0, 0]) {
        rotate(180, [0,0,1])
            rotate(-60, [1,0,0])
                side_flat_in();
    }
    intersection () {
        rotate(90, [0,1,0])
            cylinder(side_w, r=side_th, $fn=24);
        translate([0, side_th*-1, 0])
            cube([side_w, side_th*2, side_th]);
    }
}

assembly();
