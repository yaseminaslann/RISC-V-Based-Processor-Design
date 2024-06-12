`timescale 1ns / 1ps

module tb_top();
    
    reg clk = 0;
    always #5 clk = !clk;
    
    reg rst = 1;
    
    wire [31:0] bus_read_data;
    wire [31:0] bus_address;
    wire [31:0] bus_write_data;
    wire [3:0]  bus_byte_enable;
    wire bus_read_enable;
    wire bus_write_enable;
    wire [31:0] inst;
    wire [31:0] pc;
    
    initial begin
        #100;
        rst = 0;
        
        repeat (100000) begin
            @(posedge clk);
            
            $display("PC: %h, Inst: %h, Addr: %h, Rd-Dt: %h, Rd-En %d, Wr-Dt: %h, WrEn: %d, Wr-BE: %b", pc, inst, bus_address, bus_read_data, bus_read_enable, bus_write_data, bus_write_enable, bus_byte_enable);
            
            if (bus_write_enable && bus_address == 32'hfffffff0) begin
                if (bus_write_data !== 0) begin
                    $display("Pass");
                    $finish;
                end else begin
                    $display("Fail");
                    $finish;
                end
            end
        end
        
        $display("Timeout - Fail");
        $finish;
    end
        
    toplevel toplevel(
        .clock(clk),
        .reset(rst),
    
        .bus_read_data(bus_read_data),//output [31:0] bus_read_data,
        .bus_address(bus_address),//output [31:0] bus_address,
        .bus_write_data(bus_write_data),//output [31:0] bus_write_data,
        .bus_byte_enable(bus_byte_enable),//output [3:0]  bus_byte_enable,
        .bus_read_enable(bus_read_enable),//output        bus_read_enable,
        .bus_write_enable(bus_write_enable),//output        bus_write_enable,
    
        .inst(inst),//output [31:0] inst,
        .pc(pc)//output [31:0] pc
    );
    
    /*
    example_memory_bus example_memory_bus(
        .clock(clk), //input  clock,
        .address(bus_address), //input  [31:0] address,
        .read_data(bus_read_data), //output [31:0] read_data,
        .write_data(bus_write_data), //input  [31:0] write_data,
        .byte_enable(bus_byte_enable), //input   [3:0] byte_enable,
        .read_enable(bus_read_enable), //input         read_enable,
        .write_enable(bus_write_enable) //input         write_enable
    );
    */
    
endmodule
