//
// AR9LS: The all-plastic version, including the ejector, SIG P320
//

use <ar9mm_adapsig.scad>;

module ejector_usual () {
    $fn = 16;
    trad_th = 2.5;
    intersection () {
        difference () {
            // The upper outline of the usual ejector
            upper_r = 7.0;
            union () {
                translate([14.0, trad_th, 10.0-upper_r])
                    rotate(90, [1,0,0])
                        cylinder(trad_th, upper_r, upper_r);
                cube([14.0, trad_th, 10.0]);
            }
            // The lower outline cut in the usual ejector
            lower_r = 3.0;
            union () {
                translate([10.0, trad_th + 0.1, 10.0 - 3.7 - lower_r])
                    rotate(90, [1,0,0])
                        cylinder(trad_th + 0.2, lower_r, lower_r);
                translate([-0.1, -0.1, -0.1])
                    cube([10.0 + 0.1, trad_th + 0.2, 10.0 - 3.7 + 0.1]);
            }
        }
        // Clipping cube
        translate([0, -0.1, 3.2])
            cube([22.0, trad_th + 0.2, 6.9]);
    }
}

module ejector_support () {
    $fn = 20;
    intersection () {
        difference () {
            // Outer outline of the support
            translate([-5.0, 4.0, 0.3]) {
                rotate(90, [0,1,0])
                    cylinder(23.0, 8.0, 8.0);
            }

            // Inner outline of the support
            translate([-5.2, 4.3, 2.3]) {
                rotate(90, [0,1,0])
                    cylinder(15.0, 5.5, 4.9);
            }
        }

        // Clipping cube
        translate([-3.0, -4.0, 3.2])
            cube([23.0 + 0.2, 5.1, 5.1]);

        // And another clipping cube, this one is large
        translate([14.0, 0.0, 2.2])
            rotate(32, [0,1,0])
                cube([30.0, 30.0, 30.0], center=true);
    }
}

module ejector () {
    // The ejector raises up from the top of the body by 6.6 mm,
    // or 14.6 mm from the zero plane.
    translate([-2.0, -5.7, 4.8]) {
        union () {
            ejector_usual();
            ejector_support();
        }
    }
}

module main () {
    union () {
        adapter();
        ejector();
    }
}

main();
