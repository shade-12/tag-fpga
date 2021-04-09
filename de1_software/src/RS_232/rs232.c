#include <stdio.h>

#include "rs232.h"

#define RS232_ReceiverFifo                  (*(volatile unsigned char *)(0xFF210200))
#define RS232_TransmitterFifo               (*(volatile unsigned char *)(0xFF210200))
#define RS232_InterruptEnableReg            (*(volatile unsigned char *)(0xFF210202))
#define RS232_InterruptIdentificationReg    (*(volatile unsigned char *)(0xFF210204))
#define RS232_FifoControlReg                (*(volatile unsigned char *)(0xFF210204))
#define RS232_LineControlReg                (*(volatile unsigned char *)(0xFF210206))
#define RS232_ModemControlReg               (*(volatile unsigned char *)(0xFF210208))
#define RS232_LineStatusReg                 (*(volatile unsigned char *)(0xFF21020A))
#define RS232_ModemStatusReg                (*(volatile unsigned char *)(0xFF21020C))
#define RS232_ScratchReg                    (*(volatile unsigned char *)(0xFF21020E))
#define RS232_DivisorLatchLSB               (*(volatile unsigned char *)(0xFF210200))
#define RS232_DivisorLatchMSB               (*(volatile unsigned char *)(0xFF210202))

#define BR_CLK_FREQ     50000000
#define RS232_BAUD_RATE 112500


void rs232Init(void)
{
    // set bit 7 of Line Control Register to 1, to gain access to the baud rate registers
    RS232_LineControlReg = (RS232_LineControlReg & ~(1UL << 7)) | (1 << 7);

    // set Divisor latch (LSB and MSB) with correct value for required baud rate
    // baud rate divisor value = (freq of BR_clk) / (desired baud rate * 16)
    RS232_DivisorLatchLSB = BR_CLK_FREQ / (RS232_BAUD_RATE * 16);
    RS232_DivisorLatchMSB = BR_CLK_FREQ / (RS232_BAUD_RATE * 16);

    // set bit 7 of Line control register back to 0 and
    // program other bits in that reg for 8 bit data, 1 stop bit, no parity etc

    RS232_LineControlReg &= ~(1UL << 7); // Clear bit 7
    RS232_LineControlReg = (RS232_LineControlReg & ~(1UL << 0)) | (1 << 0); // Set bit 0 -> 1
    RS232_LineControlReg = (RS232_LineControlReg & ~(1UL << 1)) | (1 << 1); // Set bit 1 -> 1
    RS232_LineControlReg &= ~(1UL << 2); // Set bit 2 -> 0
    RS232_LineControlReg &= ~(1UL << 3); // Set bit 3 -> 0

    // Reset the Fifo’s in the FiFo Control Reg by setting bits 1 & 2
    RS232_FifoControlReg = (RS232_FifoControlReg & ~(1UL << 1)) | (1 << 1); // Set bit 1 -> 1
    RS232_FifoControlReg = (RS232_FifoControlReg & ~(1UL << 2)) | (1 << 2); // Set bit 2 -> 1

    // Now Clear all bits in the FiFo control registers
    RS232_FifoControlReg = 0;
}


int rs232PutChar(int c)
{
    // wait for Transmitter Holding Register bit (5) of line status register to be '1'
    while ((RS232_LineStatusReg & 0b100000) == 0) {}

    // indicating we can write to the device
    // write character to Transmitter fifo register
    RS232_TransmitterFifo = c;

    // return the character we printed
    return c;
}


int rs232GetChar(void)
{
    // wait for Data Ready bit (0) of line status register to be '1'
    while ((RS232_LineStatusReg & 0b1) == 0) {}

    // read new character from ReceiverFiFo register
    // return new character
    return RS232_ReceiverFifo;
}


int rs232TestForReceivedData(void)
{
    // if RS232_LineStatusReg bit 0 is set to 1
    // return TRUE, otherwise return FALSE
    return ((RS232_LineStatusReg & 0b1) ? 1 : 0);
}

void rs232Flush(void)
{
    // while bit 0 of Line Status Register == ‘1’
    while (rs232TestForReceivedData()) {
        // read unwanted char out of fifo receiver buffer
        rs232GetChar();
    }
    return; // no more characters so return
}
