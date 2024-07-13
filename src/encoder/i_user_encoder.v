/* ----------------------------------------------------------------------------
    Module : i_user_encoder

    Author : Shun AOKI
    
    Description : 
        Input
            I_CLK_100MHZ        : Clock (100MHz)
            I_RST               : Reset (Act-H)

        Output

---------------------------------------------------------------------------- */

module i_user_encoder (
         input          I_CLK_100MHZ
        ,input          I_RST
        ,input          I_ENC_A
        ,input          I_ENC_B
        ,input          I_ENC_Z
    ) ;

    // Local Parameter
    parameter IDLE      = 3'b111    ;
    parameter STATE_00  = 3'b000    ;
    parameter STATE_0A  = 3'b001    ;
    parameter STATE_B0  = 3'b010    ;
    parameter STATE_BA  = 3'b011    ;
    parameter ROT_CW    = 1'b0      ;
    parameter ROT_CCW   = 1'b1      ;

    // Declaration
    reg [31:0]  r_cnt               ;
    reg [ 2:0]  r_state             ;
    reg         r_rot_dir           ;
    reg         r_enc_A             ;
    reg         r_enc_B             ;
    reg         r_enc_Z             ;
    reg         r_posedge_A         ;
    reg         r_posedge_B         ;
    reg         r_posedge_Z         ;
    reg         r_negedge_A         ;
    reg         r_negedge_B         ;
    reg         r_negedge_Z         ;
    reg [15:0]  r_dbg_posedge_cntA  ; 
    reg [15:0]  r_dbg_posedge_cntB  ; 
    reg [ 3:0]  r_dbg_posedge_cntZ  ; 
    reg [15:0]  r_dbg_negedge_cntA  ; 
    reg [15:0]  r_dbg_negedge_cntB  ; 
    reg [ 3:0]  r_dbg_negedge_cntZ  ; 

    // Initialize
    initial begin
        r_cnt                   = 32'd0     ;
        r_state                 = IDLE      ;
        r_rot_dir               = 1'b0      ;
        r_dbg_posedge_cntA      = 16'd0     ;
        r_dbg_posedge_cntB      = 16'd0     ;
        r_dbg_posedge_cntZ      =  4'd0     ;
        r_dbg_negedge_cntA      = 16'd0     ;
        r_dbg_negedge_cntB      = 16'd0     ;
        r_dbg_negedge_cntZ      =  4'd0     ;
    end


    always @ (posedge I_CLK_100MHZ) begin
        // Generate Edge Signal
        r_enc_A     <= I_ENC_A ;
        r_enc_B     <= I_ENC_B ;
        r_enc_Z     <= I_ENC_Z ;
        r_posedge_A <= I_ENC_A  & ~r_enc_A ;
        r_posedge_B <= I_ENC_B  & ~r_enc_B ;
        r_posedge_Z <= I_ENC_Z  & ~r_enc_Z ;
        r_negedge_A <= ~I_ENC_A & r_enc_A ;
        r_negedge_B <= ~I_ENC_B & r_enc_B ;
        r_negedge_Z <= ~I_ENC_Z & r_enc_Z ;
        
        // RESET
        if (I_RST) begin
            r_cnt   <= 0 ;
            r_state <= IDLE ;
        end

        // Sequence
        case(r_state)
            IDLE: begin
                if (r_enc_B & r_enc_A) begin
                    r_state <= STATE_00;
                end else if (r_enc_B & ~r_enc_A) begin
                    r_state <= STATE_0A;
                end else if (~r_enc_B & r_enc_A) begin
                    r_state <= STATE_B0;
                end else if (~r_enc_B & ~r_enc_A) begin
                    r_state <= STATE_BA;
                end
            end

            STATE_00: begin
                if (r_posedge_A) begin
                    r_state     <= STATE_0A ;
                    r_rot_dir   <= ROT_CW ;
                    r_cnt       <= r_cnt + 1 ;
                end
                if (r_posedge_B) begin
                    r_state     <= STATE_B0 ;
                    r_rot_dir   <= ROT_CCW ;
                    r_cnt       <= r_cnt - 1 ;
                end
            end

            STATE_0A: begin
                if (r_negedge_A) begin
                    r_state     <= STATE_00 ;
                    r_rot_dir   <= ROT_CCW ;
                    // r_cnt       <= r_cnt - 1 ;
                end
                if (r_posedge_B) begin
                    r_state     <= STATE_BA ;
                    r_rot_dir   <= ROT_CW ;
                    // r_cnt       <= r_cnt + 1 ;
                end
            end

            STATE_B0: begin
                if (r_posedge_A) begin
                    r_state     <= STATE_BA ;
                    r_rot_dir   <= ROT_CCW ;
                    // r_cnt       <= r_cnt - 1 ;
                end
                if (r_negedge_B) begin
                    r_state     <= STATE_00 ;
                    r_rot_dir   <= ROT_CW ;
                    // r_cnt       <= r_cnt + 1 ;
                end
            end

            STATE_BA: begin
                if (r_negedge_A) begin
                    r_state     <= STATE_B0 ;
                    r_rot_dir   <= ROT_CW ;
                    // r_cnt       <= r_cnt + 1 ;
                end
                if (r_negedge_B) begin
                    r_state     <= STATE_0A ;
                    r_rot_dir   <= ROT_CCW ;
                    // r_cnt       <= r_cnt - 1 ;
                end
            end

        endcase


        // Debug
        if (I_RST) begin
            r_dbg_posedge_cntA <= 0 ;
            r_dbg_posedge_cntB <= 0 ;
            r_dbg_posedge_cntZ <= 0 ;
            r_dbg_negedge_cntA <= 0 ;
            r_dbg_negedge_cntB <= 0 ;
            r_dbg_negedge_cntZ <= 0 ;

        end else begin
            if (r_posedge_A) begin
                r_dbg_posedge_cntA <= r_dbg_posedge_cntA + 1 ;
            end

            if (r_negedge_A) begin
                r_dbg_negedge_cntA <= r_dbg_negedge_cntA + 1 ;
            end

            if (r_posedge_B) begin
                r_dbg_posedge_cntB <= r_dbg_posedge_cntB + 1 ;
            end

            if (r_negedge_B) begin
                r_dbg_negedge_cntB <= r_dbg_negedge_cntB + 1 ;
            end

            if (r_posedge_Z) begin
                r_dbg_posedge_cntZ <= r_dbg_posedge_cntZ + 1 ;
            end

            if (r_negedge_Z) begin
                r_dbg_negedge_cntZ <= r_dbg_negedge_cntZ + 1 ;
            end
        end
    end







/* ----------------------------------------------------------------------------
    ILA (Integrated Logic Analyzer)
---------------------------------------------------------------------------- */
    ila_user_encoder ila_user_encoder_ip_inst (
         .clk           (I_CLK_100MHZ       )
        ,.probe0        (I_ENC_A            )
        ,.probe1        (I_ENC_B            )
        ,.probe2        (I_ENC_Z            )
        ,.probe3        (r_state            ) // input [2:0]
        ,.probe4        (r_cnt              ) // input [31:0]
        ,.probe5        (r_rot_dir          )
    ) ;

    vio_user_encoder vio_user_encoder_ip_inst (
         .clk           (I_CLK_100MHZ       )
        ,.probe_in0     (r_state            ) // input [ 2:0]
        ,.probe_in1     (r_cnt              ) // input [31:0]
        ,.probe_in2     (r_rot_dir          ) // input 
        ,.probe_in3     (r_dbg_posedge_cntA ) // input [15:0]
        ,.probe_in4     (r_dbg_negedge_cntA ) // input [15:0]
        ,.probe_in5     (r_dbg_posedge_cntB ) // input [15:0]
        ,.probe_in6     (r_dbg_negedge_cntB ) // input [15:0]
        ,.probe_in7     (r_dbg_posedge_cntZ ) // input [ 3:0]
        ,.probe_in8     (r_dbg_negedge_cntZ ) // input [ 3:0]
    ) ;

    





endmodule