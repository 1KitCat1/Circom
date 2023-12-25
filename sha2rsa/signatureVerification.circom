pragma circom  2.1.6;


include "../node_modules/circomlib/circuits/sha256/sha256.circom";
include "../node_modules/circomlib/circuits/bitify.circom";

template SignatureVerification(N) {
    signal input in;
    signal output out;
    
    component num2Bits = Num2Bits(N);

    num2Bits.in <== in;

    component hasher = Sha256(N);

    component bits2Num = Bits2Num(256);

    hasher.in <== num2Bits.out;

    bits2Num.in <== hasher.out;
    

    log(bits2Num.out);
    out <== bits2Num.out;
}

component main = SignatureVerification(256);