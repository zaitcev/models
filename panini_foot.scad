// A foot for a panini press
// The original made from a soft plastic, like a stabilized silicone.
// We roll the ABS just to make the appliance even on the countertop.

base_w = 40;
base_d = 24;
base_h = 3.0;
base_r = 4.0;

roof_d = 11.5;
roof_big_r = 30.0;
roof_big_w = 17.0;
roof_small_r = 6.0;

// Cone is 50% wider than the hole
module hole(dia, height) {
    union () {
        cylinder(height, dia/2, dia/2, $fn=12);
        translate ([0,0, height-(dia/4)]) {
            cylinder(dia/4, dia/2, (dia*1.5)/2, $fn=12);
        }
    }
}

module base () {
    hull () {
        translate([(base_w/2 - base_r)*-1, base_r, 0])
            cylinder(base_h, base_r, base_r);
        translate([(base_w/2 - base_r), base_r, 0])
            cylinder(base_h, base_r, base_r);
        translate([(base_w/2 - base_r)*-1, (base_d-base_r), 0])
            cylinder(base_h, base_r, base_r);
        translate([(base_w/2 - base_r), (base_d-base_r), 0])
            cylinder(base_h, base_r, base_r);
    }
}

module roof () {
    // Large radius segment for the top

    // A segment of thickness 7.0, sitting at the zero plane.
    // But we have to truncate it in the X direction as well.
    intersection () {
        translate([-roof_big_w/2, 0, 0])
            cube([roof_big_w, roof_d, 7.0]);
        translate([0, 0, (roof_big_r - 7.0)*-1])
            rotate(-90, [1,0,0])
                cylinder(roof_d, roof_big_r, roof_big_r, $fn=48);
    }


}

// Base with a hole in it
difference () {
    base();
    translate([0, 17.0, base_h+0.1])
        rotate(180, [0,1,0])
            hole(3.4, base_h + 0.2);
}

hull () {
    translate([0, 0, 6.0])
        roof();
    translate([7.0, 0, 6.0])
        rotate(-90, [1,0,0])
            cylinder(roof_d, roof_small_r, roof_small_r, $fn=20);
    translate([-7.0, 0, 6.0])
        rotate(-90, [1,0,0])
            cylinder(roof_d, roof_small_r, roof_small_r, $fn=20);
    translate([-28.0/2, 0, -0.0])
        cube([28.0, roof_d, 1.0]);
}
