// A console support for a doorbell

// The slab takes 4 (X,Y,0) points and thickness.
// Bottom layout is counter-clockwise:
//    A   D
//    B   C
module slab(a, b, c, d, th) {
  a1 = a;
  b1 = b;
  c1 = c;
  d1 = d;

  a2 = a + [0,0,th];
  b2 = b + [0,0,th];
  c2 = c + [0,0,th];
  d2 = d + [0,0,th];

  faces = [
    [0,1,2,3],
    [4,5,1,0],
    [7,6,5,4],
    [5,6,2,1],
    [6,7,3,2],
    [7,4,0,3]];

  polyhedron(
    [a1, b1, c1, d1,
     a2, b2, c2, d2],
    faces
  );
}

// Spine is like the foot but flipped sideways.
// Therefore, points are (0,Y,Z).
// The layout is looking towards negative X:
//    A   D
//   B     C
// module spine(a, b, c, d, th) {
//   a1 = a + [ th/2,0,0];
//   b1 = b + [ th/2,0,0];
//   c1 = c + [ th/2,0,0];
//   d1 = d + [ th/2,0,0];
//
//   a2 = a + [-th/2,0,0];
//   b2 = b + [-th/2,0,0];
//   c2 = c + [-th/2,0,0];
//   d2 = d + [-th/2,0,0];
//
//   faces = [
//     [0,1,2,3],
//     [4,5,1,0],
//     [7,6,5,4],
//     [5,6,2,1],
//     [6,7,3,2],
//     [7,4,0,3]];
//
//   polyhedron(
//     [a1, b1, c1, d1,
//      a2, b2, c2, d2],
//     faces
//   );
// }

// punch 4 holes in the slab for screws
difference () {
  slab([ 12.0, 0.0, 0], [ 1.0, 140.0, 0],
   [-1.0, 140.0, 0], [-12.0, 0.0, 0], 1.5);

  translate([ 7.5, 4.5, -0.1])
    cylinder(2, 2.0, 2.0);
  translate([-7.5, 4.5, -0.1])
    cylinder(2, 2.0, 2.0);

  translate([ 6.0, 16.0, -0.1])
    cylinder(2, 2.0, 2.0);
  translate([-6.0, 16.0, -0.1])
    cylinder(2, 2.0, 2.0);
}

difference () {
// XXX polyhedron does not work: it itself forms fine,
// but applying any difference erases it completely.
// So, we work around by using a tilted cube.
//  spine([0, 0.0, 0.0], [0, 140.0, 0.0],
//   [0, 140.0, 6.0],  [0, 2.0, 12.0], 2.0);

  intersection () {
    translate([-1.5, 0, 0])
      cube([3.0, 150, 20]);
    rotate(-3.5, [1, 0, 0])
      translate([-1.0, 0, 0])
        cube([2.0, 140.0, 12.0]);
  }

  translate([0, 136.5, 3.7])
    rotate(90, [0, 1, 0])
      translate([0, 0, -3.0/2])
        cylinder(3, 1.8, 1.8);
}
