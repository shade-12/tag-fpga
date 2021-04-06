/*
 * BTUart.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#include "BTUart.h"
#include "sys/alt_dev.h"
#include "altera_up_avalon_rs232.h"


BTUart::BTUart():
	// TODO Auto-generated constructor stub
	// RS232_DEV(0);
{

}


BTUart::~BTUart() {
	// TODO Auto-generated destructor stub

}


int BTUart::open(const char *device_name)
{
	RS232_DEV = alt_up_rs232_open_dev(device_name);

    // Enable the read interrupts for the RS232 UART core 
    alt_up_rs232_enable_read_interrupt(RS232_DEV);

    if (RS232_DEV == NULL)
        return 0;
    else
        return 1;
}


int BTUart::read_s(alt_u8 buffer, alt_u8 parity_error)
{
    READ_FIFO_USED = alt_up_rs232_get_used_space_in_read_FIFO(RS232_DEV);

    if (READ_FIFO_USED > READ_FIFO_EMPTY) {
        alt_printf("char stored in read_FIFO: %x\n", READ_FIFO_USED);
        alt_up_rs232_read_data(RS232_DEV, &buffer, &parity_error);
        alt_printf("read %c from RS232 UART\n", buffer);

        return 1;
    }

    return 0;
}


int BTUart::write_s(alt_u8 data)
{
    alt_up_rs232_disable_read_interrupt(RS232_DEV);

    int result = 0;
    WRITE_FIFO_SPACE = alt_up_rs232_get_available_space_in_write_FIFO(RS232_DEV);

    if (WRITE_FIFO_SPACE >= WRITE_FIFO_EMPTY) {
        alt_up_rs232_write_data(RS232_DEV, data);
        alt_printf("write %c to RS232 UART\n", data);
        result = 1;
    }

    // Enable the read interrupts for the RS232 UART core 
    alt_up_rs232_enable_read_interrupt(RS232_DEV);
    return result;
}


void BTUart::read_m(alt_u8 *buffer, int length)
{
    int count, success;
    alt_u8 p_error;

    for (count = 0; count < length; count++) {
		success = read_s(buffer[count], p_error);
        if (p_error || !success)
            printf("Fail to read char at %d\n", count);
	}
}


int BTUart::write_m(char data[], int length)
{
    int count;

	for (count = 0; count < length; count++) {
		write_s((alt_u8) data[count]);
	}
    return count;
}
