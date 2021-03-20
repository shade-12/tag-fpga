#include <stdio.h>

#include "bluetooth.h"

#define BT_ReceiverFifo                  (*(volatile unsigned char *)(0xFF210220))
#define BT_TransmitterFifo               (*(volatile unsigned char *)(0xFF210220))
#define BT_InterruptEnableReg            (*(volatile unsigned char *)(0xFF210222))
#define BT_InterruptIdentificationReg    (*(volatile unsigned char *)(0xFF210224))
#define BT_FifoControlReg                (*(volatile unsigned char *)(0xFF210224))
#define BT_LineControlReg                (*(volatile unsigned char *)(0xFF210226))
#define BT_ModemControlReg               (*(volatile unsigned char *)(0xFF210228))
#define BT_LineStatusReg                 (*(volatile unsigned char *)(0xFF21022A))
#define BT_ModemStatusReg                (*(volatile unsigned char *)(0xFF21022C))
#define BT_ScratchReg                    (*(volatile unsigned char *)(0xFF21022E))
#define BT_DivisorLatchLSB               (*(volatile unsigned char *)(0xFF210220))
#define BT_DivisorLatchMSB               (*(volatile unsigned char *)(0xFF210222))

#define BR_CLK_FREQ  50000000
// #define BT_BAUD_RATE 38400 // AT mode
#define BT_BAUD_RATE 115200 // Connection mode


void bluetoothInit(void)
{
    // set bit 7 of Line Control Register to 1, to gain access to the baud rate registers
    BT_LineControlReg = (BT_LineControlReg & ~(1UL << 7)) | (1 << 7);

    // set Divisor latch (LSB and MSB) with correct value for required baud rate
    // baud rate divisor value = (freq of BR_clk) / (desired baud rate * 16)
    BT_DivisorLatchLSB = BR_CLK_FREQ / (BT_BAUD_RATE * 16);
    BT_DivisorLatchMSB = BR_CLK_FREQ / (BT_BAUD_RATE * 16);

    // set bit 7 of Line control register back to 0 and
    // program other bits in that reg for 8 bit data, 1 stop bit, no parity etc

    BT_LineControlReg &= ~(1UL << 7); // Clear bit 7
    BT_LineControlReg = (BT_LineControlReg & ~(1UL << 0)) | (1 << 0); // Set bit 0 -> 1
    BT_LineControlReg = (BT_LineControlReg & ~(1UL << 1)) | (1 << 1); // Set bit 1 -> 1
    BT_LineControlReg &= ~(1UL << 2); // Set bit 2 -> 0
    BT_LineControlReg &= ~(1UL << 3); // Set bit 3 -> 0

    // Reset the Fifo’s in the FiFo Control Reg by setting bits 1 & 2
    BT_FifoControlReg = (BT_FifoControlReg & ~(1UL << 1)) | (1 << 1); // Set bit 1 -> 1
    BT_FifoControlReg = (BT_FifoControlReg & ~(1UL << 2)) | (1 << 2); // Set bit 2 -> 1

    // Now Clear all bits in the FiFo control registers
    BT_FifoControlReg = 0;
}


unsigned char bluetoothPutChar(unsigned char c)
{
    // wait for Transmitter Holding Register bit (5) of line status register to be '1'
    while ((BT_LineStatusReg & 0b100000) == 0) {}

    // indicating we can write to the device
    // write character to Transmitter fifo register
    BT_TransmitterFifo = c;

    // return the character we printed
    return c;
}


int bluetoothPutChars(char msg[], const int len)
{
    int count;

	for (count = 0; count < len; count++) {
		bluetoothPutChar((unsigned char) msg[count]);
	}
    return count;
}


unsigned char bluetoothGetChar(void)
{
    // wait for Data Ready bit (0) of line status register to be '1'
    while ((BT_LineStatusReg & 0b1) == 0) {}

    // read new character from ReceiverFiFo register
    // return new character
    return BT_ReceiverFifo;
}

void bluetoothGetChars(unsigned char * msg, const int len)
{
    int count;

    for (count = 0; count < len; count++) {
		msg[count] = bluetoothGetChar();
	}
}


int bluetoothTestForReceivedData(void)
{
    // if BT_LineStatusReg bit 0 is set to 1
    // return TRUE, otherwise return FALSE
    return ((BT_LineStatusReg & 0b1) ? 1 : 0);
}

void bluetoothFlush(void)
{
    // while bit 0 of Line Status Register == ‘1’
    while (bluetoothTestForReceivedData()) {
        // read unwanted char out of fifo receiver buffer
        bluetoothGetChar();
    }
    return; // no more characters so return
}