//
// Holder for a flat file in an inside opening
//

base_y_w = 16.0;
base_z_h = 18.2;
base_z_h_tip = 18.2 - 3.0;     // excludes the file tip of 2.7 mm
base_z_h_handle = 18.2 - 7.0;  // excludes the file handle of 6.28 mm

tape_th = 0.8;     // reserve for tape

rod_d = 5.0;  // actual diameter is 5.15 mm

module holder () {

    // We have 3 sections:
    //   1. Front where the flat part of the file goes
    //   2. Transition
    //   3. Rear where the handle and the rod attach

    // main base covers the front 2 sections
    cube([120.0 + 0.01, base_y_w, base_z_h_handle]);

    // front shelf for the flat of the file
    cube([45.0, base_y_w, base_z_h_tip]);
    // front ridge to push off
    translate([0, 10.0, 0])
        cube([120.0, base_y_w - 10.0, base_z_h]);

    // rear base
    translate([120.0, tape_th, tape_th])
        cube([60.0, base_y_w - tape_th*2, 5.0 - tape_th]);
    // rear ridge for push-off
    translate([120.0, base_y_w - 8.0, tape_th])
        cube([60.0, 8.0 - tape_th, base_z_h - tape_th*2]);
    // rod ridge
    translate([120.0, tape_th, tape_th])
        cube([60.0, base_y_w - 8.0 - rod_d - tape_th, 9.0 - tape_th]);
}

// holder();
mirror([0,1,0])
  holder();
