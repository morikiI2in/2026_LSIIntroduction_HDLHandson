/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章                        */
/* project: CLOCK24                      */
/* outline: 時刻あわせ機能つき24時間時計 */

module CLOCK24(
    input CLK,RST,
    input [2:0] KEY,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5//[6:0]を忘れてたよ、ｱﾎか
);

wire [2:0] BOUT;
wire [3:0] SECL;
wire [2:0] SECH;
wire [3:0] MINL;//記述忘れ、記述忘れても動いてしまう!?値は適当な値が入って誤動作する、、、なんてこった
wire [2:0] MINH;//記述忘れ、記述忘れても動いてしまう!?値は適当な値が入って誤動作する、、、なんてこった
wire [3:0] HOURL;
wire [1:0] HOURH; 
wire CASEC;
wire CAMIN;
wire SECCLR, MININC, HOURINC;
wire SECON, MINON, HOURON;
// assign KEY = ~KEY;//ここがエラーになってる、、、 

BTN_IN BTN_IN(.CLK(CLK), .RST(RST), .nBIN(KEY), .BOUT(BOUT));
CNT1SEC CNT1SEC(.CLK(CLK), .RST(RST), .SIG2HZ(SIG2HZ), .EN1HZ(EN1HZ));
SECCNT SECCNT(.CLK(CLK), .RST(RST), .EN1HZ(EN1HZ), .SECCLR(SECCLR), .SECL(SECL), .SECH(SECH), .CASEC(CASEC));
MINCNT MINCNT(.CLK(CLK), .RST(RST), .MININC(CASEC), .MININC_BUTTON(MININC), .MINL(MINL), .MINH(MINH), .CAMIN(CAMIN));
HOURCNT HOURCNT(.CLK(CLK), .RST(RST), .HOURINC(CAMIN), .HOURINC_BUTTON(HOURINC), .HOURL(HOURL), .HOURH(HOURH));

STATE STATE(.CLK(CLK), .RST(RST), .SIG2HZ(SIG2HZ),
            .MODE(BOUT[2]), .SELECT(BOUT[1]), .ACTION(BOUT[0]),
            .SECON(SECON), .MINON(MINON), .HOURON(HOURON),
            .SECCLR(SECCLR), .MININC(MININC), .HOURINC(HOURINC));

SEG7DEC SECL7DEC(.HEXNUM(SECL), .LIGHTON(SECON), .HEXn(HEX0));
SEG7DEC SECH7DEC(.HEXNUM(SECH), .LIGHTON(1), .HEXn(HEX1));
SEG7DEC MINL7DEC(.HEXNUM(MINL), .LIGHTON(1), .HEXn(HEX2));
SEG7DEC MINH7DEC(.HEXNUM(MINH), .LIGHTON(1), .HEXn(HEX3));
SEG7DEC HOURL7DEC(.HEXNUM(HOURL), .LIGHTON(1), .HEXn(HEX4));
SEG7DEC HOURH7DEC(.HEXNUM(HOURH), .LIGHTON(1), .HEXn(HEX5));

endmodule