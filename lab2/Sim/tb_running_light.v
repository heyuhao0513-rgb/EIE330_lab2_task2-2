`timescale 1ns / 1ps

module tb_running_light;

    reg        sys_clk;
    reg        sys_rst_n;
    wire [3:0] led_out;

    localparam integer SIM_COUNT_MAX = 5;

    running_light #(
        .COUNT_MAX(SIM_COUNT_MAX)
    ) dut (
        .sys_clk  (sys_clk),
        .sys_rst_n(sys_rst_n),
        .led_out  (led_out)
    );

    initial begin
        sys_clk = 1'b0;
        forever #10 sys_clk = ~sys_clk;
    end

    initial begin
        $dumpfile("Sim/tb_running_light.vcd");
        $dumpvars(0, tb_running_light);

        $timeformat(-9, 0, " ns", 6);
        $monitor("t=%t sys_rst_n=%b cnt=%0d led_out=%b",
                 $time, sys_rst_n, dut.cnt, led_out);

        sys_rst_n = 1'b0;
        #25 sys_rst_n = 1'b1;

        #430 sys_rst_n = 1'b0;
        #20  sys_rst_n = 1'b1;
        #185 $finish;
    end

endmodule