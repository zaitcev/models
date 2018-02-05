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
        sphere(4);
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
  
    // supporting material
    // just adding a bunch of pillars for now

    translate([-21.2,  1.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2,  1.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2,  3.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2,  3.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2,  6.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2,  6.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2,  8.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2,  8.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2, 11.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2, 11.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2, 13.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2, 13.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2, 16.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2, 16.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2, 18.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2, 18.5, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-21.2, 21.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 21.2, 21.0, 0]) cylinder(1.3, 0.6, 0.6);

    translate([-20.9, 23.4, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 20.9, 23.4, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-20.2, 25.6, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 20.2, 25.6, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-19.1, 27.6, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 19.1, 27.6, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-17.5, 29.3, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 17.5, 29.3, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-15.2, 30.8, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 15.2, 30.8, 0]) cylinder(1.3, 0.6, 0.6);
    translate([-12.8, 31.7, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 12.8, 31.7, 0]) cylinder(1.3, 0.6, 0.6);

    translate([-10.3, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ 10.3, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ -7.5, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([  7.5, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ -5.0, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([  5.0, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([ -2.5, 32.0, 0]) cylinder(1.3, 0.6, 0.6);
    translate([  2.5, 32.0, 0]) cylinder(1.3, 0.6, 0.6);

    translate([  0.0, 32.0, 0]) cylinder(1.3, 0.6, 0.6);

    translate([  0.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ -2.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([  2.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ -5.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([  5.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ -7.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([  7.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([-10.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ 10.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([-12.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ 12.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([-15.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ 15.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([-17.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ 17.5,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([-20.0,  0.3, 0]) cylinder(19, 0.6, 0.6);
    translate([ 20.0,  0.3, 0]) cylinder(19, 0.6, 0.6);

  }

  translate([-30, 0, -5]) cube([60, 40, 70+5]);
}