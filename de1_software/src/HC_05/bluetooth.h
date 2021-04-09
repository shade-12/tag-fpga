/*
 * bluetooth.h
 *
 *  Created on: Feb 28, 2021
 *  Author    : Shade Wong
 */

#ifndef BLUETOOTH_H_
#define BLUETOOTH_H_

/**
 * Initializes the bluetooth Port.
 *
 * Call this function at the start of the program prior to reading
 * or writing data via the bluetooth port.
 */
void bluetoothInit(void);

/**
 * Writes a single character to the bluetooth serial port
 */
unsigned char bluetoothPutChar(unsigned char c);

/**
 * Writes an array of characters to the bluetooth serial port
 *
 * @param msg - the address of an array containing characters
 * @param len - the number of characters to write into the buffer
 * @return The length of msg being written into the serial port
 */
int bluetoothPutChars(char msg[], const int len);

/**
 * Reads a single character from the bluetooth serial port
 */
unsigned char bluetoothGetChar(void);

/**
 * Reads a sequence of characters from the serial port.
 *
 * @param msg - a buffer to store all received characters
 * @param len - the number of characters to read into the buffer
 */
void bluetoothGetChars(unsigned char * msg, const int len);

/**
 * Poll the UART to determine if any character has been received.
 * It doesn't wait for one, or read it. It simply tests to see
 * if there is one available to read.
 */
int bluetoothTestForReceivedData(void);

/**
 * Remove/flush the UART receiver buffer by removing any unread characters. 
 * Clears the serial port buffer by continually reading until it is empty
 */
void bluetoothFlush(void);

#endif /* BLUETOOTH_H_ */