// Cover for ForLife infuser

$fn = 110;

// The centering ridge
translate ([0,0,-0.1]) {
    difference () {
        cylinder(3.5, 70/2, 68.3/2);
        translate([0,0,-0.1])
            cylinder(3.5+0.2, 62.0/2, 64/2);
    }
}

// The top surface
translate ([0,0,-1.2]) {
    minkowski () {
        cylinder(0.2, 87/2, 87/2);
        sphere(1.2);
    }
}