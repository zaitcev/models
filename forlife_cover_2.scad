// Cover for ForLife infuser
// Thus design must be printed from a heat-resistant,
// food-compatible material (PLA will warp).

$fn = 110;

body_dia = 69.8;
brim_dia = 83;

// the cover itself
difference () {
    union () {
        // centering ridge and main body in one cylinder
        cylinder(3.5, (body_dia-1.6)/2, body_dia/2);
        // brim
        translate([0,0, 3.4])
            cylinder(1.7, brim_dia/2, brim_dia/2);
        // 3.5 body, 1.7 brim by 0.1 into body,
        // total thickness == 5.1
    }
    // scalloping
    translate([0,0, 2.0])
        cylinder(3.2, ((body_dia-1.6)/2)-1.8, (body_dia/2)-1.8);
}

// the handle
intersection () {
    union () {
        // an exceedingly complicated way to create a ring
        // Warning: consumes too much CPU and RAM
        // translate([0,0, -30]) rotate(90, [1,0,0]) {
        //     minkowski () {
        //         difference () {
        //            $fn = 30;
        //            translate([0,0,-0.2])
        //                cylinder(0.2*2, 49, 49);
        //            translate([0,0,-0.3])
        //               cylinder(0.3*2, 47, 47);
        //        }
        //        sphere(2);
        //     }
        // }

        // simpler handle
        translate([0,0, 16.7])
            resize([35, 7, 10]) sphere(10);

        // the supporting body for the handle
        translate([0,0, -30]) rotate(90, [1,0,0]) {
            $fn = 60;
            translate([0,0,-0.5]) cylinder(0.5*2, 50, 50);
        }

        // anti-bevelling -- we need something flatter...
        // translate([(body_dia/2)-3, 0, 0]) sphere (6.0);
        // translate([-((body_dia/2)-3), 0, 0]) sphere (6.0);
    }

    // clip surface
    union () {
        // body, same as above
        cylinder(3.5, (body_dia-1.6)/2, body_dia/2);
        // brim - but tall enough to include the ring
        translate([0,0, 3.4])
            cylinder(30, brim_dia/2, brim_dia/2);
    }
}
