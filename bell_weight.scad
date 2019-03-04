// Weight for a doorbell
//
// This is basically a way to waste some material,
// with a ring on top for the string.

module washer (th) {
  rotate(90, [0, 1, 0]) {
    translate ([0, 0, -th/2]) {
      difference () {
        cylinder(th, th*2.8, th*2.8);
        translate([0, 0, -0.1])
          cylinder(th + 0.2, th*1.2, th*1.2);
      }
    }
  }
}

module weight (dia) {
  intersection () {
    cylinder(dia*0.7, dia/2, dia/2);
    translate([0, 0, dia*0.35])
      sphere(dia/2);
  }

  translate([0, 0, dia*0.7])
    washer(2.5);
}

weight(35);