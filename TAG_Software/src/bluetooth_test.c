#include <stdio.h>

#include "bluetooth.h"


void main(void)
{
    printf("UART Bluetooth Serial Port Test Program\n");

    bluetoothInit();
    bluetoothFlush();
    printf("Flush done.\n");

    int isConfigSuccess = bluetoothConfig();
    printf("BT config - Success(1), Fail(0): %d\n", isConfigSuccess);

    int ready;
    unsigned char c;

    while(1) {
        ready = bluetoothTestForReceivedData();
        printf("Ready to read char: %d\n", ready);

        if (ready) {
            c = bluetoothGetChar();
            printf("Char received: %c\n", c);
        }
    }

    printf("Exit.");
}