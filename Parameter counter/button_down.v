module button_down(
    //Input
    input rst,
    input clk,

    //Output
    output reg [3:0]out,
    output reg state
);

//Constants
localparam [24:0] MAX_COUNT = 1500000;
localparam LED_MIN = 0;

//Variables
reg div_clk;
reg [24:0] count;

// Clock Divider
always@(posedge clk or posedge rst) begin
    if (rst == 1'b1)begin
        div_clk <= 0;
        count <= 0;
    end
    else if (count == MAX_COUNT) begin
        count <= 0;
        div_clk <= !div_clk;
    end
    else begin
        count <= count + 1;
    end
end

//Counter
always @(posedge div_clk or posedge rst)begin
    if (rst == 1'b1)begin
        state <= 0;
        out <= 4'hf;
    end
    else if(out == LED_MIN)begin
        state <=1;
        out <= 4'hf;
    end
    else begin
        out <= out -1;
    end
end
endmodule