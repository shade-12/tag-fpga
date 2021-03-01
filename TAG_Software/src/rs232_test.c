#include <stdio.h>

#include "rs232.h"

#define LEDS        (volatile unsigned int *)(0xFF200020)
#define HEX0_1      (volatile unsigned int *)(0xFF200030)
#define HEX2_3      (volatile unsigned int *)(0xFF200040)
#define HEX4_5      (volatile unsigned int *)(0xFF200050)


void main(void)
{
    printf("UART RS232 Serial Port Test Program\n");

    rs232Init();
    rs232Flush();
    printf("Flush done.\n");

    int d = rs232PutChar(2);
    printf("Put char: %d\n", d);

    int ready = rs232TestForReceivedData();
    printf("Ready to read char: %d\n", ready);

    int c = rs232GetChar();
    *LEDS = c;
    *HEX0_1 = c;
    *HEX2_3 = c;
    *HEX4_5 = c;
    printf("You should see number 2 appears on the HEX display now.\n");

    printf("Exit.");
    return;
}