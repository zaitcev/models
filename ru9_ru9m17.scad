//
// RU9M17
// Ruger PC Carbine, adapter for SIG P320/M17
//

use <ru9_adapter.scad>;

// The magazine cavity on Ruger does not include the top, narrowing part.
// So, we use a simple straight hole, a rotate, and no multmatrix.
module mag_p320 () {
    m_len = 32.8;
    m_w = 22.7;
    m_fr_r = 5.5;
    m_h = 72;  // slanted length, just great enough to pierce the whole design

    hull () {
        translate([m_fr_r, (m_w/2 - m_fr_r), 0])
            cylinder(m_h, m_fr_r, m_fr_r);
        translate([m_fr_r, (m_w/2 - m_fr_r)*-1, 0])
            cylinder(m_h, m_fr_r, m_fr_r);
        translate([m_len - 5.0, (m_w/2)*-1, 0])
            cube([5.0, m_w, m_h]);
    }
}

// The root of the ejector is 1.38 thick, 7.5 wide.
module ejector_cavity () {

    depth = 30.0;  // excessive on purpose - should be called "cut_length"?

    union () {

        translate([29.5, -3.8, 19.5]) {

            rotate(60.0, [0, 1, 0]) {

                // The main pocket is a pocket at 60 degrees, documented
                // in ar9mm_02_ejector.xcf. We center the cube so that it
                // rotates in a predictable way.
                translate([(depth/2)*-1, (1.7/2)*-1, (7.9/2)*-1])
                    cube([depth, 1.7, 7.9]);

                // We also add an inspection hole.
                translate([depth/2, 0, 0])
                    rotate(90, [1, 0, 0])
                        cylinder(20, 3, 3);
            }
        }

    }
}

module adapter () {
    difference () {
        union () {
            top();
            lom();
            // latch();
        }
        translate([13.7, 0, -51.0])
            rotate(-19.0, [0,1,0])
                mag_p320();
        ejector_cavity();
    }
}

module main () {
    adapter();
}

main();
