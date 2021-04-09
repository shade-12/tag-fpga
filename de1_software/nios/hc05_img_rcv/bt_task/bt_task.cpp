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
#include "../../src/terasic_includes.h"
#include "../../src/tasks.h"


int bt_task()
{
  BTUart BT_UART;
  int c;

  int init_success = BT_UART.open(BT_RS232_UART_NAME);
  BT_UART.flush();

  if (init_success)
    printf("INIT SUCCESS: RS232 UART port.\n");


  printf("START READING FROM UART FIFO ...\n");

  while (1) {
    if (BT_UART.read_ready()) {
      c = BT_UART.read_s();
      printf("%f", c);
    }
  }

  return 0;
}