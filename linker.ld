OUTPUT_ARCH(riscv)
ENTRY(_start)
MEMORY { RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M }

SECTIONS {
  .text   : { *(.text.init) *(.text*) } > RAM
  .rodata : { *(.rodata*) } > RAM
  .data   : { *(.data*) } > RAM
  .bss    : { . = ALIGN(8); __bss_start = .; *(.bss*) *(COMMON); . = ALIGN(8); __bss_end = .; } > RAM

  . = ALIGN(4096);
  __guard_start = .;  . += 4096;  __guard_end = .;     /* step 4: PMP protects this */
  __stack_bottom = .; . += 16384; __stack_top = .;     /* main stack grows down towards the guard */
  . = ALIGN(16);
  __trap_stack_bottom = .; . += 4096; __trap_stack_top = .;  /* step 3: handler stack */
}
