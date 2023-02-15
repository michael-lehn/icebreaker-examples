`ifndef PKG_CU
`define PKG_CU

package pkg_cu;

typedef enum {
    CU_HALT_IMM,
    CU_HALT_REG,
    CU_REL_JMP,
    CU_ABS_JMP,
    CU_NOP
} op_t;

typedef enum {
    CU_FETCH,
    CU_DECODE,
    CU_LOAD_OPERANDS,
    CU_EXECUTE,
    CU_INCREMENT,
    CU_IDLE,
    CU_HALTED
} state_t;

endpackage // pkg_cu

`endif // PKG_CU
