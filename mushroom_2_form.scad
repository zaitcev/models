//
// We are aiming for the shape of a porchini or king mushroom.
//

module cap (cap_width, outside_scale_correction=0.0) {

    cap_r = cap_width/2;

    top_scale = 0.60 * (1.0 + outside_scale_correction);
    bottom_scale = 0.1 * (1.0 + outside_scale_correction);

    // Most of the shape is the upper half.
    intersection () {
        height = cap_r*top_scale;
        translate([0, 0, -0.01])
            cylinder(height + 0.01, r=cap_r+5.0);
        scale([1.0, 1.0, top_scale])
            sphere(r=cap_r, $fn=48.0);
    }

    // We also have a very thin lower part, to make things rounded.
    intersection () {
        height = cap_r*bottom_scale;
        translate([0, 0, height*-1])
            cylinder(height + 0.01, r=cap_r+5.0);
        scale([1.0, 1.0, bottom_scale])
            sphere(r=cap_r, $fn=48.0);
    }
}

module stem (height, girdth) {

    main_r = girdth/2;

    // The sphere (egg) and the cone intersect more or less smoothly.
    bot_h = height * 0.375;
    cone_z = height * 0.250;

    // The most of the height is a somewhat fat cone.
    translate([0, 0, cone_z])
        cylinder(height - bot_h, main_r, main_r*0.85, $fn=48.0);

    intersection () {
        cylinder(bot_h + 0.01, r=22.0);

        translate([0, 0, cone_z])
            scale([1.0, 1.0, 2.0])
                sphere(r=main_r, $fn=48.0);
    }
}

// This is the desired mushroom.
module shroom (girdth, cap_width) {
    translate([0, 0, -0.01])   // remove 0-thick plane at the bottom
        stem(80.0, girdth);
    translate([0, 0, 70.0])
        cap(cap_width);
}

module outside (girdth, cap_width) {

    translate([0, 0, 69.0])
        cap(cap_width + 4.0, outside_scale_correction=0.05);
    stem(80.0, girdth + 4.0);

    // The cylinder on top for zip-ties.
    translate([0, 0, 92.0]) {
        difference () {
            cylinder(14.0, r=21.5);
            translate([0, 0, -0.01])
                cylinder(14.0+0.02, r=(21.5-4.0));
        }
    }

    // And we add another section like that.
    translate([0, 0, 22.0])
        cylinder(3.0, r=girdth/2+4.0);
    translate([0, 0, 14.0])
        cylinder(3.0, r=girdth/2+4.0);
}

// We take the desired form of the shroom and invert it to make the form.
module form () {

    girdth = 40.0;             // remember that this is the one inside
    cap_width = 100.0;

    difference () {
        // Ideally the Minkowski could create an indeal form for us.
        // But in practice it has bugs that preclude rendering.
        // minkowski() {
        //     shroom();
        //     sphere(r=1.6);
        // }
        outside(girdth, cap_width);

        shroom(girdth, cap_width);
    }
}

module half () {

    rotate(65.0, [0,1,0]) {

        intersection () {
            form();

            // // This is half.
            // translate([0, (200.0/2)*-1, 0.01])
            //    cube([200.0, 200.0, 200.0]);

            // This is quarter.
            rotate(-45.0, [0,0,1])
                cube([200.0, 200.0, 200.0]);
        }
    }
}

half();
