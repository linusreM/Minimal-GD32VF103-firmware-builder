.section .init
.global _start
/* We start in 0x00000000 aliased to 0x08000000 
   so we need to jump to get into real memory adresses.
   The jump must not be pc-relative, else we stay in 
   aliased space. */
_start:
    lui a0, %hi(1f)
    addi a0, a0, %lo(1f)
    jr a0
1:
    la sp, _sp
    call main