/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章               */
/* project: CLOCK24             */
/* outline: 7セグメントデコーダ */

module SEG7DEC(
    // input CLK,RST,//SEG7DECは組み合わせ回路なのでCLK,RSTを利用する必要がない
    input [3:0] HEXNUM,//regをつけるな、inputportsはregを宣言できない
    input LIGHTON,
    output reg [6:0] HEXn// regを忘れるな
);// ;を忘れない

always @* begin
    if (LIGHTON) begin// 忘れるな
        case(HEXNUM)
            4'h0:  HEXn = 7'b1000000;//40(10)
            4'h1:  HEXn = 7'b1111001;//79(10)
            4'h2:  HEXn = 7'b0100100;//24
            4'h3:  HEXn = 7'b0110000;//30
            4'h4:  HEXn = 7'b0011001;//19
            4'h5:  HEXn = 7'b0010010;//12
            4'h6:  HEXn = 7'b0000010;//2
            4'h7:  HEXn = 7'b1011000;//58
            4'h8:  HEXn = 7'b0000000;//0
            4'h9:  HEXn = 7'b0010000;
            default: HEXn = 7'b1111111;// ;を忘れない
        endcase
    end
    else
        HEXn=7'b1111111;
end

endmodule//忘れるな