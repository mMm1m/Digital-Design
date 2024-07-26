module not_gate(in, out);
        input wire in;
        output wire out;

        supply1 vdd;
        supply0 gnd;

        wire nmos_out;
        nmos nmos1(out, gnd, in);
        pmos pmos1(out, vdd, in);
endmodule

module nand_gate(in1, in2, out);
	input wire in1, in2;
	output wire out;
	
	supply1 vdd;
	supply0 gnd;

	wire nmos_out;
	pmos pmos1(out,vdd,in1);
	pmos pmos2(out,vdd,in2);
	nmos nmos1(nmos_out,gnd,in2);
	nmos nmos2(out,nmos_out,in1);
endmodule

module nor_gate(in1, in2, out);
	input wire in1, in2;
        output wire out;

        supply1 vdd;
        supply0 gnd;

        wire pmos_out;
        pmos pmos1(pmos_out,vdd,in1);
        pmos pmos2(out,pmos_out,in2);
        nmos nmos1(out,gnd,in1);
        nmos nmos2(out,gnd,in2);
endmodule

module and_gate(in1, in2, out);
	input wire in1, in2;
        output wire out;

        supply1 vdd;
        supply0 gnd;

	wire mos;
	nand_gate nand1(in1,in2,mos);
	not_gate not1(mos,out);
endmodule

module or_gate(in1, in2, out);
	input wire in1, in2;
        output wire out;

        supply1 vdd;
        supply0 gnd;

        wire mos;
        nor_gate nand1(in1,in2,mos);
        not_gate not1(mos,out);
endmodule

module testbench();
        reg a,b;
        wire c;
        or_gate g(a, b, c);
        initial begin
                $dumpfile("./dump.vcd");
                $dumpvars;
        end
        initial begin
                a = 0;
		b = 0;
                #1;
                $display("a = %b , b = %b => c = %b", a, b, c);
                a = 1;
		b = 0;
                #1;
                $display("a = %b , b = %b => c = %b", a, b, c);
		a = 0;
                b = 1;
                #1;
                $display("a = %b , b = %b => c = %b", a, b, c);
                a = 1;
                b = 1;
                #1;
                $display("a = %b , b = %b => c = %b", a, b, c);
        end
endmodule
