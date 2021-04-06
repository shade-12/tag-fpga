#include <stdio.h>
#include "terasic_includes.h"
#include "CUart.h"

#define BT_UART_NAME (char *)("bt_rs232_uart")

int main()
{
  CUart Uart;
  Uart.Open(BT_UART_NAME);

  //AT
  Uart.WriteString((char *)"AT\r\n");
  usleep(1000000);
  //Restore original
  Uart.WriteString((char *)"AT+ORGL\r\n");
  usleep(1000000);
  //Set Baud Rate
  Uart.WriteString((char *)"AT+UART=115200,0,0\r\n");
  usleep(1000000);


  printf("Finish\n");

  return 0;
}
