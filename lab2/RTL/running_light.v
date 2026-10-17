`timescale 1ns / 1ps

module running_light (
    input  wire       sys_clk,
    input  wire       sys_rst_n,
    output wire       led0,
    output wire       led1,
    output wire       led2,
    output wire       led3
);

    localparam COUNT_MAX = 25_000_000;
    localparam CNT_WIDTH = 25; 

    reg [CNT_WIDTH-1:0] cnt;
    
    reg [3:0] led_reg; 

    assign led0 = led_reg[0];
    assign led1 = led_reg[1];
    assign led2 = led_reg[2];
    assign led3 = led_reg[3];

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            cnt     <= 25'd0;
            led_reg <= 4'b1110;
        end
        else if (cnt == COUNT_MAX - 1) begin
            cnt     <= 25'd0;
            led_reg <= {led_reg[2:0], led_reg[3]}; 
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end

endmodule