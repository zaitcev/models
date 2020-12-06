//
// stampholder_picrail.scad
// A stamp holder, for e.g. Tekton, over a Picatinny rail, like on Polymer80
//
// Professional gunmakers use a stamp press in order to make precise
// impressions. But DIY hobbyists and casual makers may not have access
// to such equipment. Extremely dexterous people simply hit stamp with
// a hammer. However, in this case, because any alterations to the number
// plate are a felony, it is impossible to correct mistakes. It is much
// safer to use this tool and a clamp for your next Polymer80 build.
// 

tower_h = 39.0;
claw_x = 17.0;

module the_outer_mold () {

    hull () {

        // The tower for the stamp
        translate([0, 0, tower_h/2])
            cube([11.4, 11.4, tower_h], center=true);

        // Base
        translate([0, 0, 3.5/2])
            cube([claw_x, 23.5, 3.5], center=true);
    }

    // One claw
    translate([0, -11.3, 0])
        rotate(-40, [1,0,0]) {
            cube([claw_x, 5.0, 5.0], center=true);
            translate([0, (9.0/2 - 5.0/2), (5.0/2 + 4.0/2)*-1])
                cube([claw_x, 9.0, 4.0], center=true);
        }

    // Other claw
    translate([0, 11.3, 0])
        rotate(40, [1,0,0]) {
            cube([claw_x, 5.0, 5.0], center=true);
            translate([0, (9.0/2 - 5.0/2)*-1, (5.0/2 + 4.0/2)*-1])
                cube([claw_x, 9.0, 4.0], center=true);
        }

}

module the_holder () {
    difference () {
        the_outer_mold();

        translate([0, 0, tower_h/2])
            cube([6.2, 6.2, tower_h + 0.2], center=true);
    }
}

the_holder();
