/* so.s - ESP32 (ESP32-WROOM-32E module and ESP-32S board)
 * bare-metal LED blink on GPIO2. */

.section        .text

.literal_position
gpio_enable:    .word 0x3FF44024
gpio_out_set:   .word 0x3FF44008
gpio_out_clr:   .word 0x3FF4400C
gpio2_mask:     .word 0x00000004
delay_count:    .word 2000000

.global         call_start_cpu0

call_start_cpu0:
    /* Enable GPIO2 as output */
    l32r        a2, gpio_enable
    l32r        a3, gpio2_mask
    memw
    s32i        a3, a2, 0
    memw

blink_loop:
    /* Set GPIO2 HIGH */
    l32r        a2, gpio_out_set
    l32r        a3, gpio2_mask
    memw
    s32i        a3, a2, 0
    memw
    
    /* Delay */
    l32r        a4, delay_count
delay1:
    addi        a4, a4, -1
    bnez        a4, delay1
    
    /* Set GPIO2 LOW */
    l32r        a2, gpio_out_clr
    l32r        a3, gpio2_mask
    memw
    s32i        a3, a2, 0
    memw
    
    /* Delay */
    l32r        a4, delay_count
delay2:
    addi        a4, a4, -1
    bnez        a4, delay2
    
    j           blink_loop
