module half_adder (
  output wire sum,
  output wire del_carry,

  input wire  clk,
  input wire  a,
  input wire  b
  );

  wire carry;

  delay #(.INTERVAL(1)) del (
    .out (del_carry),

    .clk (clk),
    .in  (carry)
    );

  assign sum   = a ^ b;
  assign carry = a & b;

endmodule
