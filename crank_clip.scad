//
// Crank Clip
//

base_w = 14.0;
base_h =  4.0;
base_len = 66.0;  // center-to-center, not total length

arm_thick = 5.0;
arm_pitch = 49.0;
arm_ctr_z = 15.0;
arm_od = 19.0;

module clip_arm () {

    difference () {
        // clip_arm_mold()
        union () {
            translate([(arm_thick/2)*-1, 0, arm_ctr_z])
                rotate(90.0, [0,1,0])
                    cylinder(arm_thick, r=arm_od/2, $fn=20);
            translate([(arm_thick/2)*-1, (12.0/2)*-1, -0.01])
                cube([arm_thick, 12.0, arm_ctr_z + 0.01]);
        }

        // The large gam through which the crank is jammed
        translate([((arm_thick + 0.02)/2)*-1, (11.5/2)*-1, arm_ctr_z])
            cube([arm_thick + 0.02, 11.5, arm_od/2 + 0.01]);
        // The round part in which the crank rests
        translate([0, 0, arm_ctr_z])
            rotate(90.0, [0,1,0])
                translate([0, 0, ((arm_thick + 0.02)/2)*-1])
                    cylinder(arm_thick + 0.02, r=12.5/2, $fn=20);
        // The extra slip for flexibility
        translate([((arm_thick + 0.02)/2)*-1, (5.5/2)*-1, 4.0])
            cube([arm_thick + 0.02, 5.5, arm_od/2 + 0.01]);
    }
}

module clip_mold () {

    // The base
    hull () {
        cylinder(base_h, r=base_w/2);
        translate([base_len, 0, 0])
            cylinder(base_h, r=base_w/2);
    }

    // The arms
    translate([(base_len - arm_pitch)/2, 0, base_h])
        clip_arm();
    translate([base_len - (base_len - arm_pitch)/2, 0, base_h])
        clip_arm();
}

module hole () {
    translate([0, 0, -0.01])
        cylinder(base_h + 0.02, r=4.0/2, $fn=12);
}

module clip () {

    difference () {
        clip_mold();

        hole();
        translate([base_len, 0, 0])
            hole();
    }
}

clip();
