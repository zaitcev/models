//
// A fixture to support a ball while drilling it.

main_d = 31.0;
center_hole_d = 19.0;

module main () {
    difference () {
        cylinder(20.0, r=(main_d + 2.0), $fn=35);
        translate([0, 0, -0.01])
            cylinder(20.0 + 0.02, r=(main_d - 0), $fn=35);
    }

    translate([0, 0, -10.0]) {
        difference () {
            cylinder(11.0, r=center_hole_d/2, $fn=35);
            translate([0, 0, -0.01])
                cylinder(11.0 + 0.02, r=(center_hole_d/2 - 1.5), $fn=35);
        }
    }

    for (angle = [0 : 120 : 300]) {
        rotate(angle, [0,0,1]) {
            translate([8.0, (4.0/2)*-1, 0])
                cube([(main_d + 0.5) - 8.0, 4.0, 3.0]);
        }
    }
}

main();
