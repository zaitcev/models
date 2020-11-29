//
// kr_defl_insert.scad
// The insert for a deflector for a Kuhn-Rikon pressure cooker
//
// Even the original factory parts had a limited lifetime, but the
// replacements of 2018 and later break after a very short time.
// This print isn't going to be amazingly durable either,  but at
// least it's not $18+shipping+tax. And it may actually be better
// than the garbage-level official replacements.
//
// Because a super-heated steam (> 100 C) exits the pressure cooker,
// it is paramount to use a heat-resistant material. ABS is the
// very minimum that you might want to use.
//

$fn = 56;

main_height = 14.0;
inside_dia = 25.0;   // Diameter of the main hole in the center
flange_dia = 34.0;   // Diameter of the base that faces the deflector
petal_width = 9.6;

module outer_mold () {
    // The main cylinder, which forms the petals.
    cylinder(main_height, (inside_dia + 3)/2, (inside_dia + 5)/2);

    // Base of the flange
    translate([0, 0, 12.0])
       cylinder(2.0, flange_dia/2, flange_dia/2);
    // Slope of the flange
    translate([0, 0, 7.0])
       cylinder(5.0, (inside_dia + 3)/2, flange_dia/2);

    // Attachment studs
    // Of the 8 holes in the deflector, 4 are smaller and 4 are larger.
    // However they all appear to be at the same distance from the center
    // and the pegs of the factory part seems to be the same.
    for (phi = [0 : 45 : 360]) {
        rotate(phi, [0,0,1])
            translate([inside_dia/2 + 2.2, 0, main_height])
                cylinder(1.0, 1.4, 1.4, $fn=12);
    }
}

module petal_cut () {

    // We use the same 3 petals as the factory part. Some of the steam
    // outlets get between petals and/or are overlapped by them.
    // Nothing can be done about it, except leaving large gaps.

    for (phi = [0 : 120 : 360]) {
        rotate(phi, [0,0,1]) {
            // We have 2 cut cubes that make sides of petal parallel.

            cut_cube_y = 10;
            cut_cube_z = 8;

            translate([0, petal_width/2, -0.1])
                cube([14, cut_cube_y, cut_cube_z + 0.1]);
            translate([0, (cut_cube_y + petal_width/2)*-1, -0.1])
                cube([14, cut_cube_y, cut_cube_z + 0.1]);
        }
    }
}

// The center hole is an exact cylinder, but we also use it in order
// to form the ridges that get into a groove on the body of the valve.
module center_hole () {

    translate([0, 0, 2.5-0.1])
        cylinder(main_height+0.2-2.5, inside_dia/2, inside_dia/2);

    translate([0, 0, 0])
        cylinder(2.5, (inside_dia-4.0)/2, inside_dia/2);

    translate([0, 0, -0.1])
        cylinder(2.5+0.1, (inside_dia+1.2)/2, (inside_dia-2.0)/2);
}

module the_insert () {
    difference () {
        outer_mold();

        center_hole();

        // Gaps between petals
        petal_cut();
    }
}

the_insert();
