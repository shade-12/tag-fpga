/*
 * BTUart.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#ifndef BTUART_H_
#define BTUART_H_

#include "../../src/terasic_includes.h"
#include "altera_up_avalon_rs232.h"

#define WRITE_FIFO_EMPTY 0x80
#define READ_FIFO_EMPTY 0x0


class BTUart {
	protected:
		alt_up_rs232_dev* RS232_DEV;			// Opened RS232 device structure
		alt_u32 		  WRITE_FIFO_SPACE;		// Available Write FIFO space
	public:
		BTUart();
		virtual ~BTUart();

		/**
		 * Open the RS232 UART port according to device name.
		 * @param device_name - the device name in Qsys
		 * @return 1 if sucess, 0 otherwise
		**/
		int open(const char *device_name);

		/**
		 * Write single char to the RS232 UART core.
		 * @param data - a single character to be transferred to the RS232 UART Core
		 * @return 1 if success, 0 otherwise
		**/
		int write_s(alt_u8 data);

		/**
		 * Write multiple chars to the RS232 UART core.
		 * @param data - the characters to be transferred 
		 * 				 to the RS232 UART Core
		 * @param length - the length of @param data
		 * @return the number of chars written to UART core.
		**/
		int write_m(char data[], int length);

		/**
		 * Read data from the RS232 UART core.
		 * @return int read from UART core
		**/
		int read_s(void);

		/**
		 * Read multiple chars from the RS232 UART core.
		 * @param buffer - pointer to the memory where the numbers read from the RS232
		 *   			   UART core should be stored
		 * @param length - the number of character to be read from UART
		**/
		void read_m(int *buffer, int length);

		/**
		 * Poll the UART to determine if any character has been received.
		 * It doesn't wait for one, or read it. It simply tests to see
		 * if there is one available to read.
		 */
		int read_ready(void);

		/**
		 * Remove/flush the UART receiver buffer by removing any unread characters. 
		 * Clears the serial port buffer by continually reading until it is empty.
		 */
		void flush(void);
};

#endif /* BTUART_H_ */
