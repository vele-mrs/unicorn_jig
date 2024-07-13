/* ----------------------------------------------------------------------------
    Module : top_tb

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs
---------------------------------------------------------------------------- */

`timescale 1ns / 100ps

module top_tb ;

    // Declaration
    reg         r_clk_100mhz     ;
    reg  [3:0]  r_sw            ;
    reg  [3:0]  r_btn           ;

    wire [3:0]  w_led           ; 
    wire        w_led0_b        ; 
    wire        w_led0_g        ; 
    wire        w_led0_r        ; 
    wire        w_led1_b        ; 
    wire        w_led1_g        ; 
    wire        w_led1_r        ; 
    wire        w_led2_b        ; 
    wire        w_led2_g        ; 
    wire        w_led2_r        ; 
    wire        w_led3_b        ; 
    wire        w_led3_g        ; 
    wire        w_led3_r        ; 

    // 100MHz Clock
    initial
        r_clk_100mhz = 0 ;
    always #(5)
        r_clk_100mhz <= ~r_clk_100mhz ;



    // Switch
    initial fork
        #0      r_sw[3:0]  = 4'b1111 ;
        #0      r_btn[3:0] = 4'b0001 ;
        #100    r_btn[3:0] = 4'b0000 ;
    join

/* ----------------------------------------------------------------------------
    top module
---------------------------------------------------------------------------- */
    top top_inst (
         .I_CLK_100MHZ  (r_clk_100mhz   ) // input       
        ,.I_SW          (r_sw[3:0]      ) // input  [3:0]
        ,.I_BTN         (r_btn[3:0]     ) // input  [3:0]
        ,.O_LED         (w_led[3:0]     ) // output [3:0]
        ,.O_LED0_B      (w_led0_b       ) // output      
        ,.O_LED0_G      (w_led0_g       ) // output      
        ,.O_LED0_R      (w_led0_r       ) // output      
        ,.O_LED1_B      (w_led1_b       ) // output      
        ,.O_LED1_G      (w_led1_g       ) // output      
        ,.O_LED1_R      (w_led1_r       ) // output      
        ,.O_LED2_B      (w_led2_b       ) // output      
        ,.O_LED2_G      (w_led2_g       ) // output      
        ,.O_LED2_R      (w_led2_r       ) // output      
        ,.O_LED3_B      (w_led3_b       ) // output      
        ,.O_LED3_G      (w_led3_g       ) // output      
        ,.O_LED3_R      (w_led3_r       ) // output      
    ) ;


endmodule