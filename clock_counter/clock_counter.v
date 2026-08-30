// 4 Bit Vounter using a slowed down clock to see the blink/counting effect 
module clock_counter(
    //Output
    output      reg [3:0]       led,

    //Input
    input        pmod_0,

    //Clock
    input clk
);

localparam [25:0] light_delay  = 26'd30000000;

localparam [26:0] clock_target = 27'd60000000;

reg [26:0]clock_counting;

wire rst;

assign rst = !pmod_0;

always @ (posedge clk, posedge rst) begin
    if (rst == 1'b1)begin
        led <= 4'b0;
        clock_counting <= 0;
    end
    else begin
        if (clock_counting == clock_target)begin
            clock_counting <= 0;
            led <= led + 4'b1;
        end
        else begin
            clock_counting <= clock_counting + 1;
        end
    end
end
endmodule




