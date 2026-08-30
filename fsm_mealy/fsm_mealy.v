module fsm_mealy(
    //Output
    output  reg     [3:0] led,
    output  reg   led_4,
    
    //Inputs
    input clk,
    input go_btn,
    input rst_btn
);

//Constants
localparam STATE_IDLE = 2'd0 ;
localparam STATE_COUNTING = 2'd1;
localparam LED_MAX = 4'hf;
localparam CLK_MAX = 24'd1500000;

//Variable
reg div_clk;
reg [1:0] state;
reg [23:0] clk_count;

//Assignment
wire go;
assign go = !go_btn;

wire rst;
assign rst = !rst_btn;

//Clock Divider
always @ ( posedge clk or posedge rst) begin
    if( rst == 1'b1) begin
        clk_count <= 0;
    end
    else if ( clk_count == CLK_MAX) begin
        div_clk <= !div_clk;
        clk_count <= 0;
    end
    else begin
        clk_count <= clk_count +1;
    end
end

// State Machine
always @ (posedge div_clk or posedge rst)begin
    if( rst == 1'b1)begin
        state <= STATE_IDLE;
        led <= 0;
        led_4 <= 1'b0;
    end
    else begin
        case(state) 
                    STATE_IDLE: begin
                        led_4 <= 1'b0;
                        if(go == 1'b1)begin
                            state <= STATE_COUNTING;
                        end
                    end
                    
                    STATE_COUNTING: begin
                        if (led == LED_MAX) begin
                            led <= 0;
                            led_4 <= 1'b1;
                            state <= STATE_IDLE;
                        end
                        else begin
                            led <= led + 1;
                            led_4 <= 1'b0;
                        end
                    end

                    default: begin state <= STATE_IDLE; end
        endcase
    end
end
endmodule


