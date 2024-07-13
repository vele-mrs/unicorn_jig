/* ----------------------------------------------------------------------------
    Module : top _

    Author : Shun AOKI
    
    Vivado : 2021.2
    Board : Arty A7
    FPGA : XC7A35TICSG324-1L (Artix-7)
    Flash Memory : S25FL127S (Spansion 128Mb)
---------------------------------------------------------------------------- */

module top (
         input          I_CLK_100MHZ
        ,input  [3:0]   I_SW
        ,input  [3:0]   I_BTN
        ,input  [7:0]   I_JA
        ,output [3:0]   O_LED
        ,output         O_LED0_B
        ,output         O_LED0_G
        ,output         O_LED0_R
        ,output         O_LED1_B
        ,output         O_LED1_G
        ,output         O_LED1_R
        ,output         O_LED2_B
        ,output         O_LED2_G
        ,output         O_LED2_R
        ,output         O_LED3_B
        ,output         O_LED3_G
        ,output         O_LED3_R
    ) ;

    // Declaration
    wire w_user_rst ;
    wire w_enc_a ;
    wire w_enc_b ;
    wire w_enc_z ;
    wire w_enc_a_clean ;
    wire w_enc_b_clean ;
    wire w_enc_z_clean ;

/* ----------------------------------------------------------------------------
    USER RESET
---------------------------------------------------------------------------- */
    assign w_user_rst = I_BTN[0] ;

/* ----------------------------------------------------------------------------
    io_user_leds
---------------------------------------------------------------------------- */
    io_user_leds io_user_leds_inst (
         .I_CLK_100MHZ  (I_CLK_100MHZ                   ) // input 
        ,.I_RST         (w_user_rst                     ) // input 
        ,.O_LED         (O_LED                          ) // output [3:0]   
        ,.O_LED0_B      (O_LED0_B                       ) // output         
        ,.O_LED0_G      (O_LED0_G                       ) // output         
        ,.O_LED0_R      (O_LED0_R                       ) // output         
        ,.O_LED1_B      (O_LED1_B                       ) // output         
        ,.O_LED1_G      (O_LED1_G                       ) // output         
        ,.O_LED1_R      (O_LED1_R                       ) // output         
        ,.O_LED2_B      (O_LED2_B                       ) // output         
        ,.O_LED2_G      (O_LED2_G                       ) // output         
        ,.O_LED2_R      (O_LED2_R                       ) // output         
        ,.O_LED3_B      (O_LED3_B                       ) // output         
        ,.O_LED3_G      (O_LED3_G                       ) // output         
        ,.O_LED3_R      (O_LED3_R                       ) // output         
    ) ;


/* ----------------------------------------------------------------------------
    incremental_encoder
---------------------------------------------------------------------------- */
    assign w_enc_a = I_JA[0] ; 
    assign w_enc_b = I_JA[1] ; 
    assign w_enc_z = I_JA[2] ; 

    debouncer debouncer_enc_a (
         .clk           (I_CLK_100MHZ                   ) // input
        ,.reset         (w_user_rst                     ) // input
        ,.noisy_in      (w_enc_a                        ) // input
        ,.clean_out     (w_enc_a_clean                  ) // output
    ) ;
    debouncer debouncer_enc_b (
         .clk           (I_CLK_100MHZ                   ) // input
        ,.reset         (w_user_rst                     ) // input
        ,.noisy_in      (w_enc_b                        ) // input
        ,.clean_out     (w_enc_b_clean                  ) // output
    ) ;
    debouncer debouncer_enc_z (
         .clk           (I_CLK_100MHZ                   ) // input
        ,.reset         (w_user_rst                     ) // input
        ,.noisy_in      (w_enc_z                        ) // input
        ,.clean_out     (w_enc_z_clean                  ) // output
    ) ;


    i_user_encoder i_user_encoder_inst (
         .I_CLK_100MHZ  (I_CLK_100MHZ                   ) // input 
        ,.I_RST         (w_user_rst                     ) // input 
        ,.I_ENC_A       (w_enc_a_clean                  ) // input 
        ,.I_ENC_B       (w_enc_b_clean                  ) // input 
        ,.I_ENC_Z       (w_enc_z_clean                  ) // input 
    ) ;


/* ----------------------------------------------------------------------------
    ILA (Integrated Logic Analyzer)
---------------------------------------------------------------------------- */
    // ila_user_input ila_user_input_ip_inst (
    //      .clk           (I_CLK_100MHZ       )
    //     ,.probe0        (I_JA               ) // [7:0]
    // ) ;

endmodule
