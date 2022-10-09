//
// The Chimnea Cover
//
// The 320mm diameter of the cover is too much for most printers.
// We print this in segments, then glue it all together.

top_dia = 10.0;

// The bottom is wide enough to cover the whole mouth of the chimnea.
wide_dia = 320.0;

ring_fn = 24;
ring_dia = 200.0;
tab_dia_bot = ring_dia - 8.0;

// The main height is of the cone itself only, without the locking tabs.
// We could have some formula, like wide_dia*0.1, but let's be simple.
height = 30.0;
tab_h_top = 5.0;
tab_h_bot = 4.0;

// The main body without any subtractions.
module mold () {

    // The main cone.
    translate([0, 0, 2.0])
        cylinder(height - 2.0, wide_dia/2, top_dia/2, $fn=36);

    // Botom plate to avoid a sharp outer edge.
    cylinder(2.0, wide_dia/2, wide_dia/2, $fn=36);

    // Top locking tab.
    cylinder(height + tab_h_top, top_dia/2, top_dia/2, $fn=24);

    // Bottom locking tab is actually a very large ring.
    translate([0, 0, tab_h_bot*-1])
        cylinder(tab_h_bot, tab_dia_bot/2, tab_dia_bot/2, $fn=ring_fn);
}

module main () {

    intersection () {

        difference () {
            mold();

            // This tiny center hole helps to assemble segments.
            translate([0, 0, (tab_h_bot + 0.1)*-1])
                cylinder(height + tab_h_bot + tab_h_top + 0.2, r=2.0, $fn=16);
        }

        translate([0, 0, (tab_h_bot + 0.1)*-1])
            cube([wide_dia/2, wide_dia/2,
                  height + tab_h_bot + tab_h_top + 0.2]);
    }
}

main();
