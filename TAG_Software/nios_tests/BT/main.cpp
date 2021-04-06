#include <stdio.h>
#include "terasic_includes.h"
#include "BTUart.h"

#define BT_UART_NAME (const char *)("/dev/bt_rs232_uart")

int main()
{
  BTUart BT_UART;
  BT_UART.open(BT_UART_NAME);


  //AT
  char command_1[] = "AT\r\n";
  BT_UART.write_m(command_1, strlen(command_1));
  usleep(1000000);


  //Restore original
  char command_2[] = "AT+ORGL\r\n";
  BT_UART.write_m(command_2, strlen(command_2));
  usleep(1000000);


  //Set Baud Rate
  char command_3[] = "AT+UART=115200,0,0\r\n";
  BT_UART.write_m(command_3, strlen(command_3));
  usleep(1000000);


  printf("Finish\n");

  return 0;
}
