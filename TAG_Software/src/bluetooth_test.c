#include <stdio.h>
#include <string.h>

#include "bluetooth.h"

#define IS_HC05_TEST 1


/**
 * Test reading and writing single/multiple chars to the BT UART serial port
 * by conecting the TX/RX pins with a jumper wire.
 */
void bt_pins_test() {
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


/**
 * Test reading and writing single/multiple chars to the BT UART serial port
 * by connecting RFS daughter board to GPIO 1 header pins on DE1,
 * then establish connection btwn the HC05 module and mobile.
 */
void bt_slave_test() {

    int ready;
    unsigned char c;

    while (1)
    {
        ready = bluetoothTestForReceivedData();
        
        if (ready) {
            printf("Ready to read char: %d\n", ready);
            c = bluetoothGetChar();
            printf("Received: %c\n", c);
        }
    }
    
}

void main(void)
{
    printf("UART Bluetooth Serial Port Test Program\n");

    bluetoothInit();
    bluetoothFlush();
    printf("Flush done.\n");

    #if (IS_HC05_TEST)
        bt_slave_test();
    #else
        bt_pins_test();
    #endif
    
}