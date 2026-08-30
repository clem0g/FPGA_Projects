module counter(
    //Input 
    input go,
    input rst_btn,
    input clk,

    //Output
    output reg [3:0] led

);

//Constants
localparam STATE_IDLE = 0;
localparam STATE_SWITCH = 1;

//Assignments
wire rst;
assign rst = !rst_btn;

//Variables 
reg state;

//Assignment

wire sig_up;
wire sig_down;
wire [3:0] out_up;
wire [3:0] out_down;

//To reset variables when they are done counting
wire rst_up;
assign rst_up = (rst == 1'b1) || (state == STATE_SWITCH);
wire rst_down;
assign rst_down = (rst == 1'b1) || (state == STATE_IDLE);

button_up up(
    .clk(clk),
    .rst(rst_up),
    .out(out_up), 
    .state(sig_up));

button_down down(
    .clk(clk),
    .rst(rst_down),
    .out(out_down), 
    .state(sig_down));

// MUltiplexer to switch wires connected to led on different states
    always @(*)begin
        if (state == STATE_IDLE)begin
            led <= out_up[3:0];
        end
        else if (state == STATE_SWITCH)begin
            led <= out_down[3:0];
        end
        else begin
            led = 5'b00000;
        end
    end


///State Machine
always @(posedge go or posedge rst)begin
    if (rst == 1'b1)begin
        state <= STATE_IDLE;
    end
    else begin
        case(state)

STATE_IDLE:begin
    if (go == 1'b1)begin
        if(sig_up == 1)begin
            state <= STATE_SWITCH;
    end
end
end

STATE_SWITCH: begin
    if(sig_down == 1) begin
        state <= STATE_IDLE;
    end
end
endcase
end
end
endmodule