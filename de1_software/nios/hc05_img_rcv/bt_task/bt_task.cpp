/*
 * bt_task.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 * 
 * References:
 * file:///C:/altera/12.1sp1/ip/University_Program/Communications/altera_up_avalon_rs232/doc/RS232.pdf
 */

#include <stdio.h>
#include "system.h"
#include "BTUart.h"
#include "dma.h"
#include "../../src/terasic_includes.h"
#include "../../src/tasks.h"

// #define INPUT_SIZE 1400
#define INPUT_SIZE 1400

volatile int *input = (volatile int *) 0x0A800000; /* input image */
volatile int *id = (volatile int *) 0x0A900000; /* tag id */


int bt_task()
{
  BTUart BT_UART;
  int dma_done = 0, count = 0;

  int init_success = BT_UART.open(BT_RS232_UART_NAME);
  BT_UART.flush();

  if (init_success)
    printf("INIT SUCCESS: RS232 UART port.\n");


  printf("START READING FROM UART FIFO ...\n");

  while (1) {
    if (BT_UART.read_ready()) {
      if (count < INPUT_SIZE) {
        input[count] = BT_UART.read_s();  // Store received image data in 'input' array
        count++;
      } else {
        while (!BT_UART.read_ready()) {} // Wait for next integer (dynamodb entry id: require to store result in the correct entry in db)
        id[0] = BT_UART.read_s();
        printf("\nTAG ID: %d\n", id[0]);

        // Write to DMA control port slave address to start DNN accelerator on HPS side
        dma_done = start_dma();

        if (dma_done)
          dma_done = 0;
        else
          printf("DMA ERROR: Start DMA falied.\n");

        count = 0;  // Reset counter, wait for next image
      }
    }
  }

  return 0;
}