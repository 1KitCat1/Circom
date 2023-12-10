pragma circom  2.0.0;

template Multiplier2() {

    // Declaration of signals.
    signal input _a;
    signal input _b;
    signal output _out <== _a * _b;

}

component main {public [_a, _b]} = Multiplier2();