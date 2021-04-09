/*
 * rs232.h
 *
 *  Created on: Feb 28, 2021
 *  Author    : Shade Wong
 */

#ifndef RS232_H_
#define RS232_H_

/**************************************************************************
/* Subroutine to initialise the RS232 Port by writing some data
** to the internal registers.
** Call this function at the start of the program before you attempt
** to read or write to data via the RS232 port
**
** Refer to UART data sheet for details of registers and programming
***************************************************************************/

/**
 * Initializes the RS232 Port.
 *
 * Call this function at the start of the program prior to reading
 * or writing data via the RS232 port.
 */
void rs232Init(void);

/**
 * Writes a single character to the rs232 serial port
 */
int rs232PutChar(int c);

/**
 * Reads a single character from the rs232 serial port
 */
int rs232GetChar(void);

/**
 * Poll the UART to determine if any character has been received.
 * It doesn't wait for one, or read it. It simply tests to see
 * if there is one available to read.
 */
int rs232TestForReceivedData(void);

/**
 * Remove/flush the UART receiver buffer by removing any unread characters. 
 * Clears the serial port buffer by continually reading until it is empty
 */
void rs232Flush(void);

#endif /* RS232_H_ */