module clock_divider_new 
// Parameters
#(
parameter CLOCK_WIDTH = 24,
parameter [CLOCK_WIDTH: 0] CLOCK_MAX = 6000000 -1
)(
    //Outputs
    output reg out,

    //Inputs
    input clk,
    input rst);


//Variables
reg [CLOCK_WIDTH:0] count;

//Clock Divider
always @(posedge clk or posedge rst) begin
    if(rst == 1'b1)begin
        count <= 0;
        out <= 0;
    end
    else if(count == CLOCK_MAX)begin
        count <= 0;
        out <= !out;
    end
    else begin
        count <= count + 1;
    end
end
endmodule

