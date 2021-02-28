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


/**************************************************************************
/* Subroutine to initialise the RS232 Port by writing some data
** to the internal registers.
** Call this function at the start of the program before you attempt
** to read or write to data via the RS232 port
**
** Refer to UART data sheet for details of registers and programming
***************************************************************************/


void Init_RS232(void)
{
    // set bit 7 of Line Control Register to 1, to gain access to the baud rate registers
    RS232_LineControlReg |= 64;

    // set Divisor latch (LSB and MSB) with correct value for required baud rate
    // baud rate divisor value = (freq of BR_clk) / (desired baud rate * 16)
    RS232_DivisorLatchLSB = BR_CLK_FREQ / (RS232_BAUD_RATE * 16);
    RS232_DivisorLatchMSB = BR_CLK_FREQ / (RS232_BAUD_RATE * 16);

    // set bit 7 of Line control register back to 0 and
    // program other bits in that reg for 8 bit data, 1 stop bit, no parity etc
    RS232_LineControlReg &= 63;

    // Reset the Fifo’s in the FiFo Control Reg by setting bits 1 & 2
    RS232_FifoControlReg |= 6;

    // Now Clear all bits in the FiFo control registers
    RS232_FifoControlReg &= 249;
}


int putcharRS232(int c)
{
 // wait for Transmitter Holding Register bit (5) of line status register to be '1'
 unsigned char bit_5 = 0;
 bit_5 |= (RS232_LineStatusReg & 32);
 while (!bit_5) {}

 // indicating we can write to the device
 // write character to Transmitter fifo register
 RS232_TransmitterFifo = c;

 // return the character we printed
 return c;
}


int getcharRS232( void )
{
 // wait for Data Ready bit (0) of line status register to be '1'
 while (!(RS232_LineStatusReg & 1)) {}

 // read new character from ReceiverFiFo register
 // return new character
 return RS232_ReceiverFifo;
}


// the following function polls the UART to determine if any character
// has been received. It doesn't wait for one, or read it, it simply tests
// to see if one is available to read from the FIFO
int RS232TestForReceivedData(void)
{
 // if RS232_LineStatusReg bit 0 is set to 1
 //return TRUE, otherwise return FALSE
 return (RS232_LineStatusReg & 1);
}


//
// Remove/flush the UART receiver buffer by removing any unread characters
//
void RS232Flush(void)
{
 // while bit 0 of Line Status Register == ‘1’
 while (RS232_LineStatusReg & 1) {
  // read unwanted char out of fifo receiver buffer
  char c = RS232_ReceiverFifo;
 }
 
 return; // no more characters so return
}
