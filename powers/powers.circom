pragma circom  2.1.6;


template Powers(n) {
    signal input base;
    signal output powers[n];

    powers[0] <== base;
    
    for (var i = 1; i < n; i++) {
        powers[i] <== powers[i-1] * base;
    }
}

component main {public [base]} = Powers(10);