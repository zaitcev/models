//
// RU9 family ejector
//

module ejector_2d () {
    // The angle of the tip is 60 degrees. We approximate in Carthesian.
    polygon([
        [ 3.0,  12.0],
        [ 3.0,  -1.2],
        [ 8.0,  -5.0],
        [ 8.0, -16.5],
        [ 0.0, -16.5],
        [ 0.0,  11.0],
        [-5.66, 15.00],
        [-4.80, 16.50]]
    );
}
