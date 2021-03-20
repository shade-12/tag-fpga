#include <stdio.h>
#include <string.h>

#include "bluetooth.h"

void main(void)
{
    printf("UART Bluetooth Serial Port Test Program\n");

    bluetoothInit();
    bluetoothFlush();
    printf("Flush done.\n");

    // Put single char
    unsigned char d = bluetoothPutChar('A');
    printf("Put char: %c\n", d);

    int ready = bluetoothTestForReceivedData();
    printf("Ready to read char: %d\n", ready);

    unsigned char c = bluetoothGetChar();
    printf("Received char: %c\n", c);


    // Put multiple chars
    char msg[] = "Hello from UART";
    int len = bluetoothPutChars(msg, strlen(msg));
    printf("Put chars of length: %d\n", len);

    unsigned char res[15] = {'\0'};
    bluetoothGetChars(res, len);
    printf("Received chars: %s\n", res);

    printf("Exit.");
    return;
}