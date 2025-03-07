// A holder for Clorox(r) Bleach Pen(r)
// This can be mounted with a heavy duty tape or a magnet.

intersection () {

  union () {

    // front shell
    difference() {

      // outside shape
      minkowski() {
        $fn = 30;
        hull() {
          translate([10, 21, 4]) cylinder(66, 9, 9);
          translate([-10, 21, 4]) cylinder(66, 9, 9);
          translate([-19, 0, 4]) cube([38, 5, 66]);
        }
        sphere(4.4);
      }

      // inside shape
      minkowski() {
        $fn = 30;
        hull() {
          translate([10, 21, 4]) cylinder(66, 9, 9);
          translate([-10, 21, 4]) cylinder(66, 9, 9);
          translate([-19, 0, 4]) cube([38, 5, 66]);
        }
        sphere(3);
      }
    }

    // spine
    difference() {
      translate([-22, 0, 19]) cube([44, 1.5, 70-19]);
      // this indentation is for the magnet stripe
      translate([-14.5, -0.5, 21.5]) cube([29, 1, 45]);
    }
  }

  // a big boundary cube
  translate([-30, 0, -5]) cube([60, 40, 70+5]);
}
