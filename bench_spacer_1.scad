//
// This spacer prevents the bench from damaging the wall
//

module center_x_cube(xlen, ylen, zlen) {
    translate([(xlen/2)*-1, 0, 0])
        cube([xlen, ylen, zlen]);
}

module spacer () {
    center_x_cube(100.0, 12.0, 16.0);
}

spacer();
