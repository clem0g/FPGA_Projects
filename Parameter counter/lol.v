module lol(
    // Input 
    input go,
    input rst_btn,
    input clk,

    // Output - Changed to 'reg' so we can assign it inside an always block
    output reg [4:0] led
);

// Constants
localparam STATE_IDLE = 0;
localparam STATE_SWITCH = 1;

// Basic Reset Wiring
wire rst;
assign rst = ~rst_btn;

// State Variable
reg state;

// 1. Dedicated wires for each module's outputs
wire [4:0] out_up;
wire [4:0] out_down;
wire sig_up;
wire sig_down;

// 2. Explicit Reset Wires for each module
// We physically wire these up so they are only held in reset when it's not their turn
wire rst_up;
wire rst_down;

assign rst_up   = (rst == 1'b1) || (state == STATE_SWITCH);
assign rst_down = (rst == 1'b1) || (state == STATE_IDLE);

// 3. Instantiate the modules physically
button_up up_inst (
    .clk(clk),
    .rst(rst_up),
    .out(out_up),
    .state(sig_up)
);

button_down down_inst (
    .clk(clk),
    .rst(rst_down),
    .out(out_down),
    .state(sig_down)
);

// 4. Explicit Multiplexer (Routing the outputs to the LEDs)
// No shorthand (? :). Just a clear if/else block telling the FPGA which wire to connect to the LEDs.

always @(*) begin
    if (state == STATE_IDLE) begin
        led = out_up;
    end
    else if (state == STATE_SWITCH) begin
        led = out_down;
    end
    else begin
        led = 5'b00000;
    end
end

// 5. State Machine
always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        state <= STATE_IDLE;
    end
    else begin
        case(state)
            STATE_IDLE: begin
                // Wait for the 'go' button to be pressed
                if (go == 1'b1) begin
                    // Once 'go' is pressed, wait for the UP module to say it is done
                    if (sig_up == 1'b1) begin
                        state <= STATE_SWITCH;
                    end
                end
            end

            STATE_SWITCH: begin
                // Wait for the DOWN module to say it is done
                if (sig_down == 1'b1) begin
                    state <= STATE_IDLE;
                end
            end
        endcase
    end
end
endmodule