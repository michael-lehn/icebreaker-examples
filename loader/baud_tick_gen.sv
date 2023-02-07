/*
 *  icebreaker examples - Async uart baud tick generator module
 *
 *  Copyright (C) 2018 Piotr Esden-Tempski <piotr@esden.net>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

/***
 * This module generates a bit baud tick multiplied by the oversampling parameter.
 */
module baud_tick_gen(
	input clk, enable,
	output tick);
parameter clk_freq = 12000000;
parameter baud = 115200;
parameter oversampling = 1;

/* verilator lint_off WIDTH */
function integer log2_(input integer v);
begin
    log2_=0; while(v >> log2_) log2_ = log2_ + 1;
end endfunction
/* verilator lint_on WIDTH */

localparam acc_width = log2_(clk_freq / baud) + 8; // +/- 2% max timing error over a byte

reg [acc_width:0] acc = 0;

localparam shiftlimiter = log2_((baud * oversampling) >> (31 - acc_width)); // this makes sure inc calculation doesn't overflow (verilog uses 32bit variables internally)
localparam inc = ((baud * oversampling << (acc_width - shiftlimiter)) + (clk_freq >> (shiftlimiter + 1))) / (clk_freq >> shiftlimiter); // Calculate accumulate increment
//initial $display("acc_width %d, shiftlimit %d, inc %d", acc_width, shiftlimiter, inc);

always @(posedge clk) if (enable) acc <= acc[acc_width-1:0] + inc[acc_width:0]; else acc <= inc[acc_width:0];
assign tick = acc[acc_width];

endmodule
