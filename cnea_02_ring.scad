//
// The Chimnea Cover
//
// The bottom ring itself is a trivially simple. It's just a ring.
// It locks the parts together and centers the cover in the chimney of chimnea.

ring_fn = 24;
ring_dia = 200.0;
tab_dia_bot = ring_dia - 8.0;

module main () {

    difference () {
        cylinder(30.0, ring_dia/2, ring_dia/2, $fn=ring_fn);

        translate([0, 0, -0.1])
            cylinder(30.0 + 0.2, tab_dia_bot/2, tab_dia_bot/2, $fn=ring_fn);
    }
}

main();
