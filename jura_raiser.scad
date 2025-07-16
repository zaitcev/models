//
// This is a trivial thing for now, not even worth putting into repository.
// But we do it anyway, mostly out of habit.
//

riser_l = 21.0;    // X - inside size
riser_w = 17.0;    // Y - inside size
riser_h = 40.0;    // Z - very tall

// We make the indent just deep enough that the machine rests on the feet,
// not on the surrounding plastic. This isolates vibrations at least somewhat.
// Also, we don't know if the plastic around feet is level or strong enough.
riser_depth =  1.5;

module riser () {
    top_w = riser_w + 4.0;      // Make borders
    top_l = riser_l + 4.0;
    bottom_w = top_w + 10.0;    // Make the pyramid
    bottom_l = top_l + 10.0;

    difference () {
        // The outside pyramid
        hull () {
            translate([(bottom_l - top_l)/2, (top_w/2)*-1, 0])
                cube([top_l, top_w, riser_h]);
            translate([0, (bottom_w/2)*-1, 0])
                cube([bottom_l, bottom_w, 1.0]);
        }
        // The indentation
        translate([(bottom_l - top_l + 4.0)/2, (riser_w/2)*-1,
                    riser_h - riser_depth]) {
            cube([riser_l, riser_w, riser_h + 0.01]);
        }
    }
}

riser();
