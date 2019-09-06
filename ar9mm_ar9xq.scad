//
// AR9XQ: the deluxe experiment with LRBHO
// 

use <ar9mm_adapter.scad>;

// This absurdly complex cut-out hoses the LRBHO element.
module lrbho_cut () {
    rotate(-4.8, [0,1,0]) {
        union () {
            // We use one cylinder to create the axis of rotation.
            // This guarantees the axis to be straight.
            // The cylinder goes all the way through for the ease of design.
            $fn = 10;
            translate([-31.0, 2.0, -4.0])
                rotate(7.0, [0,0,1])
                    rotate(90.0, [0,1,0])
                        cylinder(61.0, 1.2, 1.2);

            // Left side cut
            translate([-25.1, -11.5, -5.5])
                cube([36.0, 4.0, 6.5]);
            // this just removes a tiny ledge above the left side cut
            translate([-25.1, -13.1, -0.5])
                cube([20.0, 3.0, 3.0]);

            // These should probably be some kind of a prism, but cubes
            // are much easier. Front yoke space:
            translate([-25.1, -10.8, -5.5])
                cube([3.5, 15.2, 6.5]);
            // Rear yoke space:
            translate([7.4, -10.0, -5.5])
                cube([3.5, 18.6, 6.5]);

            // The right side cut is not needed for the operation of the
            // hold bracket, but we use it in order to install the part.
            translate([8.0, 7.7, -5.2])
                rotate(7.0, [0,0,1])
                    cube([23.0, 5.0, 2.4]);

            // Rear cut for the "flapper" section of the bracket
            translate([28.0, -5.6, -5.0])
                cube([5.0, 18.0, 6.5]);
        }
    }
}

module main () {
    difference () {
        adapter();
        ejector_cavity();
        lrbho_cut();
    }
}

main();
