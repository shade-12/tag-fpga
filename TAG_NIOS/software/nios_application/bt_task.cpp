/**
 * References:
 * file:///C:/altera/12.1sp1/ip/University_Program/Communications/altera_up_avalon_rs232/doc/RS232.pdf
 * 
**/

#include <stdio.h>
#include "terasic_includes.h"
#include "BTUart.h"

#define BT_UART_NAME (const char *)("/dev/bt_rs232_uart") // Qsys component name

int bt_task()
{
  BTUart BT_UART;
  char c;

  int init_success = BT_UART.open(BT_UART_NAME);
  BT_UART.flush();

  if (init_success)
    printf("INIT SUCCESS: RS232 UART port.\n");


  printf("START READING FROM UART FIFO ...\n");

  while (1) {
    if (BT_UART.read_ready()) {
      c = BT_UART.read_s();
      printf("%c", c);
    }
  }

  return 0;
}