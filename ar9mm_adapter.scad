//
// Basic adapter for PPQ
//

well_width = 22.60;
well_length = 60.75;        // main body without the bolt-stop rib

upp_len_off = 0.5;          // in front it's less space just because
upp_length = well_length - 1.5;

module body_lower ()
{
    corner_r = 2.0;
    lower_h = 74.0;

    union () {
        $fn = 12;
        difference () {
            // Main body
            // Corners must be chamfered, or this does not fit into magwell.
            translate([0, 0, lower_h*-1]) {
                hull () {
                    translate([(well_length/2 - corner_r)*-1,
                               (well_width/2 - corner_r), 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r)*-1,
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r),
                               (well_width/2 - corner_r), 0])
                        cylinder(lower_h, corner_r, corner_r);
                    translate([(well_length/2 - corner_r),
                               (well_width/2 - corner_r)*-1, 0])
                        cylinder(lower_h, corner_r, corner_r);
                }
            }
            // AR magazine latch cutout
            translate([(well_length/2 - 10 - 10.0),
                       (well_width/2+0.1)*-1, (17.5+6.5)*-1]) {
                cube([10.0, 2.5, 6.5]);
            }
        }
        // AR magazine overtravel stop
        translate([(well_length/2 - 10 - 10.0),
                   (well_width/2+1.1)*-1, (17.5+6.5+9.0)*-1]) {
            cube([10.0, 1.1+0.1, 9.0]);
        }
        // Bolt stop spine
        translate([(well_length/2 - 0.1), (11.0/2)*-1, lower_h*-1]) {
            cube([2.0+0.1, 11.0, lower_h]);
        }

        // The lower belt
        // This is necessary to keep front and rear together.
        translate([(well_length/2)*-1, (well_width/2 + 2.0)*-1, lower_h*-1]) {
            cube([well_length + 3.0, well_width + 2*2.0, 8.0]);
        }
    }
}

module body_upper ()
{

    difference () {

        union () {
            // The top part being narrower gives space for receiver rails.
            translate([(well_length/2 - upp_len_off)*-1,
                       (well_width/2-1.2)*-1, 0]) {
                cube([upp_length, well_width-(1.2*2), 8.1]);
            }
        }

        // Channel for the bottom of the bolt
        translate([((well_length/2 - upp_len_off) + 0.1)*-1, -6.0/2, 8.1-2.5])
            cube([upp_length+0.2, 6.0, 2.5+0.1]);

        // Cutout to mount the ejector
        translate([8.5, (8+3.7)*-1, -0.1])
            cube([21, 8, 8.1+0.2]);
        translate([8.5, (8+2)*-1, 8.1-2.5])
            cube([21, 8, 2.5+0.1]);
    }
}

// This is the complex hole into which the pistol magazine goes.
module main_cavity (total_h) {

    // The width of the magazine is 21.3 mm. However, given that material
    // bulges out when printed, we need a bit more.
    base_w = 22.4;
    base_len = 33.0;

    roof_th = 22.0;
    roof_w = 11.6;

    multmatrix(m = [[   1,   0,  -0.215, 0],
                    [   0,   1,   0,     0],
                    [   0,   0,   1,     0],
                    [   0,   0,   0,     1]])
    {

        union () {

            // The top part is a prism, using the example layout for polyhedron
            // from the OpenSCAD manual. However, we also shear it a little.
            // Bottom layout is counter-clockwise:
            //    A   D
            //    B   C

            translate([(base_len/2)*-1, (base_w/2)*-1, (total_h - roof_th)]) {

                a1 = [0,        0, 0];
                b1 = [base_len, 0, 0];
                c1 = [base_len, base_w, 0];
                d1 = [0,        base_w, 0];

                a2 = a1 + [0, ((base_w - roof_w)/2),    roof_th];
                b2 = b1 + [0, ((base_w - roof_w)/2),    roof_th];
                c2 = c1 + [0, ((base_w - roof_w)/2)*-1, roof_th];
                d2 = d1 + [0, ((base_w - roof_w)/2)*-1, roof_th];

                faces = [
                    [0,1,2,3],
                    [4,5,1,0],
                    [7,6,5,4],
                    [5,6,2,1],
                    [6,7,3,2],
                    [7,4,0,3]];

                polyhedron([a1, b1, c1, d1, a2, b2, c2, d2], faces);
            }

            translate([(base_len/2)*-1, (base_w/2)*-1, 0]) {
                cube([base_len, base_w, (total_h - roof_th) + 0.1]);
            }

            // This side extension is needed because the side walls are
            // much too thin to be reliably printed on basic equipment.
            // So, we destroy side walls on purpose. Of course, we leave
            // the lower belt intact. The width is large enough to affect
            // the magazine overtravel stop.
            translate([(base_len/2)*-1, ((base_w + 4)/2)*-1, 8.0 + 0.2]) {
                cube([base_len, base_w + 4, (total_h - roof_th - 8.0)]);
            }
        }
    }
}

difference () {
    union () {
        body_lower();
        body_upper();
    }

    translate([6.0, 0, (74.0 + 0.1)*-1])
        main_cavity(83.5);

    // Inspection hole for the prototype, matches pistol magazine latch
    translate([-21.0, 0, -34.2])
        cube([5.7, 20, 4.8]);
}
