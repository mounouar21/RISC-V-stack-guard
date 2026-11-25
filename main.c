#define UART0 ((volatile unsigned char *)0x10000000)

static void uart_putc(char c) { *UART0 = c; }
static void uart_puts(const char *s) { while (*s) uart_putc(*s++); }
static void uart_puthex(unsigned long x) {
    uart_puts("0x");
    for (int i = 60; i >= 0; i -= 4) uart_putc("0123456789abcdef"[(x >> i) & 0xf]);
}

int main(void) {
    uart_puts("Hello from bare-metal RISC-V\n");
    extern char __stack_top[], __guard_start[];
    uart_puts("stack top:   "); uart_puthex((unsigned long)__stack_top);   uart_puts("\n");
    uart_puts("guard start: "); uart_puthex((unsigned long)__guard_start); uart_puts("\n");
    for (;;) ;
}
