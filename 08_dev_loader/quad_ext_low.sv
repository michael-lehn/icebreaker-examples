`include "pkg_ram.sv"
import pkg_ram::data_type_t;
import pkg_ram::RAM_QUAD_SIZE;
import pkg_ram::RAM_LONG;
import pkg_ram::RAM_WORD;
import pkg_ram::RAM_BYTE;

/*
 * Zero extend low bytes in data_in
 */

module quad_ext_low (
    input logic [RAM_QUAD_SIZE-1:0] data_in,
    input data_type_t data_type,
    output logic [RAM_QUAD_SIZE-1:0] data_out
);

    always_comb begin
	case (data_type)
	    default:
		data_out = data_in;
	    RAM_LONG:
		data_out = {
		    data_in[RAM_LONG_SIZE-1:0],
		    {RAM_QUAD_SIZE-RAM_LONG_SIZE{1'b0}}
		};
	    RAM_WORD:
		data_out = {
		    data_in[RAM_WORD_SIZE-1:0],
		    {RAM_QUAD_SIZE-RAM_WORD_SIZE{1'b0}}
		};
	    RAM_BYTE:
		data_out = {
		    data_in[RAM_BYTE_SIZE-1:0],
		    {RAM_QUAD_SIZE-RAM_BYTE_SIZE{1'b0}}
		};
	endcase
    end

endmodule
