//
// RU9 family ejector
//

// The 1.34mm thick plate comes from a local hardware store.
// Closest American plates are:
//    16 Gauge = 1.588 mm
//    17 Gauge = 1.429 mm
//    18 Gauge = 1.270 mm
// 
thickness = 1.34;

module main () {
    linear_extrude(height=thickness) {
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
}

main();
