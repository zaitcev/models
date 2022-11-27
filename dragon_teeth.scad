//
// The dragon teeth is an anti-cat fortification, similar to the one
// used against tanks, only smaller. It is also similar in function
// to fortifications against pigeons and homeless. Ultimately, it denies
// cats the comfort they crave when they defecate in our chimnea.
//

base_th = 2.2;

module tooth () {
    // sin(pi/3) = 0.8660254;
    bot_w = 14.0;
    translate([0, (bot_w/4)*-1, 0]) {
        polyhedron(
            // point indexes are used for faces
            //        #0       #1           #2           #3
            points=[ [(bot_w/2)*-1, 0, 0],
                     [bot_w/2,      0, 0],
                     [0, bot_w*sin(60), 0],
                     [0.0, bot_w/4, 45.0] ],
            faces=[ [0,3,1], [2,3,0], [1,3,2],   [0,1,2] ]
        );
    }
}

module base () {

    base_sl = 66.0;
    for (angle = [0 : 60 : 300]) {
        rotate(angle, [0,0,1]) {
            // A cube that forms the base.
            translate([(base_sl/2)*-1, 0, 0])
                cube([base_sl, base_sl*sin(60), base_th]);
            // A clip.
            translate([1.0, base_sl*sin(60) - 3.0, base_th])
                cube([base_sl*0.2, 6.0, 2.0]);
        }
    }
}

// Teeth are designed to sit on a hexagon created by base().
// So this is not really an independent module. Too bad.
module teeth () {

    base_sl = 66.0;
    for (angle = [0 : 60 : 300]) {
        rotate(angle + 30, [0,0,1]) {
            translate([(base_sl)/(2*sin(60)), 0, base_th - 0.1])
                // for (angle3 = [0 : 120 : 300]) {
                //     rotate(angle3 + 60, [0,0,1]) {
                //         translate([base_sl/(5*sin(60)), 0, 0])
                //             tooth();
                //     }
                // }
                tooth();
        }
    }
}

module main () {
    difference () {
        base();
        translate([0, 0, -0.1])
            cylinder(base_th + 0.2, r=12.0);
    }
    teeth();
}

main();
