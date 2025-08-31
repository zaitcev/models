//
// Locking flap
//

body_yw = 80.8;
body_xw = 28.2;
body_corner_r = 5.2;
body_base_th = 2.94;

upr_axis_zh = 9.1;
upr_r = 2.1;

stf_th = 2.4;
stf_zth = 4.0;   // Measures 4.06, but one layer is 0.2 mm.

flap_yw = 10.1;
flap_yoff = 27.8;

module flap_body () {

    // The bottom
    hull () {
        translate([0, (body_yw/2)*-1, 0])
            cube([1.0, body_yw, body_base_th]);
        translate([body_xw-body_corner_r, (body_yw/2-body_corner_r)*-1, 0])
            cylinder(body_base_th, r=body_corner_r);
        translate([body_xw-body_corner_r, body_yw/2-body_corner_r, 0])
            cylinder(body_base_th, r=body_corner_r);
    }

    difference () {
        union () {
            // The upright
            hull () {
                translate([0, (body_yw/2)*-1, 0])
                    cube([upr_r*2, body_yw, 1.0]);
                translate([upr_r, (body_yw/2)*-1, upr_axis_zh])
                    rotate(-90.0, [1,0,0])
                        cylinder(body_yw, r=upr_r, $fn=20);
            }
            // The axis
            translate([upr_r, ((body_yw+2.0)/2)*-1, upr_axis_zh])
                rotate(-90.0, [1,0,0])
                    cylinder((body_yw+2.0), r=1.0, $fn=20);
       }

       translate([2.0, ((body_yw-2*stf_th)/2)*-1, 0])
            cube([upr_r*2, body_yw-2*stf_th, upr_axis_zh+upr_r]);
    }

    // Side stiffeners
    // These also regulate the contact when the flap is closed.
    translate([0, (body_yw/2)*-1, 0])
        cube([body_xw-body_corner_r, stf_th, stf_zth]);
    translate([0, body_yw/2 - stf_th, 0])
        cube([body_xw-body_corner_r, stf_th, stf_zth]);
}

module flap_pawl () {
    translate([0, (flap_yw/2)*-1, 0]) {
        hull () {
            translate([-2.1, 0, 0])
               cube([2.1, flap_yw, 0.1]);
            translate([-2.1, 0, 5.2])
               cube([2.1, flap_yw, 0.1]);
            translate([-0.8, 0, 6.6])
               cube([0.8, flap_yw, 0.1]);
        }
    }
}

module flap_pawls () {
    translate([19.4, flap_yoff*-1, 0])
        flap_pawl();
    translate([19.4, flap_yoff, 0])
        flap_pawl();
}

module flap () {
    flap_body();
    flap_pawls();
}

flap();
