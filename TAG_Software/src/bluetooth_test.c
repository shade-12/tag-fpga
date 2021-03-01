#include <stdio.h>

#include "bluetooth.h"

#define LEDS        (volatile unsigned int *)(0xFF200020)
#define HEX0_1      (volatile unsigned int *)(0xFF200030)
#define HEX2_3      (volatile unsigned int *)(0xFF200040)
#define HEX4_5      (volatile unsigned int *)(0xFF200050)


void main(void)
{
    printf("UART Bluetooth Serial Port Test Program\n");

    bluetoothInit();
    bluetoothFlush();
    printf("Flush done.\n");

    int c, ready;

    while(1) {
        ready = bluetoothTestForReceivedData();
        printf("Ready to read char: %d\n", ready);

        if (ready) {
            c = bluetoothGetChar();
            *LEDS = c;
            *HEX0_1 = c;
            *HEX2_3 = c;
            *HEX4_5 = c;
        }
    }

    printf("Exit.");
    return;
}