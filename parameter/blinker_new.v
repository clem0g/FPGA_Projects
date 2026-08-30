module blinker_new(
    //Outputs
    output [1:0] led,

    //Inputs
    input rst_btn,
    input clk);
wire rst;
assign rst = !rst_btn;

clock_divider_new #(.CLOCK_WIDTH (32), .CLOCK_MAX(1500000 - 1)) div1(
    .clk(clk), 
    .out(led[0]), 
    .rst(rst)
);

clock_divider_new div2(
    .clk(clk),
    .out(led[1]),
    .rst(rst)
);

endmodule