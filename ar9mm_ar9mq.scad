//
// The original AR9MQ with a metal ejector and no LRBHO
//

use <ar9mm_adapter.scad>;

module main () {
    difference () {
        adapter();
        ejector_cavity();
    }
}

main();