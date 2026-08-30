
// 4 Bit Counter which can basically count from 1 to 15(F) and is represented in binary using 4 leds.

module button_counter ( 

    /* Output leds used to display counting up in binary
(using reg because we will use non blocking assignment so we don't want to make it permanet like 'wire' 
which the FPGA automatically specifies if no connection type was specified)*/
    output      reg [3:0]       led,

    //Input Buttons 
    input       [1:0]       pmod
);

// making a button pressed to represent the clock signals used in the always block instead of the traditional clk in the FPGA
wire button_as_clock;

assign button_as_clock = !pmod[0];

// making a button pressed to represent the reset signals used in the always block instead of the traditional rst in the FPGA
wire reset_button;

assign reset_button = !pmod[1];

/* This always block allows procedural code the be run using a clock signal, 
the clock signal is represented in this code as a button press same for the reset, 
when the button is pressed the clock goes high or if the reset button is pressed the signal also triggers the always block
meaning the always block runs the if statement 
if the reset button was pressed the counter in binary using lights resets to zero, 
If it wasn't pressed 1 is added. 
The Always block also executes on the reset button, which triggers the first condition of the if statement to resset the counter.
*/
always @ (posedge button_as_clock, posedge reset_button) begin

    //Resets the counter to 0 using non blocking assignment'<=' (can be changed later not permanent like '=')
    if (reset_button == 1'b1) begin
        led <= 4'b0;
    end
    else begin
        led <= led + 4'b1;
    end
end

endmodule
