/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章             */
/* project: CLOCK24           */
/* outline: 分のカウンタ      */

module MINCNT(
    input CLK,RST,
    input MININC,
    input MININC_BUTTON,
    output reg [3:0] MINL,
    output reg [2:0] MINH,// 3bitの信号もコンパイル時のエラーなしで受け取れてしまう。
    output CAMIN
); //また忘れてるよ

always @(posedge CLK) begin
    if (RST) begin
        MINH <= 0;
        MINL <= 0;
    end
    else if (MININC | MININC_BUTTON) begin
        MINL <= MINL + 1;
        if (MINL==9) begin
            MINH <= MINH + 1;
            MINL <= 0;
            if(MINH==5)
                MINH <= 0;
        end
    end
end

assign CAMIN = MINL==9 && MINH==5 && MININC;

endmodule