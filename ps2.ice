algorithm main(input uint28 gn, input uint1 us2_bd_dn, input uint1 us2_bd_dp, output uint28 gp, output uint$NUM_LEDS$ leds) {
  uint8 clk_filter = 8hff;
  uint1 ps2_clk_in = 1;
  uint1 ps2_dat_in = 1;
  uint1 clk_edge = 0;

  uint4 bit_count = 0;
  uint9 shift_reg = 0;
  uint1 parity = 0;
  uint1 error = 0;
  uint1 valid = 0;

  uint8 data = 0;

  leds := data;

  while(1) {
    // Filter the PS/2 clock
    ps2_dat_in = us2_bd_dn;
    clk_edge = 0;
    clk_filter = {us2_bd_dp, clk_filter[1,7]};
    
    if (clk_filter == 8hff) {
      ps2_clk_in = 1;
    } else {
      if (clk_filter == 0) {
        if (ps2_clk_in) {
          clk_edge = 1;
        }
        ps2_clk_in = 0;
      }
    }

    // Shift in the data
    valid = 0;
    error = 0;

    if (clk_edge) {
      if (bit_count == 0) {
        parity = 0;
        if (!ps2_dat_in) {
          bit_count = bit_count + 1; // Start bit
        }
      } else {
        if (bit_count < 10) {
          bit_count = bit_count + 1;
          shift_reg = {ps2_dat_in, shift_reg[1,8]};
          parity = parity ^ ps2_dat_in;
        } else {
          if (ps2_dat_in) {
            bit_count = 0;
            if (parity) {
              data = shift_reg[0,8];
              valid = 1;
            } else {
              error = 1;
            }
          } else {
            error = 1;
            bit_count = 0;
          }
        }
      }    
    } 
  }
}

