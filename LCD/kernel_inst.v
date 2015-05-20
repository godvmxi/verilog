  //Example instantiation for system 'kernel'
  kernel kernel_inst
    (
      .clk                            (clk),
      .data0_to_the_epcs              (data0_to_the_epcs),
      .dclk_from_the_epcs             (dclk_from_the_epcs),
      .out_port_from_the_PIO_LCD_B    (out_port_from_the_PIO_LCD_B),
      .out_port_from_the_PIO_LCD_CLK  (out_port_from_the_PIO_LCD_CLK),
      .out_port_from_the_PIO_LCD_CTRL (out_port_from_the_PIO_LCD_CTRL),
      .out_port_from_the_PIO_LCD_G    (out_port_from_the_PIO_LCD_G),
      .out_port_from_the_PIO_LCD_PWM  (out_port_from_the_PIO_LCD_PWM),
      .out_port_from_the_PIO_LCD_R    (out_port_from_the_PIO_LCD_R),
      .out_port_from_the_PIO_LED      (out_port_from_the_PIO_LED),
      .reset_n                        (reset_n),
      .rxd_to_the_RS232               (rxd_to_the_RS232),
      .sce_from_the_epcs              (sce_from_the_epcs),
      .sdo_from_the_epcs              (sdo_from_the_epcs),
      .txd_from_the_RS232             (txd_from_the_RS232),
      .zs_addr_from_the_sdram         (zs_addr_from_the_sdram),
      .zs_ba_from_the_sdram           (zs_ba_from_the_sdram),
      .zs_cas_n_from_the_sdram        (zs_cas_n_from_the_sdram),
      .zs_cke_from_the_sdram          (zs_cke_from_the_sdram),
      .zs_cs_n_from_the_sdram         (zs_cs_n_from_the_sdram),
      .zs_dq_to_and_from_the_sdram    (zs_dq_to_and_from_the_sdram),
      .zs_dqm_from_the_sdram          (zs_dqm_from_the_sdram),
      .zs_ras_n_from_the_sdram        (zs_ras_n_from_the_sdram),
      .zs_we_n_from_the_sdram         (zs_we_n_from_the_sdram)
    );

