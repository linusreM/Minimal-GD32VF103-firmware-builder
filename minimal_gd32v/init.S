#define CSR_MSTATUS 0x300
#define MSTATUS_MIE 0x00000008

.section .init

.global _start
_start:
    csrc CSR_MSTATUS, MSTATUS_MIE
    lui a0, %hi(1f)
    addi a0, a0, %lo(1f)
    jr a0
1:
    la sp, _sp
    li a0, 0
    li a1, 0
    call main
