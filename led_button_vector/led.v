// 1 button lights up 2 led and the last button when pressed togther lights up all 3 leds
module led(
    // Output LED
    output      [2:0]       led,

    //Input Buttons
    input       [1:0]       pmod
);
// laying 2 wires from button 1
wire [1:0] linked_buttons;

// assigning the voltage to 1 when button 1 is pressed(pass that voltage through the wire)
assign linked_buttons = {2{!pmod[0]}};

// connecting the wire and volages passed to 2 leds
assign led[1:0] = linked_buttons;

// connecting the last led to when button 1 and 2 are pressed together
assign led[2] = !pmod[0] & !pmod[1];

endmodule
