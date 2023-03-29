//
// Adapter from 1 1/4 inch male NPT thread to 2 inch slip
//
// Although this design is done for a practical application, its lasting
// value is probably in the roll-our-own extrusion. The built-in linear
// extrusion with a twist looks just a little iffy.

// Number of threads
NT = 5;
// Equivalent of $fn; we usually set it down to 12 for design time.
FN = 36;

// Spanner thickness: easy to change to 0.0001 if we want
SPTH = 0.1;

// These are official values... from the Internet.
// See: https://www.machiningdoctor.com/threadinfo-npt/?tid=4007
P =  2.209;   // Pitch
H =  1.913;   // Height of sharp V
D = 42.164;   // Outside diameter of the pipe

// The change of diameter per one thread. We calculated this.
DD = 0.0625;
// The rebate at the ridge of the thread.
// We made this up, based on existing pipes and available precision.
Fcs = 0.2;

module spanner (base) {
    rotate(90, [1,0,0]) {
        linear_extrude(height=SPTH) {
            polygon([
                [    0,            P/2],
                [ base,            P/2],
                [ base + H - Fcs, (P/2)*(Fcs/H)],
                [ base + H - Fcs, (P/2)*(Fcs/H)*-1],
                [ base + DD/2,    (P/2)*-1],
                [    0,           (P/2)*-1]
            ]);
        }
    }
}

module spanner_i (i) {

    // This can be zero. We just hate singularities.
    hole_r = 10.0;

    translate([0, 0, i*(P/FN)]) {
        rotate(i*(360/FN), [0,0,1]) {
            translate([hole_r, 0, 0])
                spanner((D/2 - H) - hole_r - i*(DD/FN));
        }
    }
}

module mold ()
{

    // Ostensibly 35.02 for the pipe. But we screw into a thread adapter.
    lower_d = 35.5;

    // upper_d = 52.5;   // ostensibly 2.067"
    upper_d = 51.7;

    // Lower stem
    translate([0, 0, 8.4]) {
        cylinder(5.0, r=lower_d/2);
    }

    // This produces a thread, which is somewhat smaller than defined.
    // This is because spanners match the correct size, but the interval
    // between spanners recedes a little, given the segmented approximation.
    // However, with a great anout FN, this effect diminishes in practice.
    for (i = [0 : 1 : FN*NT-1]) {
        hull () {
            spanner_i(i);
            spanner_i(i+1);
        }
    }

    // Upper neck
    translate([0, 0, -5.0]) {
        cylinder(7.0, r=19.0);
    }

    // Upper connector, uses the inside of 2" pipe.
    translate([0, 0, -39.0]) {
        cylinder(35.0, upper_d/2 - 0.3, upper_d/2);
    }
}

module main () {

    // This does not need to match any standard, only let the part
    // to be strong enough. So we make the hole small on purpose.
    inside_d = 31.0;

    difference () {
        mold();

        // Central hole.
        translate([0, 0, -7.0])
            cylinder(30.0, r=inside_d/2);

        // On second thought, let's save the material and print faster.
        translate([0, 0, -39.1])
            cylinder(32.2, 23.0, 22.6);
    }
}

main();
