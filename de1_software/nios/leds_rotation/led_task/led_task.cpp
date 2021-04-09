/*
 * led_task.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 * 
 * Description:
 * The code instructs the Nios II processor to create a strobing light effect
 * on its 10 peripheral LEDs. The processor’s 10 peripheral switches are used
 * as enable signals for each corresponding LED.
 * 
 */

#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "../../src/tasks.h"


#define LEDS_MAX_ITERATION (1000)
#define SLEEP_DELAY_US (100 * 1000)


int led_task() {
    int loop_count = 0;
    int leds_mask = 0x01;

    // 0 - Left
    // 1 - Right
    int led_direction = 0;

    while (loop_count < LEDS_MAX_ITERATION) {
        uint32_t switches_value = IORD_ALTERA_AVALON_PIO_DATA(SWITCHES_BASE);
        uint32_t leds_value = ~leds_mask;

        // only turn on leds which have their corresponding switch enabled
        IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds_value & switches_value);

        usleep(SLEEP_DELAY_US);

        if (led_direction == 0) {
            leds_mask <<= 1;
            if (leds_mask == (0x01 << (LEDS_DATA_WIDTH - 1))) {
                led_direction = 1;
            }
        } else {
            leds_mask >>= 1;
            if (leds_mask == 0x01) {
                led_direction = 0;
                loop_count++;
            }
        }
    }

    return 0;
}