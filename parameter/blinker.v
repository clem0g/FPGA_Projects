module blinker(
    //Inputs
    input rst_btn,
    input clk,

    //Outputs
    output [1:0] led
);
wire rst;
assign rst = ~rst_btn;

clock_divider div1(
    .clk(clk),
    .out(led[0]),
    .rst(rst)
);
defparam div1.CLOCK_WIDTH = 32;
defparam div1.CLOCK_MAX = 1500000;

clock_divider div2(
    .clk(clk),
    .out(led[1]),
    .rst(rst)
);

endmodule