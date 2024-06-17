// Mooney M20E anunciator bezel, common code

// Cone is 50% wider than the hole
module hole(dia, height) {
    union () {
        cylinder(height, dia/2, dia/2, $fn=16);
        translate ([0,0, height-(dia/4)]) {
            cylinder(dia/4, dia/2, (dia*1.5)/2, $fn=16);
        }
    }
}
