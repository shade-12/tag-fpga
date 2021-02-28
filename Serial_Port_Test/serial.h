/*
 * serial.h
 *
 *  Created on: Feb 28, 2020
 *  Author    : Shade Wong
 */

#ifndef SERIAL_H_
#define SERIAL_H_

typedef enum baud_rate {
	BAUD_RATE_115K = 0x01,
	BAUD_RATE_57_6K = 0x02,
	BAUD_RATE_38_4K = 0x03,
	BAUD_RATE_19_2K = 0x04,
	BAUD_RATE_9600 = 0x05
} baud_rate_t;

/**
 * Initializes the Serial Port.
 *
 * Call this function at the start of the program prior to reading
 * or writing data via the Serial port.
 */
void serialInit(unsigned volatile char * DEV, const baud_rate_t BAUD_RATE);

/**
 * Writes a single character to the serial port
 */
void serialPutChar(unsigned volatile char * DEV, const unsigned char c);

/**
 * Writes an array of characters to the serial port
 *
 * @param DEV - the address of the serial port device
 * @param msg - the address of an array containing characters
 * @param msg_length - the number of characters to write to the device
 */
void serialPutNChar(unsigned volatile char * DEV, const unsigned char * msg, const int msg_length);

/**
 * Reads a single character from the rs232 serial port
 */
unsigned char serialGetChar(const unsigned volatile char * DEV);

/**
 * Reads a sequence of characters from the serial port.
 *
 * @param DEV - the address of the serial port device
 * @param recv_msg - a buffer to store all received characters
 * @param recv_msg_length - the number of characters to read into the buffer
 */
void serialGetNChar(const unsigned volatile char * DEV, unsigned char * recv_msg, const int recv_msg_length);

/**
 * Poll the serial port to determine if any character has been received.
 * It doesn't wait for one, or read it. It simply tests to see
 * if there is one available to read.
 */
int serialTestForReceivedData(const unsigned volatile char * DEV);

#endif /* SERIAL_H_ */