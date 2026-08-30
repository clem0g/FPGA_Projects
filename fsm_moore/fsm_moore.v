module fsm_moore(
    //Outputs
    output reg [3:0] led,
    output reg led_4,

    //Inputs
    input clk,
    input go_btn,
    input rst_btn 

);

//Constants

localparam STATE_IDLE = 2'd0;
localparam STATE_COUNTING = 2'd1 ;
localparam STATE_DONE = 2'd2;
localparam LED_MAX = 4'hf ;
localparam CLK_MAX = 24'd1500000 ;

//Variables (Holders)
reg [23:0]clk_count;
reg [1:0] state;
reg div_clk;

//Assignments
wire rst;
assign rst = !rst_btn;

wire go;
assign go = !go_btn;
//Clock Divider
always @(posedge clk or posedge rst) begin
    if(rst == 1'b1)begin
        clk_count <= 0;
    end
    else if (clk_count == CLK_MAX) begin
        div_clk <= !div_clk;
        clk_count <= 0;
    end
    else begin
        clk_count <= clk_count + 1;
    end
    end 

//State Machine
always @ (posedge div_clk or posedge rst) begin
    if (rst == 1'b1) begin
        state <= STATE_IDLE;
    end
    else begin
        case(state)
                        STATE_IDLE:     begin
                            if(go == 1'b1) begin
                                state <= STATE_COUNTING;
                            end
                        end

                        STATE_COUNTING: begin
                            if (led == LED_MAX)begin
                                state <= STATE_DONE;
                            end
                        end

                        STATE_DONE: begin
                            state <= STATE_IDLE;
                        end

                        default: begin state <= STATE_IDLE; end
                        endcase
    end 
end

always @(posedge div_clk or posedge rst)begin
    if(rst == 1'b1)begin
        led <= 0;
    end
    else if(state == STATE_COUNTING) begin
        led <= led + 1;
    end
    else begin
        led <= 0;
    end
end

always @ (*)begin
    if(state == STATE_DONE)begin
        led_4 = 1'b1;
    end
    else begin
        led_4 = 1'b0;
    end
end
endmodule
 