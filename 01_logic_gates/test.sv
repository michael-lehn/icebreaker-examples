module test (
    input BTN1,
    input BTN2,
    output logic LED1,
    output logic LED2
);

    logic a, b;
    assign a = BTN1;
    assign b = BTN2;

    logic out1, out2;
    assign LED1 = out1;
    assign LED2 = out2;

    always_comb begin
	out1 = a & b;
	out2 = a | b;
    end

endmodule
