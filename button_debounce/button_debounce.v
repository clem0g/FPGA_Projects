module button_debounce(
    //Outputs
    output reg [3:0] led,

    //Inputs
    input pmod_1,
    input pmod_2,
    input pmod_3,
    input clk
);
//constant
localparam DELAY = 24'd1500000 ;
localparam LED_MAX = 4'hf ;
localparam STATE_IDLE = 2'd1;
localparam STATE_COUNTING = 2'd2;

//Assignments
wire rst;
assign rst = !pmod_1;

wire count;
assign count = !pmod_3;

wire go;
assign go = !pmod_2;

//Variables
reg div_clk;
reg [1:0]state;
reg [23:0]clk_count;
reg count_prev; // To remeber the previous state so that when press it it will only change once

//Divided Clock
always @(posedge clk or posedge rst)begin
    if (rst == 1'b1) begin
        clk_count <= 0;
        div_clk <= 0;
    end
    else if(clk_count == DELAY) begin
        div_clk <= !div_clk;
        clk_count <= 0;
    end
    else begin
        clk_count <= clk_count + 1;
    end
end

// State Machine
always @(posedge div_clk or posedge rst )begin
    if(rst == 1'b1)begin
        state <= STATE_IDLE;
        led <= 0;
        count_prev <= 0;
    end
    else begin
        count_prev <= count;
        case(state)
                    STATE_IDLE: begin
                            if (go == 1'b1) begin
                                led <= 0;
                                state <= STATE_COUNTING;
                                
                            end
                        end

                    STATE_COUNTING: begin
                        if(count_prev == 1'b0 && count == 1'b1)begin
                            if (led == LED_MAX) begin
                                state <= STATE_IDLE;
                            end
                            else begin
                                led <= led + 1;
                            end
                        end
                    end
                    default:begin state <= STATE_IDLE; end
        endcase
    end
end
endmodule