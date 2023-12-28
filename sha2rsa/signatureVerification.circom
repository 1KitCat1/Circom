pragma circom  2.1.6;


include "../node_modules/circomlib/circuits/sha256/sha256.circom";
include "../node_modules/circomlib/circuits/bitify.circom";

template SignatureVerification(N) {
    signal input in[N];
    signal output out[256];

    component hasher = Sha256(N);

    hasher.in <== in;

    component bits2NumFirst = Bits2Num(128);
    component bits2NumSecond = Bits2Num(128);

    for (var i = 0; i < 128; i++) {
        bits2NumFirst.in[127-i] <== hasher.out[i];
    }

    for (var i = 0; i < 128; i++) {
        bits2NumSecond.in[127-i] <== hasher.out[128 + i];
    }

    out[0] <== bits2NumFirst.out;
    out[1] <== bits2NumSecond.out;
}

component main = SignatureVerification(8);