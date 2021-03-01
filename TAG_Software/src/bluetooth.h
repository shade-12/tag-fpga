/*
 * bluetooth.h
 *
 *  Created on: Feb 28, 2020
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
int bluetoothPutChar(int c);

/**
 * Reads a single character from the bluetooth serial port
 */
int bluetoothGetChar(void);

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