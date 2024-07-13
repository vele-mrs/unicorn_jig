/* ----------------------------------------------------------------------------
    Module : io_user_leds

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs
    
    Description : 
        Input
            I_CLK_100MHZ        : Clock (100MHz)
            I_RST               : Reset (Act-H)
            w_vio_inverted      : Transition Mode
            w_vio_brightness    : PWM Duty Cycle
            w_vio_timer         : Transition Speed

        Output
            O_LED[0] : Reset (ON:Reset)
            O_LED[1] : Transition Mode (ON:Normal)
            O_LED*_* : Rainbow RGB PWM

---------------------------------------------------------------------------- */

module io_user_leds (
         input          I_CLK_100MHZ
        ,input          I_RST
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


/* ----------------------------------------------------------------------------
    Declaration
---------------------------------------------------------------------------- */
    parameter                   P_MODULE_NUM = 12   ;
    genvar                      i                   ;
    
    wire                        w_ce_10khz          ;
    wire                        w_ce_100hz          ;
    wire [               6:0]   w_duty_r            ;
    wire [               6:0]   w_duty_g            ;
    wire [               6:0]   w_duty_b            ;

    wire [               9:0]   w_vio_timer         ; 
    wire [               6:0]   w_vio_brightness    ; 
    wire                        w_vio_inverted      ; 

    wire [P_MODULE_NUM    :0]   w_pulse             ;
    wire [P_MODULE_NUM*7-1:0]   w_duty              ;


/* ----------------------------------------------------------------------------
    clock_enable_generator
    100MHz -> 1KHz
---------------------------------------------------------------------------- */
    clock_enable_generator #(
         .P_DIV             (12'd10000                  ) //        O_CLK_ENABLE = I_CLK / P_DIV = 100,000,000Hz/10,000 = 10,000Hz 
        ,.P_WIDTH           (12                         ) //        the bit width of P_DIV
    ) clock_enable_generator_inst_10khz (
         .I_CLK             (I_CLK_100MHZ               ) // input  100,000,000Hz
        ,.I_RST             (I_RST                      ) // input 
        ,.O_CE              (w_ce_10khz                 ) // output 1KHz
    ) ;


/* ----------------------------------------------------------------------------
    rainbow_controller
---------------------------------------------------------------------------- */
    rainbow_controller rainbow_controller_inst (
         .I_CLK_100MHZ  (I_CLK_100MHZ               ) // input          100MHz Clock
        ,.I_CE_10KHZ    (w_ce_10khz                 ) // input          10KHz Clock Enable
        ,.I_RST         (I_RST                      ) // input          RESET
        ,.I_TIMER       (w_vio_timer                ) // input  [9:0]   
        ,.I_BRIGHTNESS  (w_vio_brightness           ) // input  [6:0]   
        ,.I_INVERTED    (w_vio_inverted             ) // input          0:Normal , 1:Inverted color transition
        ,.O_DUTY_R      (w_duty_r                   ) // output [6:0] 
        ,.O_DUTY_G      (w_duty_g                   ) // output [6:0] 
        ,.O_DUTY_B      (w_duty_b                   ) // output [6:0] 
    ) ;


/* ----------------------------------------------------------------------------
    pwm_controller
---------------------------------------------------------------------------- */
    assign w_duty = {   w_duty_r,w_duty_g,w_duty_b,
                        w_duty_g,w_duty_b,w_duty_r,
                        w_duty_b,w_duty_r,w_duty_g,
                        w_duty_r,w_duty_g,w_duty_b} ;

    generate
        for(i = 0; i < P_MODULE_NUM; i = i + 1) begin: GenerateUserLEDs
            pwm_controller pwm_controller_inst (
                 .I_CLK_100MHZ  (I_CLK_100MHZ               ) // input          100MHz Clock
                ,.I_CE_10KHZ    (w_ce_10khz                 ) // input          10KHz Clock Enable
                ,.I_RST         (I_RST                      ) // input          RESET
                ,.I_DUTY        (w_duty[(i+1)*7-1:i*7]      ) // input  [6:0]   Duty Ratio 0 ~ 100[%]
                ,.O_PULSE       (w_pulse[i]                 ) // output
            ) ;
        end
    endgenerate

    assign O_LED0_B = w_pulse[ 0] ; 
    assign O_LED0_G = w_pulse[ 1] ; 
    assign O_LED0_R = w_pulse[ 2] ; 
    assign O_LED1_B = w_pulse[ 3] ; 
    assign O_LED1_G = w_pulse[ 4] ; 
    assign O_LED1_R = w_pulse[ 5] ; 
    assign O_LED2_B = w_pulse[ 6] ; 
    assign O_LED2_G = w_pulse[ 7] ; 
    assign O_LED2_R = w_pulse[ 8] ; 
    assign O_LED3_B = w_pulse[ 9] ; 
    assign O_LED3_G = w_pulse[10] ; 
    assign O_LED3_R = w_pulse[11] ; 


/* ----------------------------------------------------------------------------
    status
---------------------------------------------------------------------------- */

    assign O_LED[0] = I_RST ; 
    assign O_LED[1] = w_vio_inverted ; 
    assign O_LED[2] = 1'b0 ; 
    assign O_LED[3] = 1'b0 ; 

/* ----------------------------------------------------------------------------
    VIO (Virtual Input/Output)
---------------------------------------------------------------------------- */
    vio_user_leds vio_user_leds_ip_inst (
        .clk            (I_CLK_100MHZ           )
        ,.probe_out0    (w_vio_timer[9:0]       ) // [9:0] init:0x0FF
        ,.probe_out1    (w_vio_brightness[6:0]  ) // [6:0] init:0x32
        ,.probe_out2    (w_vio_inverted         ) //       init:0x0 (Normal Mode)
    ) ;

/* ----------------------------------------------------------------------------
    ILA (Integrated Logic Analyzer)
---------------------------------------------------------------------------- */
    ila_user_leds ila_user_leds_ip_inst (
         .clk           (I_CLK_100MHZ       )
        ,.probe0        (O_LED0_B           )
        ,.probe1        (O_LED0_G           )
        ,.probe2        (O_LED0_R           )
        ,.probe3        (O_LED1_B           )
        ,.probe4        (O_LED1_G           )
        ,.probe5        (O_LED1_R           )
        ,.probe6        (O_LED2_B           )
        ,.probe7        (O_LED2_G           )
        ,.probe8        (O_LED2_R           )
        ,.probe9        (O_LED3_B           )
        ,.probe10       (O_LED3_G           )
        ,.probe11       (O_LED3_R           )
    ) ;


endmodule