//
// toto_base_tooth.scad
// For use with washlets such as C200
//
// The original tooth is an aluminum part, but not everyone has
// chunks of aluminum laying around the house. ABS seems to work,
// just make sure to use an 80% fill.

body_h = 5.5;

module main () {

    // The main body
    difference () {

        // The general square outline
        hull () {
            translate([0, 4.6, 0])
                cube([14.8, 6.2, body_h]);
            translate([2.5, 0.0, 0])
                cube([14.0, 9.0, body_h]);
        }

        // The main cut-out with radii
        hull () {
            translate([5.1, 5.5, -0.1])
                cylinder(body_h + 0.2, 1.7, 1.7, $fn=12);
            translate([12.0, 5.5, -0.1])
                cylinder(body_h + 0.2, 1.8, 1.8, $fn=12);

            translate([3.3, 7.0, -0.1])
                cube([10.5, 6.0, body_h + 0.2]);
        }

        // A slight angled cut
        translate([3.3, 7.0, -0.1])
            rotate(10, [0,0,1])
                cube([3, 5, body_h + 0.2]);
    }

    // The tabs
    // We made tabs shorter than original in order to prevent breakage.
    translate([0.0, 6.3, 0])
        cube([1.6, 4.5, body_h + 2.5]);
    translate([4.2, 0.0, 0])
        cube([7.2, 1.6, body_h + 2.5]);
}

main();
