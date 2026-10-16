// Binary input -> BCD output
//assumes bin <= 999

module bin2bcd (
    input [11:0]  bin,
    input clk, reset,
    output reg  [3:0] hundreds, tens, ones
);

    reg [23:0] shift; // internal regg
    integer  i; // loop counter


always @(*) begin
    shift = {12'b0, bin};

    for (i = 0; i < 12; i = i + 1) begin
        if (shift[23:20] >= 5) shift[23:20] = shift[23:20] + 3;
        if (shift[19:16] >= 5) shift[19:16] = shift[19:16] + 3;
        if (shift[15:12] >= 5) shift[15:12] = shift[15:12] + 3;
        shift = shift << 1;
    end

end

always @(posedge clk) begin
    if (reset) begin
        hundreds <= 4'b0;
        tens <= 4'b0;
        ones <= 4'b0;
end
    else begin
    hundreds <= shift[23:20];
    tens <= shift[19:16];
    ones <= shift[15:12];
end
end
 

endmodule