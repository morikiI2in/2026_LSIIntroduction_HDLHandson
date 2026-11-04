// /* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
// /* chapter: 第3章                */
// /* project: CLOCK24              */
// /* outline: 制御用ステートマシン */

// module STATE(
//     input ADJUST, SELECT, MODE,
//     input SIG2HZ,
//     output SECON, MINON, HOURON,
//     output SECCLR, MININC, HOURINC
// );

// // parameter NORMAL,SEC,MIN,HOUR parameterはモジュールの外から値を変更できる固定値
// // 今回は内部で固定のパラメータでよいので localparam で宣言する
// localparam NORM=2'00, SEC=2'01, MIN=2'10, HOUR=2'11;

