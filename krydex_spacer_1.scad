//
// Spacer for a KRYDEX magazine pouch when used with Glock 42
//

module spacer() {
    union () {
        // Spacer that stabilizes the magazine
        translate([-12.0, -15.0/2, 0]) cube([46.0, 15.0, 3.0]);

        // Connector
        translate([-12.0, -6.2/2, 0]) cube([29.0, 6.2, 8.1]);

        // The tab that slides into the slots
        // Measured thickness is 2.4, but we print 1.9, or else it's too thick.
        translate([-18.0/2, -16.2/2, 8.1-1.9]) cube([18.0, 16.2, 1.9]);
    }
}

spacer();
