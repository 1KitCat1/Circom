pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/mimcsponge.circom";


template MiMC7Hash() {
    signal input in;
    signal output out;

    component hasher = MiMCSponge(1, 220, 1);
    hasher.ins[0] <== in;
    hasher.k <== 0;
    out <== hasher.outs[0];
}

component main = MiMC7Hash();