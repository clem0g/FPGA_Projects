module button_up(
    //Input
    input rst,
    input clk,

    //Ouput
    output reg state,
    output reg [3:0] out
);

// Constants
localparam [24:0] MAX_COUNT = 1500000;
localparam [4:0]  LED_MAX = 4'hf;

//Variables
reg [24:0] count;
reg div_clk;

// Clock Divider
always@(posedge clk or posedge rst) begin
    if(rst == 1'b1)begin
        div_clk <= 0;
        count <=0;
    end
    else if(count == MAX_COUNT) begin
        count <= 0;
        div_clk <= !div_clk;
    end
    else begin
        count <= count + 1;
    end
end

//Counter
always @(posedge div_clk or posedge rst) begin
    if (rst == 1'b1)begin
        state <= 0;
        out <= 0;
    end
    else if(out == LED_MAX)begin
        state <= 1;
        out <= 0;
    end
    else begin
        out <= out + 1;
    end
end
endmodule