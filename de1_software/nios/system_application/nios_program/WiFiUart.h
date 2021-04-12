/*
 * WiFiUart.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#ifndef WiFiUART_H_
#define WiFiUART_H_

#include "../../src/terasic_includes.h"
#include "altera_up_avalon_rs232.h"

#define WRITE_FIFO_EMPTY 0x80
#define READ_FIFO_EMPTY 0x0


class WiFiUart {
	protected:
		alt_up_rs232_dev* RS232_DEV;			// Opened RS232 device structure
		alt_u32 		  WRITE_FIFO_SPACE;		// Available Write FIFO space
	public:
		WiFiUart();
		virtual ~WiFiUart();

		/**
		 * Open the RS232 UART port according to device name.
		 * @param device_name - the device name in Qsys
		 * @return 1 if sucess, 0 otherwise
		**/
		int open(const char *device_name);

		/**
		 * Run "patch_data.lua", which connect RFS wifi module to my home network and
		 * make update_db_entry(), check_wifi() functions available.
		 * @return 1 if sucess, 0 otherwise
		**/
		int init();

		/**
		 * Update entry in dynamodb.
		 * @param tag_id
		 * @param result
		 * @return 1 if sucess, 0 otherwise
		**/
		int update_entry(volatile int *tag_id, volatile int *result);

		/**
		 * Write multiple chars to the RS232 UART core.
		 * @param data - the characters to be transferred 
		 * 				 to the RS232 UART Core
		 * @param length - the length of @param data
		 * @return the number of chars written to UART core.
		**/
		int write_m(char data[], int length);

		/**
		 * Read multiple chars from the RS232 UART core.
		 * @param buffer - pointer to the memory where the numbers read from the RS232
		 *   			   UART core should be stored
		 * @param length - the number of character to be read from UART
		**/
		void read_m(int *buffer, int length);

		/**
		 * Write single char to the RS232 UART core.
		 * @param data - a single character to be transferred to the RS232 UART Core
		 * @return 1 if success, 0 otherwise
		**/
		int write_s(alt_u8 data);

		/**
		 * Read data from the RS232 UART core.
		 * @return char read from UART core
		**/
		unsigned char read_s(void);

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

#endif /* WiFiUART_H_ */
