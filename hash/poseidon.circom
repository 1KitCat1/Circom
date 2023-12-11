// pragma circom  2.1.6;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/comparators.circom";
// include "../node_modules/circomlib/circuits/bitify.circom";


template PoseidonPreimage() {
    signal input message;
    signal input digest;
    signal output isValid;

    component hasher = Poseidon(1);

    hasher.inputs[0] <== message;

    component isEqual = IsEqual();

    isEqual.in[0] <== hasher.out;
    isEqual.in[1] <== digest;
    
    isEqual.out === 1;
    isValid <== isEqual.out;
}

component main{public [digest]} = PoseidonPreimage();
