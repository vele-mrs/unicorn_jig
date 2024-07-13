/* ----------------------------------------------------------------------------
    Module : clock_enable_generator

    Author : vele-mrs
        https://github.com/vele-mrs
        https://www.youtube.com/@vele-mrs

    Description : 
        I_DIV = 100,000
        O_CE = I_CLK[Hz]/I_DIV = 100,000,000 / 100,000 = 1,000Hz
         _/‾\_/‾\_/‾ ~ _/‾\_/‾\_/‾  I_CLK 100,000,000Hz 
         _/‾\_______ ~ _/‾\_______  O_CE        1,000Hz
        * P_WIDTH is the bit width of P_DIV.
---------------------------------------------------------------------------- */

 module clock_enable_generator #(
         parameter  P_DIV     = 17'd100000 
        ,parameter  P_WIDTH   = 17         
    ) (
         input                  I_CLK
        ,input                  I_RST
        ,output                 O_CE
    ) ;


    // Declaration
    reg [P_WIDTH-1:0] r_cnt ;
    reg               r_ce  ;

   
    always @(posedge I_CLK) begin
        if (I_RST) begin
            r_cnt   <= {P_WIDTH{1'b0}} ;
            r_ce    <= 1'b0 ;
        end else begin
            if (r_cnt == P_DIV-1) begin
                r_cnt   <= {P_WIDTH{1'b0}} ;
                r_ce    <= 1'b1 ;
            end else begin
                r_cnt   <= r_cnt + { {(P_WIDTH-1){1'b0}} , 1'b1} ;
                r_ce    <= 1'b0 ;
            end
        end
    end


    assign O_CE = r_ce ;

endmodule