/* Adder between 3 binary numbers (1 or 0) (2 bit adder)
Represented by button presses to add and result represented by lights going on or off or both
*/

module adder(
    // Output LEDs
    output      [1:0]       led,

    //Input Buttons
    input       [2:0]       pmod
);

// Assigning Variables to represent each button
wire a;

assign a = !pmod[0];

wire b;

assign b = !pmod[1];

wire c;

assign c = !pmod[2];

// To find the value of the unit value in the binary addition (adder)
wire unit;

// XOR gate between a,b,c
wire xor_a_b_c;

assign xor_a_b_c = a ^ b ^ c;

//Value of unit
assign unit = xor_a_b_c;


// To find the value of the tens value in the binary addition (adder)
wire tens;

// XOR gate between a,b
wire xor_a_b;

assign xor_a_b = a ^ b;

//AND gate of the value of XOR a,b; with c
wire xor_a_b_and_c;

assign xor_a_b_and_c = xor_a_b & c;

// AND gate between a, b
wire and_a_b;

assign and_a_b = a & b;

// OR gate the the value of XOR a, b AND c; with the value of AND a,b
wire or_gate;

assign or_gate = xor_a_b_and_c | and_a_b;

// Value of tens
assign tens = or_gate;


/*Adder value(Basically doing binary addition) is assigned to first led being the unit value of the binary, second being the tens. 
E.g 1 + 1 + 1 = 11 in binary, hence the 2 LEDs light up (High{voltage on} -> 1 and High{voltage on} -> 1) to signify 11
*/
assign led[0] =  unit;
assign led[1] = tens;

endmodule