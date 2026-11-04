/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章             */
/* project: CLOCK24           */
/* outline: 時のカウンタ      */

module HOURCNT(
    input CLK,RST,
    input HOURINC,
    input HOURINC_BUTTON,
    output reg [3:0] HOURL,
    output reg [1:0] HOURH
);

always @(posedge CLK) begin
    if (RST) begin
        HOURH <= 0;
        HOURL <= 0;
    end
    else if (HOURINC | HOURINC_BUTTON) begin
        HOURL <= HOURL + 1;
        if (HOURL==9) begin
            HOURH <= HOURH + 1;
            HOURL <= 0;
            if(HOURH==2)
                HOURH <= 0;
        end
        else if (HOURH==2 && HOURL==4) begin
            HOURH<=0;
            HOURL<=0;
        end
    end
end

endmodule