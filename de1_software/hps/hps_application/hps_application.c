/*
 * hps_application.c
 *
 *  Created on: Feb 20, 2021
 *      Author: Shade Wong
 */

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "alt_clock_manager.h"
#include "alt_generalpurpose_io.h"
#include "alt_globaltmr.h"
#include "hps_baremetal.h"
#include "hwlib.h"
#include "socal/alt_gpio.h"
#include "socal/hps.h"
#include "socal/socal.h"
#include "../hps_soc_system.h"

#define N 2     // Number of integers to be copied from HPS to FPGA

void setup_hps_timer() {
    assert(ALT_E_SUCCESS == alt_globaltmr_init());
}


/* The HPS doesn't have a sleep() function like the Nios II, so we can make one
 * by using the global timer. */
void delay_us(uint32_t us) {
    uint64_t start_time = alt_globaltmr_get64();
    uint32_t timer_prescaler = alt_globaltmr_prescaler_get() + 1;
    uint64_t end_time;
    alt_freq_t timer_clock;

    assert(ALT_E_SUCCESS == alt_clk_freq_get(ALT_CLK_MPU_PERIPH, &timer_clock));
    end_time = start_time + us * ((timer_clock / timer_prescaler) / ALT_MICROSECS_IN_A_SEC);

    // polling wait
    while(alt_globaltmr_get64() < end_time);
}


void start_dma() {
    // === DMA transfer HPS -> FPGA
    // set up DMA
    // from https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/ug/ug_embedded_ip.pdf
    // section 29.4.3 Table 282
    *(DMA_status_ptr) = 0;

    // read bus-master gets data from HPS addr=0xffff0000
    *(DMA_status_ptr + 1) = 0xffff0000;

    // write bus_master for FPGA SRAM is mapped to 0x08000000
    *(DMA_status_ptr + 2) = 0x08000000;

    // copy 8 bytes for 2 ints
    *(DMA_status_ptr + 3) = N * 4;

    // Set bit 2 for WORD trnsfer
    // Set bit 3 to sart DMA
    // Set bit 7 to stop on byte-count
    // Start the timer because DMA will start
    gettimeofday(&t1, NULL);
    *(DMA_status_ptr + 6) = 0b10001100;
    
    while ((*(DMA_startus_ptr) & 0x010) == 0) {}
}

int main() {
    printf("RUNNING ARM A9 HPS APPLICATION\n");

    setup_hps_timer();

    while (true) {
        delay_us(ALT_MICROSECS_IN_A_SEC / 10);
    }

    return 0;
}


