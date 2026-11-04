/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章                  */
/* project: CLOCK24                */
/* outline: 1Hzおよび2Hz信号の作成 */

module CNT1SEC(
    input CLK,RST,
    output reg SIG2HZ,
    output EN1HZ
);//;を忘れないように

reg [25:0] cnt1sec;

assign EN1HZ = (cnt1sec == 49_999_999);//左辺はwireのみ

always @(posedge CLK) begin
    if(RST) begin//2行以上の処理は begin ~ end で囲む
        cnt1sec <= 0;
        SIG2HZ <= 0;
    end
    else if(cnt1sec == 49_999_999) begin
        cnt1sec <= 0;
        SIG2HZ <= ~SIG2HZ;
    end
    else
        cnt1sec <= cnt1sec + 1;
end

endmodule