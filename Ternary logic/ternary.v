module VENT_NOT(in, out);
	input in;
	output out;

	supply1 vdd;
	supply0 gnd;

	pmos p1(out, vdd, in);
	nmos n1(out, gnd, in);
endmodule

module VENT_NAND(in1, in2, out);
	input in1, in2;
	output out;
	wire w;

	supply1 vdd;
	supply0 gnd;

	nmos n1(w, gnd, in2);
	nmos n2(out, w, in1);
	pmos p1(out, vdd, in1);
	pmos p2(out, vdd, in2);
endmodule

module VENT_AND(in1, in2, out);
	input in1, in2;
	output out;
	wire w;

	VENT_NAND nand0(in1, in2, w);
	VENT_NOT not0(w, out);
endmodule

module VENT_NOR(in1, in2, out);
	input in1, in2;
	output out;
	wire w;

	supply1 vdd;
	supply0 gnd;

	nmos n1(out, gnd, in1);
	nmos n2(out, gnd, in2);
	pmos p1(w, vdd, in1);
	pmos p2(out, w, in2);
endmodule

module VENT_OR(in1, in2, out);
	input in1, in2;
	output out;
	wire w;

	VENT_NOR nor0(in1, in2, w);
	VENT_NOT not0(w, out);
endmodule

module ternary_min(a0, a1, b0, b1, out0, out1);
	input a0, a1, b0, b1;
	output out0, out1;
	wire nota1, notb1, notb0, nota0;
	wire an1, an2, an3, an4, an5, an6, an7, an8, an9;
	wire w1;

	VENT_AND and0(a1, b1, out1);

	VENT_NOT not0(a0, nota0);
	VENT_NOT not1(a1, nota1);
	VENT_NOT not2(b0, notb0);
	VENT_NOT not3(b1, notb1);

	VENT_AND and1(nota1, a0, an1);
	VENT_AND and2(notb1, an1, an2);
	VENT_AND and3(b0, an2, an3);

	VENT_AND and4(nota1, a0, an4);
	VENT_AND and5(b1, an4, an5);
	VENT_AND and6(notb0, an5, an6);

	VENT_AND and7(a1, nota0, an7);
	VENT_AND and8(notb1, an7, an8);
	VENT_AND and9(b0, an8, an9);

	VENT_OR or0(an3, an6, w1);
	VENT_OR or1(w1, an9, out0);
endmodule

module ternary_consensus(a0, a1, b0, b1, out0, out1);
	input a0, a1, b0, b1;
	output out0, out1;
	wire nota1, notb1;
	wire o1, o2, o3, o4, o5, o6;
	wire w1;

	VENT_AND and0(a1, b1, out1);

	VENT_NOT not0(a1, nota1);
	VENT_NOT not1(b1, notb1);

	VENT_OR or1(a1, a0, o1);
	VENT_OR or2(o1, b1, o2);
	VENT_OR or3(o2, b0, o3);

	VENT_OR or4(nota1, a0, o4);
	VENT_OR or5(o4, notb1, o5);
	VENT_OR or6(o5, b0, o6);

	VENT_AND and1(o3, o6, out0);
endmodule

module ternary_max(a0, a1, b0, b1, out0, out1);
	input a0, a1, b0, b1;
	output out0, out1;
	wire not_a0, not_a1, not_b0, not_b1;
	wire w1, w2, w3, w4, w5, w6;

	VENT_NOT not0(a0, not_a0);
	VENT_NOT not1(a1, not_a1);
	VENT_NOT not2(b0, not_b0);
	VENT_NOT not3(b1, not_b1);

	VENT_OR or0(a1, b1, out1);

	VENT_AND and0(a1, not_b1, w1);
	VENT_AND and1(not_a1, b1, w2);
	VENT_AND and2(a1, b1, w3);
	VENT_OR or1(w1, w2, w4);
	VENT_OR or2(w3, w4, out0);

endmodule


module ternary_any(a0, a1, b0, b1, out0, out1);
	input a0, a1, b0, b1;
	output out0, out1;

	VENT_OR or0(a1, b1, out1);
	VENT_OR or1(a0, b0, out0);
endmodule
