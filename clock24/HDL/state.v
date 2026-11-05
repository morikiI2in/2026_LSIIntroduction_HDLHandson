// /* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
// /* chapter: 第3章                */
// /* project: CLOCK24              */
// /* outline: 制御用ステートマシン */

module STATE(
    input CLK, RST, SIG2HZ,
    input MODE, SELECT, ACTION,
    output SECON, MINON, HOURON,
    output SECCLR, MININC, HOURINC
);

reg [1:0] s;
localparam NORM=2'b00, SEC=2'b01, MIN=2'b10, HOUR=2'b11;
// parameter NORMAL,SEC,MIN,HOUR parameterはモジュールの外から値を変更できる固定値
// 今回は内部で固定のパラメータでよいので localparam で宣言する

always @(posedge CLK) begin // beginを忘れないように、CLKに同期させるとうまくいくようになった、、、なぜ
    if (RST)
        s<=NORM;
    else begin
        case (s)
            NORM    :   if (MODE)
                            s<=SEC;
                        else
                            s<=NORM;
            SEC     :   if (MODE)
                            s<=NORM;
                        else if(SELECT)
                            s<=MIN;
                        else
                            s<=SEC;
            MIN     :   if (MODE)
                            s<=NORM;
                        else if(SELECT)
                            s<=HOUR;
                        else
                            s<=MIN;
            HOUR    :   if (MODE)
                            s<=NORM;
                        else if (SELECT)
                            s<=SEC;
                        else
                            s<=HOUR;
        endcase
    end
end

assign SECON = ~((s==SEC) && ~SIG2HZ);
assign MINON = ~((s==MIN) && ~SIG2HZ);
assign HOURON = ~((s==HOUR) && ~SIG2HZ);
assign SECCLR = (s==SEC) && ACTION;
assign MININC = (s==MIN) && ACTION;
assign HOURINC = (s==HOUR) && ACTION; 

endmodule // 忘れるな