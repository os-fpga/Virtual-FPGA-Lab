`timescale 1ns / 1ps
// counter based(to slow down the clock signal)
module clock_divider #(parameter DIV_VALUE = 1)(
    input wire clk,             // 100MHz
    output reg divided_clk = 0     
    );


// Formula:
// division_value DIV_VALUE = 100MHz/(2*desired frequency) - 1

// counter
integer counter_value = 0;  // integer is a 32bit wide register bus

always@ (posedge clk)       
begin
    if (counter_value == DIV_VALUE)
        counter_value <= 0;  // reset counter value
    else
        counter_value <= counter_value + 1;  // count up // '<=' means the line updates in parallel 
end

// divide clock
always@ (posedge clk)
begin
    if(counter_value == DIV_VALUE)
        divided_clk <= ~divided_clk; // flip the signal
    else
        divided_clk <= divided_clk;  // previous value(no change) 
end
endmodule
