/* ----------------------------------------------------------------------------
    Module : debouncer

    Author : GPT-4o

    Description : 
---------------------------------------------------------------------------- */

module debouncer (
    input wire clk,         // クロック信号
    input wire reset,       // リセット信号
    input wire noisy_in,    // チャタリングのある入力信号
    output reg clean_out    // デバウンスされた出力信号
);

    parameter DEBOUNCE_TIME = 20;           // デバウンス時間（クロック周期）
    reg [24:0] counter;                     // カウンタ
    reg stable_in;                          // 安定した入力信号

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            stable_in <= noisy_in;
            clean_out <= noisy_in;
        end else begin
            if (noisy_in != stable_in) begin
                counter <= 0;  // カウンタリセット
                stable_in <= noisy_in;
            end else begin
                if (counter == DEBOUNCE_TIME) begin
                    clean_out <= stable_in;  // 出力信号更新
                end else begin
                    counter <= counter + 1;  // カウントアップ
                end
            end
        end
    end

endmodule
