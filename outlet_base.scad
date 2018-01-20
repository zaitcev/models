module base(width, length, thickness) {
    $fn = 100;
    intersection() {
        orad = length*1.6;
        translate([width/2, length-orad, 0]) {
            cylinder(thickness, orad, orad);
        }
        translate([width/2, orad, 0]) {
            cylinder(thickness, orad, orad);
        }
        cube([width, length, thickness]);
    }
}

thick = 7;
bw = 4;
lw = 2;
difference () {
    union() {
        base(95, 131, thick-2);
        translate([lw, lw, 0]) {
            base(95 - lw*2, 131 - lw*2, thick);
        }
    }
    translate([bw, bw, -3]) {
        base(95 - bw*2, 131 - bw*2, thick+6);
    }
}