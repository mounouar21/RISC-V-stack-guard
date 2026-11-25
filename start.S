    .section .text.init
    .global _start
_start:
    csrr  t0, mhartid        # only hart 0 runs
    bnez  t0, park
    la    sp, __stack_top    # stack pointer = top of main stack
    la    t0, __bss_start
    la    t1, __bss_end
1:  bgeu  t0, t1, 2f         # zero .bss, 8 bytes at a time
    sd    zero, 0(t0)
    addi  t0, t0, 8
    j     1b
2:  call  main
park:
    wfi
    j     park
