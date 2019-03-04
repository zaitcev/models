// Key cap for ASUS UX303 (letter "K")
//
// The key is face down.

// The base (top) plate - very thin!

translate([-16.2/2, -14.7/2, -0.70]) {
    difference () {
        cube([16.2, 14.7, 1.70]);
        translate ([0.78, 0.78, 0.71]) {
            cube([16.2-(0.78*2), 14.7-(0.78*2), 1.01]);
        }
    }
}

// inside horn of a clamp
module clamp_inside_horn () {
    hull() {
        translate([0, 0, 1.22])   cube([0.78, 0.75, 0.01]);
        translate([0, -0.22, -0.01]) cube([0.78, 0.75, 0.01]);
    }
}

// outside horn of a clamp
module clamp_outside_horn () {
    hull() {
        translate([0, 0, 1.22])   cube([0.78, 0.75, 0.01]);
        translate([0, 0.22, -0.01]) cube([0.78, 0.75, 0.01]);
    }
}

translate([1.92,         3.78, 0]) clamp_inside_horn();
translate([-(1.92+0.78), 3.78, 0]) clamp_inside_horn();

translate([1.92,         5.44, 0]) clamp_outside_horn();
translate([-(1.92+0.78), 5.44, 0]) clamp_outside_horn();

module sliding_rail () {
    union () {
        translate([0, 1.92-1.30, 0.91]) {
            cube([1.34, 1.30, 0.61]);
        }
        translate([0, 0, -0.01]) {
            cube([0.65, 1.92, 1.52]);
        }
    }
}

translate([-5.88, -5.56, 0]) sliding_rail();
translate([5.88, -5.56, 0]) {
    mirror([1,0,0]) sliding_rail();
}