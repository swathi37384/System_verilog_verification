// Code your design here
//memory block
module memory(input wclk,rclk,
input w_en,r_en,
input [2:0]w_add,r_add,
input [7:0]wdata,
output reg [7:0]rdata);

reg [7:0]mem[0:7];

always@(posedge wclk)begin
if(w_en)
	mem[w_add]<=wdata;
end

always@(posedge rclk)begin
if(r_en)
	rdata<=mem[r_add];
end

endmodule


//write pointer handler

module write_handler(
    input wclk, w_rst,
    input w_en,
    input [3:0] r_gray_sync,
    output reg [3:0] w_bi_ptr,
    output reg [3:0] w_gray_ptr,
    output reg wfull
);

reg [3:0] r_bi_sync;
wire [3:0] w_bi_ptr_temp;

always @(*) begin
    r_bi_sync[3] = r_gray_sync[3];
    r_bi_sync[2] = r_bi_sync[3] ^ r_gray_sync[2];
    r_bi_sync[1] = r_bi_sync[2] ^ r_gray_sync[1];
    r_bi_sync[0] = r_bi_sync[1] ^ r_gray_sync[0];
end

assign w_bi_ptr_temp = w_bi_ptr + (w_en && !wfull);

always @(posedge wclk or negedge w_rst) begin
    if(!w_rst) begin
        w_bi_ptr <= 0;
        w_gray_ptr <= 0;
        wfull <= 0;
    end
    else begin
        w_bi_ptr <= w_bi_ptr_temp;
        w_gray_ptr <= (w_bi_ptr_temp >> 1) ^ w_bi_ptr_temp;

        wfull <= (w_bi_ptr_temp[2:0] == r_bi_sync[2:0]) &&
                 (w_bi_ptr_temp[3] != r_bi_sync[3]);
    end
end

endmodule

// read pointer handler

module read_handler(
    input rclk,
    input r_en,
    input r_rst,
    input [3:0] w_gray_sync,
    output reg [3:0] r_bi_ptr,
    output reg [3:0] r_gray_ptr,
    output reg rempty
);

reg [3:0] w_bi_sync;
wire [3:0] r_bi_ptr_temp;

always @(*) begin
    w_bi_sync[3] = w_gray_sync[3];
    w_bi_sync[2] = w_bi_sync[3] ^ w_gray_sync[2];
    w_bi_sync[1] = w_bi_sync[2] ^ w_gray_sync[1];
    w_bi_sync[0] = w_bi_sync[1] ^ w_gray_sync[0];
end

assign r_bi_ptr_temp = r_bi_ptr + (r_en && !rempty);

always @(posedge rclk or negedge r_rst) begin
    if(!r_rst) begin
        r_bi_ptr <= 0;
        r_gray_ptr <= 0;
        rempty <= 1;
    end
    else begin
        r_bi_ptr <= r_bi_ptr_temp;
        r_gray_ptr <= (r_bi_ptr_temp >> 1) ^ r_bi_ptr_temp;

        rempty <= (r_bi_ptr_temp == w_bi_sync);
    end
end

endmodule

//synchronizer
module synchronizer(input clk,
	input rst,
	input [3:0]gray_ptr,
	output reg[3:0]gray_sync);

reg [3:0]sync_ff1;

always@(posedge clk or negedge rst)begin
	if(!rst)begin
		sync_ff1<=4'd0;
		gray_sync<=4'd0;
	end
	else begin
		sync_ff1<=gray_ptr;
		gray_sync<=sync_ff1;
	end
end
endmodule


//top module

module async_fifo(input wclk,rclk,
	input w_en,r_en,
	input w_rst,r_rst,
	input [7:0]wdata,
	output  [7:0]rdata,
	output  wfull,
	output  rempty);

wire [3:0]w_bi_ptr;
wire [3:0]w_gray_ptr;
wire [3:0]w_gray_sync;

wire [3:0]r_bi_ptr;
wire [3:0]r_gray_ptr;
wire [3:0]r_gray_sync;

write_handler write(.wclk(wclk),
	.w_rst(w_rst),
	.w_en(w_en),
	.r_gray_sync(r_gray_sync),
	.w_bi_ptr(w_bi_ptr),
	.w_gray_ptr(w_gray_ptr),
	.wfull(wfull));

read_handler read(.rclk(rclk),
        .r_rst(r_rst),
        .r_en(r_en),
        .w_gray_sync(w_gray_sync),
        .r_bi_ptr(r_bi_ptr),
        .r_gray_ptr(r_gray_ptr),
        .rempty(rempty));

synchronizer sync_rptr(.clk(wclk),
	.rst(w_rst),
	.gray_ptr(r_gray_ptr),
	.gray_sync(r_gray_sync));

synchronizer sync_wptr(.clk(rclk),
        .rst(r_rst),
        .gray_ptr(w_gray_ptr),
        .gray_sync(w_gray_sync));

wire w_ena,r_ena;
assign w_ena=w_en && !wfull;
assign r_ena=r_en && !rempty;

memory mem(.wclk(wclk),
	.rclk(rclk),
	.w_en(w_ena),
	.w_add(w_bi_ptr[2:0]),
	.wdata(wdata),
	.r_en(r_ena),
	.r_add(r_bi_ptr[2:0]),
	.rdata(rdata));

endmodule
