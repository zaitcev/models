//
// Adapter for a garden solar globe light
//

module arm () {
    // The arm
    hull () {
        translate([0, 0, 9.0])
            cylinder(17.0, r=8.0/2);
        translate([27.5, 0, 28.0])
            cylinder(6.0, r=8.0/2);
    }
    // Square peg
    translate([27.5 - (5.2/2) + 0.01, (5.2/2)*-1, 28.0+6.0-0.01])
        cube([5.2, 5.2, 9.1]);
}

module arms () {
    for (i = [0 : 3]) {
        rotate(i*90.0, [0,0,1])
            arm();
    }
}

module adapter ()
{
    difference () {
        union () {
            cylinder(29.0, r=12.4/2, $fn=24);
            arms();
        }

        // Tall enough to pierce the arm.
        translate([0, 0, -0.01])
            cylinder(29.0+0.02, r=8.2/2, $fn=12);
    }
}

adapter();
