module not_gate(in, out);
        input wire in;
        output wire out;

        supply1 vdd;
        supply0 gnd;

        wire nmos_out;
        nmos nmos1(out, gnd, in);
        pmos pmos1(out, vdd, in);
endmodule


module testbench();
        reg a;
        wire b;
        not_gate g(a, b);
        initial begin
                $dumpfile("./dump.vcd");
                $dumpvars;
        end
        initial begin
                a = 0;
                #1;
                $display("a = %b => b = %b", a, b);
                a = 1;
                #1;
                $display("a = %b => b = %b", a, b);
        end
endmodule
