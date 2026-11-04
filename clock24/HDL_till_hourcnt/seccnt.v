/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章             */
/* project: CLOCK24           */
/* outline: 秒のカウンタ      */

module SECCNT(
    input CLK,RST,
    input EN1HZ,
    output reg [3:0] SECH,SECL,//regが必須
    output CASEC
);

always @(posedge CLK) begin
    if (RST) begin
        SECH <= 0;
        SECL <= 0;
    end
    // SECCLRを導入する
    else if (EN1HZ) begin
        SECL <= SECL + 1;
        if (SECL==9) begin
            SECH <= SECH + 1;
            SECL <= 0;
            if(SECH==5)
                SECH <= 0;
        end
    end
end

assign CASEC = (SECH==5) && (SECL==9) && EN1HZ;// and と書いてはいけない
// EN1HZによって、59になった瞬間に桁上がり信号を1パルスだけ生成する
// Q. 桁上がりしてほしい瞬間の1コマ前にCASEC=1になってしまわないか？
// assign で割り当ててるため、組み合わせ回路で瞬時に実行されそうだが、MINCNTに入ったときに、
// 数字のインクリメントのためのenable信号として働いてMINL,MINHが数字をバッファしてくれるので耐える。

endmodule