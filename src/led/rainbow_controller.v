/* ----------------------------------------------------------------------------
    Module : rainbow_controller

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs

    Description : 
         _/\_/\_/\ O_DUTY_R
         \_/\_/\_/ O_DUTY_G
         /\_/\_/\_ O_DUTY_B
---------------------------------------------------------------------------- */

 module rainbow_controller (
         input          I_CLK_100MHZ
        ,input          I_CE_10KHZ
        ,input          I_RST
        ,input  [9:0]   I_TIMER
        ,input  [6:0]   I_BRIGHTNESS
        ,input          I_INVERTED
        ,output [6:0]   O_DUTY_R
        ,output [6:0]   O_DUTY_G
        ,output [6:0]   O_DUTY_B
    ) ;


    // Parameter
    parameter STATE_YELLOW  = 2'd0  ; 
    parameter STATE_CYAN    = 2'd1  ; 
    parameter STATE_MAGENTA = 2'd2  ; 

    // Declaration
    reg  [9:0]  r_timer_cnt     ;
    reg         r_timer         ;
    reg  [6:0]  r_duty_inc      ;
    reg  [6:0]  r_duty_dec      ;
    reg  [1:0]  r_state         ;
    reg  [6:0]  r_duty_r        ;
    reg  [6:0]  r_duty_g        ;
    reg  [6:0]  r_duty_b        ;


    always @(posedge I_CLK_100MHZ) begin
        // Timer
        if (I_RST) begin
            r_timer_cnt   <= 10'd0 ;
            r_timer       <= 1'b0 ;
        end else if (I_CE_10KHZ) begin
            if (r_timer_cnt == I_TIMER) begin
                r_timer_cnt   <= 10'd0 ;
                r_timer       <= 1'b1 ;
            end else begin
                r_timer_cnt   <= r_timer_cnt + 10'd1 ;
                r_timer       <= 1'b0 ;
            end
        end else begin
            r_timer_cnt   <= r_timer_cnt ; 
            r_timer       <= r_timer ;
        end


        // Duty Ratio Pulse (Increase/Decrease)
        if (I_RST) begin
            r_duty_inc   <= 7'd0 ;
            r_duty_dec   <= I_BRIGHTNESS ;
            r_state      <= 2'd0 ;
        end else if (I_CE_10KHZ & r_timer) begin
            if (r_duty_inc == I_BRIGHTNESS) begin
                r_duty_inc   <= 7'd0 ;
                r_duty_dec   <= I_BRIGHTNESS ;
                r_state      <= (r_state==2'd2) ? 2'd0 : r_state + 2'd1 ;
            end else begin
                r_duty_inc   <= r_duty_inc + 7'd1 ;
                r_duty_dec   <= r_duty_dec - 7'd1 ;
                r_state      <= r_state ;
            end
        end else begin
            r_duty_inc   <= r_duty_inc ; 
            r_duty_dec   <= r_duty_dec ; 
            r_state      <= r_state ;
        end


        // RGB Duty Ratio Control
        case (r_state)
            STATE_YELLOW  : 
                begin
                    r_duty_r <= (I_INVERTED) ? r_duty_inc : r_duty_dec ; 
                    r_duty_g <= (I_INVERTED) ? r_duty_dec : r_duty_inc ; 
                    r_duty_b <= (I_INVERTED) ? 0          : 0          ; 
                end  
            STATE_CYAN  : 
                begin
                    r_duty_r <= (I_INVERTED) ? r_duty_dec : 0          ; 
                    r_duty_g <= (I_INVERTED) ? 0          : r_duty_dec ; 
                    r_duty_b <= (I_INVERTED) ? r_duty_inc : r_duty_inc ; 
                end  
            STATE_MAGENTA  : 
                begin
                    r_duty_r <= (I_INVERTED) ? 0          : r_duty_inc ; 
                    r_duty_g <= (I_INVERTED) ? r_duty_inc : 0          ; 
                    r_duty_b <= (I_INVERTED) ? r_duty_dec : r_duty_dec ; 
                end  
            default : 
                begin
                    r_duty_r <= 0 ; 
                    r_duty_g <= 0 ; 
                    r_duty_b <= 0 ; 
                end  
        endcase


    end


    assign O_DUTY_R = r_duty_r ;
    assign O_DUTY_G = r_duty_g ;
    assign O_DUTY_B = r_duty_b ;


endmodule