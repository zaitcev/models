//
// We are aiming for the shape of a porchini or king mushroom.
//

module cap () {

    // Most of the shape is the upper half.
    intersection () {
        translate([0, 0, -0.01])
            cylinder(50.0, r=55.0);
        scale([1.0, 1.0, 0.60])
            sphere(r=50.0, $fn=48.0);
    }

    // We also have a very thin lower part, to make things rounded.
    intersection () {
        translate([0, 0, 30.0*-1])
            cylinder(30.0, r=55.0);
        scale([1.0, 1.0, 0.1])
            sphere(r=50.0, $fn=48.0);
    }
}

module stem () {

    // The most of the height is a somewhat fat cone.
    translate([0, 0, 20.0])
        cylinder(50.0, 20.0, 17.0, $fn=48.0);

    intersection () {
        cylinder(30.01, r=22.0);

        translate([0, 0, 20.0])
            scale([1.0, 1.0, 2.0])
                sphere(r=20.0, $fn=48.0);
    }
}

// This is the desired mushroom.
module shroom () {
    translate([0, 0, -0.01])   // remove 0-thick plane at the bottom
        stem();
    translate([0, 0, 70.0])
        cap();
}

// We take the desired form of the shroom and invert it to make the form.
module form () {
    difference () {
        // Ideally the Minkowski could create an indeal form for us.
        // But in practice it has bugs that preclude rendering.
        // minkowski() {
        //     shroom();
        //     sphere(r=1.6);
        // }
        union () {
            translate([0, 0, 63.0])
                cylinder(10.0, r=40.0);
            translate([0, 0, 65.0])
                cylinder(4.0, r=50.0);

            translate([0, 0, 68.0]) {
                intersection () {
                    translate([0, 0, -0.01])
                        cylinder(50.0, r=55.0);
                    scale([1.0, 1.0, 0.64])
                        sphere(r=52.0, $fn=48.0);
                }
            }

            translate([0, 0, 0])
                cylinder(104.0, r=21.5);
        }

        shroom();
    }
}

module half () {
    intersection () {
        form();
        translate([0, (200.0/2)*-1, 0.01])
            cube([200.0, 200.0, 200.0]);
    }
}

half();
