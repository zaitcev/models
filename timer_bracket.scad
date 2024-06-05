//
// timer_bracket.scad
// Bracket for an ASA AirClassics timer Flight Timer-3 aka TIMER-3
//
// Copyright (c) 2024 Pete Zaitcev
//

base_len = 52.0;
base_w = 52.0;
br_w = 48.0;

br_main_th = 2.6;     // The section under clip
// br_stop_th = 4.0;     // Stop strips

// The towers also serve as stops. The distance between them
// corresponds to the size of the clip, 27 mm with a small reserve.
h_north = 8.0;
x_north = 3.0;
th_north = 8.0;
h_south = 16.5;
x_south = 3.0;
th_south = 8.0;

// We design with the back plate down for best adhesion.
module bracket () {

    // Back plate is the backbone of everything.
    // It is large enough for 4 squares of heavy duty tape.
    translate([0, (base_w/2)*-1, 0])
        cube([base_len, base_w, 3.5]);

    // North tower
    translate([x_north, (br_w/2)*-1, 0])
        cube([th_north, br_w, h_north]);

    // South tower
    translate([base_len - x_south - th_south, (br_w/2)*-1, 0])
        cube([th_south, br_w, h_south]);

    // Bracket
    translate([x_north, 0, h_north]) {
        rotate(-12.0, [0,1,0])
            translate([0, (br_w/2)*-1, br_main_th*-1])
                cube([40.0, br_w, br_main_th]);
    }
}

bracket();
