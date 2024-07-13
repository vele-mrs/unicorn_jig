/* ----------------------------------------------------------------------------
    Module : top_tb

    Author : Shun AOKI
---------------------------------------------------------------------------- */

`timescale 1ns / 100ps

module top_tb ;

    // Declaration
    reg         r_clk_100mhz    ;
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
    wire [7:0]  w_ja            ;

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


    // Encoder A B Z
    reg         r_enc_a = 0  ;
    reg         r_enc_b = 0  ;
    reg         r_enc_z = 0  ;

    reg [14:0]  r_enc_timer = 0     ; // 0~3600
    reg         r_cw                ; // 1:cw, 0:ccw

    initial
        r_cw = 0 ;
    always #(10000)
        r_cw <= ~r_cw ;

    always @(posedge r_clk_100mhz) begin
        
        if (r_enc_timer[14:3] == 12'd3599) begin
            r_enc_timer <= 0 ;
        end else begin
            r_enc_timer <= r_enc_timer + 1 ;
        end
        if (~r_cw) begin
            // Simulate CW
            if (r_enc_timer[4:2] == 2'b00) begin
                r_enc_a = 1'b1 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b01) begin
                r_enc_a = 1'b1 ;
                r_enc_b = 1'b1 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b10) begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b1 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b11) begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end else begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end

        end else begin
            // Simulate CCW
            if (r_enc_timer[4:2] == 2'b00) begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b1 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b01) begin
                r_enc_a = 1'b1 ;
                r_enc_b = 1'b1 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b10) begin
                r_enc_a = 1'b1 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end else if (r_enc_timer[4:2] == 2'b11) begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end else begin
                r_enc_a = 1'b0 ;
                r_enc_b = 1'b0 ;
                r_enc_z = 1'b0 ;
            end
        end


    end

        // if (A) begin
        //     {r_enc_z,r_enc_b,r_enc_a} = 2'b000;
        // end else if (B) begin
        //     {r_enc_z,r_enc_b,r_enc_a} = 2'b001;
        // end else if (Z) begin
        //     {r_enc_z,r_enc_b,r_enc_a} = 2'b010;
        // end else begin
        //     {r_enc_z,r_enc_b,r_enc_a} = 2'b000;
        // end



    assign w_ja[0]   = r_enc_a ;
    assign w_ja[1]   = r_enc_b ;
    assign w_ja[2]   = r_enc_z ;
    assign w_ja[7:3] = 5'b00000 ;


/* ----------------------------------------------------------------------------
    top module
---------------------------------------------------------------------------- */
    top top_inst (
         .I_CLK_100MHZ  (r_clk_100mhz   ) // input       
        ,.I_SW          (r_sw[3:0]      ) // input  [3:0]
        ,.I_BTN         (r_btn[3:0]     ) // input  [3:0]
        ,.I_JA          (w_ja[7:0]      ) // input  [3:0]
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