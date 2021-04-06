/*
 * BTUart.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#ifndef BTUART_H_
#define BTUART_H_

#include "terasic_includes.h"
#include "altera_up_avalon_rs232.h"

#define WRITE_FIFO_EMPTY 0x80
#define READ_FIFO_EMPTY 0x0


class BTUart {
	protected:
		alt_up_rs232_dev* RS232_DEV;			// Opened RS232 device structure
		alt_u32 		  WRITE_FIFO_SPACE;		// Available Write FIFO space
		alt_u16 		  READ_FIFO_USED;		// Used read buffer space
	public:
		BTUart();
		virtual ~BTUart();

		/**
		 * Open the RS232 UART port according to device name.
		 * @param device_name - the device name in Qsys
		 * @return 1 if sucess, 0 otherwise
		**/
		int  open(const char *device_name);

		/**
		 * Write single char to the RS232 UART core.
		 * @param data - a single character to be transferred to the RS232 UART Core
		 * @return 1 if success, 0 otherwise
		**/
		int  write_s(alt_u8 data);

		/**
		 * Write multiple chars to the RS232 UART core.
		 * @param data - the characters to be transferred 
		 * 				 to the RS232 UART Core
		 * @param length - the length of @param data
		 * @return the number of chars written to UART core.
		**/
		int  write_m(char data[], int length);

		/**
		 * Read data from the RS232 UART core.
		 * @param buffer - the memory where the character read from the RS232
		 *   			   UART core should be stored
		 * @param parity_error - the memory where the parity error should
		 *    					 be stored.
		 * @return 1 if success, 0 otherwise
		**/
		int  read_s(alt_u8 buffer, alt_u8 parity_error);

		/**
		 * Read multiple chars from the RS232 UART core.
		 * @param buffer - pointer to the memory where the characters read from the RS232
		 *   			   UART core should be stored
		 * @param length - the number of character to be read from UART
		**/
		void  read_m(alt_u8 *buffer, int length);
};

#endif /* BTUART_H_ */
