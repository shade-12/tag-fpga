/*
 * BTUart.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#include "BTUart.h"
#include "sys/alt_dev.h"
#include "altera_up_avalon_rs232.h"


BTUart::BTUart()
{
    // TODO Auto-generated constructor stub
}


BTUart::~BTUart()
{
	// TODO Auto-generated destructor stub
}


int BTUart::open(const char *device_name)
{
	RS232_DEV = alt_up_rs232_open_dev(device_name);

    // Enable the read interrupts for the RS232 UART core 
    alt_up_rs232_enable_read_interrupt(RS232_DEV);

    if (RS232_DEV == NULL) {
        return 0;
    }
        
    return 1;
}


int BTUart::read_s(void)
{
    while (!read_ready()) {}    // Wait for data to be available to read

    alt_u8 buffer;
    alt_u8 parity_error;

    alt_up_rs232_read_data(RS232_DEV, &buffer, &parity_error);

    return (int) buffer;
}


int BTUart::write_s(alt_u8 data)
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


void BTUart::read_m(int *buffer, int length)
{
    int count;

    for (count = 0; count < length; count++) {
		buffer[count] = read_s();
	}
}


int BTUart::write_m(char data[], int length)
{
    int count;

	for (count = 0; count < length; count++) {
        // printf("Write from m: %c\n", data[count]);
		write_s(data[count]);
	}
    return count;
}


int BTUart::read_ready(void)
{
    alt_u16 read_fifo_used = alt_up_rs232_get_used_space_in_read_FIFO(RS232_DEV);
    return (read_fifo_used > READ_FIFO_EMPTY);
}


void BTUart::flush(void)
{
    while (read_ready()) {
        // read unwanted char out of fifo receiver buffer
        read_s();
    }
    return; // no more characters so return 
}