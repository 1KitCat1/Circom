pragma circom  2.1.6;


template IsEqual() {

    // Declaration of signals.
    signal input _inputs[2];
    signal output _out;

    component isZero = IsZero();

    _inputs[0] - _inputs[1] ==> isZero.in;

    isZero.out ==> _out;
}

template IsZero() {
  signal input in;
  signal output out;

  signal inv;

  inv <-- in!=0 ? 1/in : 0;

  out <== -in*inv +1;
  in*out === 0;
}

component main {public [_inputs]} = IsEqual();