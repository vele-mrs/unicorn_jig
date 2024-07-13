/* ----------------------------------------------------------------------------
    Module : pwm_controller

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs

    Description : 
        I_DUTY=50
          <--->        r_duty  
          <-------->   r_cnt   0~99
         _/‾‾‾‾\____/‾ O_PULSE 
    
        I_DUTY=80
          <------>     r_duty  
          <-------->   r_cnt   0~99
         _/‾‾‾‾‾‾‾\_/‾ O_PULSE 
---------------------------------------------------------------------------- */

 module pwm_controller (
         input          I_CLK_100MHZ
        ,input          I_CE_10KHZ
        ,input          I_RST
        ,input  [6:0]   I_DUTY
        ,output         O_PULSE
    ) ;


    // Declaration
    reg  [6:0]  r_cnt   ;
    reg  [6:0]  r_duty  ;
    reg         r_pulse ;

    // Initialize
    initial begin
        r_cnt       = 7'd0 ;
        r_duty      = 7'd0 ;
        r_pulse     = 1'b0 ;
    end


    // Counts up only when Clock Enable is enabled.
    // Duty ratio is updated when count is reset.
    always @(posedge I_CLK_100MHZ) begin
        if (I_RST) begin
            r_pulse <= 1'b0 ;
            r_cnt   <= 7'd0 ;
        end else if (I_CE_10KHZ) begin
            if (r_cnt == 7'd99) begin
                r_pulse <= 1'b1 ;
                r_cnt   <= 7'd0 ;
                r_duty  <= I_DUTY ;
            end else if (r_cnt == r_duty - 7'd1) begin
                r_pulse <= 1'b0 ;
                r_cnt   <= r_cnt + 7'd1 ;
            end else begin
                r_pulse <= r_pulse ;
                r_cnt   <= r_cnt + 7'd1 ;
            end
        end else begin
            r_pulse <= r_pulse ;
            r_cnt   <= r_cnt ; 
        end
    end

    // No output when duty ratio is 0%.
    assign O_PULSE = (I_DUTY==7'd0) ? 1'b0 : r_pulse ;

endmodule