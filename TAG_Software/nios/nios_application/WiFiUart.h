/*
 * WiFiUart.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#ifndef WiFiUART_H_
#define WiFiUART_H_

#include "terasic_includes.h"
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
		 * Prompt user for WiFi network name and password, then connect
		 * to WiFi network.
		 * @return 1 if sucess, 0 otherwise
		**/
		int connect();

		/**
		 * Send AT command to ESP8266 chip.
		 * @param cmd - pointer to AT command string
		 * @return 1 if success, 0 otherwise
		**/
		int send_command(const char *cmd);

		/**
		 * Write multiple chars to the RS232 UART core.
		 * @param data - pointer to the characters to be transferred 
		 * 				 to the RS232 UART Core
		 * @param length - the length of data to be transferred
		 * @return the number of chars written to UART core.
		**/
		int send_data(const char *data, int length);

		/**
		 * Read multiple chars from the RS232 UART core.
		 * @param buffer - pointer to the memory where the characters read from the RS232
		 *   			   UART core should be stored
		 * @param length - the number of character to be read from UART
		**/
		void gets(char *buffer, int length);

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
