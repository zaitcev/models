// Cover for ForLife infuser
//
// Because tea is brewed with a boiling water, this design must be printed
// from a heat-resistant, food-compatible material. PLA will warp; ABS is
// not food-compatible. We were somewhat successful with PolyMax nee PC-Max.

$fn = 120;

body_dia = 69.8;
brim_dia = 83;

// the cover itself
difference () {
    union () {
        // centering ridge and main body in one cylinder
        cylinder(15.0, (body_dia-1.6)/2, (body_dia+2.0)/2);
        // brim
        translate([0,0, 3.4])
            cylinder(1.7, brim_dia/2, brim_dia/2);
    }
    // scalloping
    // 3.5 body, 1.7 brim by 0.1 into body,
    // total thickness == 5.1
    translate([0,0, 2.0]) {
        cylinder(15.0-1.9,
            ((body_dia-1.6)/2)-1.8, ((body_dia+2.0)/2)-1.8);
    }
}
