/* blink.s - ESP32 bare-metal LED blink on GPIO2 */

.section .text

/* Literal pool MUST be BEFORE code that uses it */
.align 4
.literal_position
io_mux_gpio2:    .word 0x3FF49040
io_mux_val:      .word 0x00002800    /* MCU_SEL=2, FUN_DRV=2 */
gpio_enable:     .word 0x3FF44024
gpio_out_set:    .word 0x3FF44008
gpio_out_clr:    .word 0x3FF4400C
gpio2_mask:      .word 0x00000004
delay_count:     .word 2000000

.align 4
.global call_start_cpu0
.type call_start_cpu0, @function

call_start_cpu0:
    /* Set stack pointer */
    movi    a1, 0x3FFF0000
    
    /* Configure IO_MUX for GPIO2: function 2 (GPIO mode) */
    l32r    a2, io_mux_gpio2
    l32r    a3, io_mux_val
    memw
    s32i    a3, a2, 0
    memw
    
    /* Enable GPIO2 as output */
    l32r    a2, gpio_enable
    l32r    a3, gpio2_mask
    memw
    s32i    a3, a2, 0
    memw

blink_loop:
    /* Set GPIO2 HIGH */
    l32r    a2, gpio_out_set
    l32r    a3, gpio2_mask
    memw
    s32i    a3, a2, 0
    memw
    
    /* Delay */
    l32r    a4, delay_count
delay1:
    addi    a4, a4, -1
    bnez    a4, delay1
    
    /* Set GPIO2 LOW */
    l32r    a2, gpio_out_clr
    l32r    a3, gpio2_mask
    memw
    s32i    a3, a2, 0
    memw
    
    /* Delay */
    l32r    a4, delay_count
delay2:
    addi    a4, a4, -1
    bnez    a4, delay2
    
    j       blink_loop
