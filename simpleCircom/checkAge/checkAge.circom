pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";


template CheckAge() {
    signal input age;
    signal input ageLimit;
    signal output oldEnough;

    component greaterThan = GreaterThan(8); // compare up to 2**8=256; enough for age

    greaterThan.in[0] <== age;
    greaterThan.in[1] <== ageLimit;

    oldEnough <== greaterThan.out;
}

component main = CheckAge();