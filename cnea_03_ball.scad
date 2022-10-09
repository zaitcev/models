//
// The Chimnea Cover
//
// The top ball serves as a handle and locks segments together.

top_dia = 10.0;

tab_h_top = 5.0;

module main () {
    difference () {
        sphere(r=15.0);

        translate([0, 0, -15.1])
            cylinder(tab_h_top + 1.0, r=top_dia/2);
    }
}

main();
