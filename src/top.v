/* ----------------------------------------------------------------------------
    Module : top _

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs
    
    Vivado : 2021.2
    Board : Arty A7
    FPGA : XC7A35TICSG324-1L (Artix-7)
    Flash Memory : S25FL127S (Spansion 128Mb)
---------------------------------------------------------------------------- */

module top (
         input          I_CLK_100MHZ
        ,input  [3:0]   I_SW
        ,input  [3:0]   I_BTN
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



endmodule
