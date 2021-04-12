/*
 * WiFiUart.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#include <stdio.h>
#include <cstdio>
#include <string.h>
#include "WiFiUart.h"
#include "sys/alt_dev.h"
#include "altera_up_avalon_rs232.h"

char *script = "dofile(\"patch_data.lua\")";

WiFiUart::WiFiUart()
{
    // TODO Auto-generated constructor stub
}


WiFiUart::~WiFiUart()
{
	// TODO Auto-generated destructor stub
}


int WiFiUart::open(const char *device_name)
{
	RS232_DEV = alt_up_rs232_open_dev(device_name);

    // Enable the read interrupts for the RS232 UART core 
    alt_up_rs232_enable_read_interrupt(RS232_DEV);

    if (RS232_DEV == NULL) {
        return 0;
    }
        
    return 1;
}


int WiFiUart::init()
{
	if (RS232_DEV == NULL) {
        printf("ERROR: Open RS232 port before conencting.\n");
        return 0;
    }

    flush();    // Clear FIFO

    int i;
    char *crlf = "\r\n";
    
    for (i = 0; i < 5; i++) {   // Send CRLF multiple times to let the wifi firmware match up the communication baud rate
        write_m(crlf, strlen(crlf));
        flush();
    }

    write_m(script, strlen(script));
    write_s('\r');
    write_s('\n');
    flush();

    return 1;
}


int WiFiUart::update_entry(volatile int *tag_id, volatile int *result)
{
    const char *result_str = (result) ? "true" : "false";

    char command[50] = "update_db_entry(\"";
    char tid_str[8];
	snprintf(tid_str, 8, "%d", tag_id); // convert tag_id from int to string 
    strcat(command, tid_str);
	strcat(command, "\",");
    strcat(command, result_str);
    strcat(command, ")");
    
	printf("Command: %s\n", command);

    write_m(command, strlen(command));
    write_s('\r');
    write_s('\n');
    for (int i = 0;i < 50000; i++){};

    return 1;
}


int WiFiUart::write_m(char data[], int length)
{
    int count;
	for (count = 0; count < length; count++) {
		write_s(data[count]);
	}
    return count;
}


void WiFiUart::read_m(int *buffer, int length)
{
    int count;
    for (count = 0; count < length; count++) {
		buffer[count] = read_s();
	}
}


int WiFiUart::write_s(alt_u8 data)
{
    alt_up_rs232_disable_read_interrupt(RS232_DEV);

    int result = 0;
    WRITE_FIFO_SPACE = alt_up_rs232_get_available_space_in_write_FIFO(RS232_DEV);

    if (WRITE_FIFO_SPACE >= WRITE_FIFO_EMPTY) {
        alt_up_rs232_write_data(RS232_DEV, data);
        result = 1;
    }

    // Enable the read interrupts for the RS232 UART core 
    alt_up_rs232_enable_read_interrupt(RS232_DEV);
    return result;
}


unsigned char WiFiUart::read_s(void)
{
    while (!read_ready()) {}    // Wait for data to be available to read

    alt_u8 buffer;
    alt_u8 parity_error;

    alt_up_rs232_read_data(RS232_DEV, &buffer, &parity_error);

    return (unsigned char) buffer;
}


int WiFiUart::read_ready(void)
{
    alt_u16 read_fifo_used = alt_up_rs232_get_used_space_in_read_FIFO(RS232_DEV);
    return (read_fifo_used > READ_FIFO_EMPTY);
}


void WiFiUart::flush(void)
{
    while (read_ready()) {
        // read unwanted char out of fifo receiver buffer
        read_s();
    }
    return; // no more characters so return 
}