class transaction;

    rand bit w_en, r_en;
    rand bit [7:0] wdata;

    bit [7:0] rdata;
    bit full, empty;

endclass
