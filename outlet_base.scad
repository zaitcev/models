module base(width, length, thickness) {
    $fn = 150;
    intersection() {
        orad = length*1.5;
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
        base(94, 128, thick-2);
        translate([lw, lw, 0]) {
            base(94 - lw*2, 128 - lw*2, thick);
        }
    }
    translate([bw, bw, -3]) {
        base(94 - bw*2, 128 - bw*2, thick+6);
    }
}