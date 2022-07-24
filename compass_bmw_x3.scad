//
// A compass base for 2019 BMW X3
//

// It's not possible to locate a compass on the dash because of the
// interference with car systems. The only good place is on the door.

z_base = 9.0;
r_base = 49.4/2;

module main () {
    hull () {
        // Outboard corners
        translate([3.0, 40.0, 0])
            cylinder(z_base, r=3.0, $fn=12);
        translate([20.0-3.0, 40.0, 0])
            cylinder(z_base, r=3.0, $fn=12);

        // Inboard - we just use one cylinder.
        translate([20.0-5.0, 5.0, 0])
            cylinder(z_base, r=5.0, $fn=12);
    }

    // The platform - fortunately it's simply round.
    translate([-2.0, 43.0 - r_base, z_base - 0.1])
        cylinder(2.5, r=r_base, $fn=24);
}

main();
