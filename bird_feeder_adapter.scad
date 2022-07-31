//
// Adapter for a bird feeder to a pipe
//

// The only thing to note about this is that we make $fn low on purpose.
// It helps the print to deform in place. So, print with 15% fill.

// Sasuga chinese designers, the sizes are this round.
feeder_d = 30.0 + 0.5;
feeder_z = 50.0 + 1.0;

roof_th = 3.0;

// Internet says the diameter of a 1/2" lead pipe is 22.17 mm.
// But in reality it's 21.50. Someone's saving on material.
pipe_d1 = 20.9;
pipe_d2 = 22.2;
pipe_z1 = 20.0;
pipe_z2 = feeder_z - roof_th - pipe_z1;

module main () {
    difference () {
        cylinder(feeder_z, r=feeder_d/2, $fn=12);
        translate([0, 0, roof_th])
            cylinder(pipe_z1 + 0.2, pipe_d1/2, pipe_d2/2, $fn=12);
        translate([0, 0, roof_th + pipe_z1 - 0.1])
            cylinder(pipe_z2 + 0.2, r=pipe_d2/2, $fn=12);
    }
}

main();
