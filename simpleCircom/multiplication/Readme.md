# This repo represents simple circom circuit.

Compilation:

```circom multiplication.circom --r1cs --wasm --sym --c```

With these options we generate three types of files:

`--r1cs`: it generates the file **multiplication.r1cs** that contains the R1CS constraint system of the circuit in binary format.

`--wasm`: it generates the directory **multiplication_js** that contains the Wasm code (multiplier2.wasm) and other files needed to generate the witness.

`--sym` : it generates the file **multiplication.sym**, a symbols file required for debugging or for printing the constraint system in an annotated mode.

`--c` : it generates the directory **multiplication_cpp** that contains several files (multiplier2.cpp, multiplier2.dat, and other common files for every compiled program like main.cpp, MakeFile, etc) needed to compile the C code to generate the witness.

Computing the witness:

Enter `multiplication_js` dir.

```node generate_witness.js multiplication.wasm ../inputs.json witness.wtns```

