pragma circom  2.1.6;

include "node_modules/circomlib/circuits/comparators.circom";

function invert(x) {
    return 1 / x;
}

template Average(n) {
    signal input in[n];
    signal output out;

    var sum;
    for (var i = 0; i < n; i++) {
        sum += in[i];
    }

    signal denominator_inverse;

    denominator_inverse <-- invert(n);

    component isEqual = IsEqual();

    isEqual.in[0] <== 1;
    isEqual.in[1] <== denominator_inverse;

    out <== sum * denominator_inverse;
}

component main = Average(5);