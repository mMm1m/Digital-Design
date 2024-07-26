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

module xor_gate(in1, in2, out);
	input wire in1, in2;
        output wire out;

        supply1 vdd;
        supply0 gnd;
	
	wire out_1;
	wire out_2;
	wire out_3;
	or_gate or1(in1,in2,out_1);
	and_gate and1(in1,in2,out_2);
	not_gate not1(out_2,out_3);
	and_gate and2(out_1,out_3,out);
endmodule

module half_adder(in1, in2, out, c);
	input wire in1, in2;
        output wire out, c;

        supply1 vdd;
        supply0 gnd;
	and_gate andgate(in1,in2,out);
	xor_gate xorgate(in1,in2,c);
endmodule

module adder(in1, in2, cin, cout, out);
	input wire in1, in2, cin;
        output wire cout, out;

        supply1 vdd;
        supply0 gnd;
	wire out_1;
	wire out_2;
	wire out_3;
	xor_gate xorgate1(in1,in2,out_1);
	and_gate andgate1(in1,in2,out_2);
	xor_gate xorgate2(out_1,cin,out);
	and_gate andgate2(out_1,cin,out_3);
	or_gate orgate1(out_3,out_2,cout);
endmodule

module testbench();
        reg a,b,c;
	wire d,e;
        adder g(a, b, c,d,e);
        initial begin
                $dumpfile("./dump.vcd");
                $dumpvars;
        end
        initial begin
                a = 0;
		b = 0;
		c = 0;
                #1;
                $display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);

		a = 0;
                b = 0;
                c = 1;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);

		a = 0;
                b = 1;
                c = 0;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);


		a = 1;
                b = 0;
                c = 0;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);

		a = 1;
                b = 1;
                c = 0;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);


		a = 1;
                b = 0;
                c = 1;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);

		a = 0;
                b = 1;
                c = 1;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);

		a = 1;
                b = 1;
                c = 1;
                #1;
		$display("a = %b , b = %b, c = %b => out = %b, cout = %d", a, b, c,d,e);


        end
endmodule
