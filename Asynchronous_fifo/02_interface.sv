interface asyn_fifo(input bit wr_clk, input bit rd_clk);

    logic w_rst, r_rst;
    logic wr_en, rd_en;

    logic [7:0] wr_data;
    logic [7:0] rd_data;

    logic full, empty;

endinterface
