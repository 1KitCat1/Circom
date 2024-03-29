pragma circom 2.1.3;

include "constants.circom";
include "sha1compression.circom";

template Sha1(nBits) {
    signal input in[nBits];
    signal output out[160];

    var i;
    var k;
    var nBlocks;
    var bitsLastBlock;

    nBlocks = ((nBits + 64) \ 512) + 1;    
    log(nBlocks);
    signal paddedIn[nBlocks * 512];

    for (k=0; k<nBits; k++) {
        paddedIn[k] <== in[k];
    }

    paddedIn[nBits] <== 1;

    for (k=nBits+1; k<nBlocks*512-64; k++) {
        paddedIn[k] <== 0;
    }   

    for (k=0; k<64; k++) {
        paddedIn[nBlocks*512-k-1] <== (nBits >> k)&1;
    }

    // for (k = 0; k < 512; k++) {
    //     log(paddedIn[k]);
    // }

    component ha0 = H(0);
    component hb0 = H(1);
    component hc0 = H(2);
    component hd0 = H(3);
    component he0 = H(4);

    component sha1compression[nBlocks];
    
    for (i=0; i<nBlocks; i++) {
        
        sha1compression[i] = Sha1compression();

        if (i==0) {
            for (k=0; k<32; k++) {
                sha1compression[i].hin[0*32+k] <== ha0.out[k];
                sha1compression[i].hin[1*32+k] <== hb0.out[k];
                sha1compression[i].hin[2*32+k] <== hc0.out[k];
                sha1compression[i].hin[3*32+k] <== hd0.out[k];
                sha1compression[i].hin[4*32+k] <== he0.out[k];
            }
        } else {
            for (k=0; k<32; k++) {
                sha1compression[i].hin[32*0+k] <== sha1compression[i-1].out[32*0+31-k];
                sha1compression[i].hin[32*1+k] <== sha1compression[i-1].out[32*1+31-k];
                sha1compression[i].hin[32*2+k] <== sha1compression[i-1].out[32*2+31-k];
                sha1compression[i].hin[32*3+k] <== sha1compression[i-1].out[32*3+31-k];
                sha1compression[i].hin[32*4+k] <== sha1compression[i-1].out[32*4+31-k];
            } 
        }

        for (k=0; k<512; k++) {
            sha1compression[i].inp[k] <== paddedIn[i*512+k];
        }
        
    }

    // component bits2Num = Bits2Num(160);

    for (k=0; k<160; k++) {
        out[k] <== sha1compression[nBlocks-1].out[k];
        // bits2Num.in[k] <== sha1compression[nBlocks-1].out[k];
    }

    // out <== bits2Num.out;
}