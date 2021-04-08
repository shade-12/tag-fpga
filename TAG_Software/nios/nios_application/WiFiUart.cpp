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


int WiFiUart::connect()
{
	if (RS232_DEV == NULL) {
        printf("ERROR: Open RS232 port before conencting.\n");
        return 0;
    }

    char ssid[20], passwd[20];

    send_command("AT+CWMODE_CUR=1");    // Obtain current AT command version
    send_command("AT+CWLAPOPT=1,0x2");  // Get avaialble wifi ssid, sorted according to RSSI (signal strength)

    printf("Network Name (SSID) List:\n");
    send_command("AT+CWLAP");           // List available APs

    // Collect user input
    // printf("Enter the Network Name (SSID): ");
    // scanf("%s", ssid);
    // printf("\n");

    // printf("Enter the Password of Network Name (SSID): ");
    // scanf("%s", passwd);
    // printf("\n");

    // printf("Connecting to WiFi AP (SSID: %s)\n", ssid);

    // char cmd[100];
    // sprintf(cmd, "AT+CWJAP_CUR=\"%s\",\"%s\"", ssid, passwd);   // Connects to an AP

    // // Return the response obtained after sending AT command
    // // requesting wifi connection
    // return send_command(cmd);
    return 1;
}


int WiFiUart::send_command(const char *cmd)
{
    int count;

	for (count = 0; count < strlen(cmd); count++) {
		write_s(cmd[count]);
	}
    alt_u8 c = {'\r'};
    write_s(c);
    c = {'\n'};
    write_s(c);

    char buffer[1000];
    count = 0;

    while (read_ready()) {
        // read unwanted char out of fifo receiver buffer
        buffer[count] = read_s();
        count++;
    }

    if (strstr(buffer, "OK") != NULL) {
        if (strcmp("AT+CWLAP", cmd) == 0)
            printf("%s\n", buffer);
        return true;
    } else if (strstr(buffer, "ERROR") != NULL) {
        printf("AT ERROR: %s\n", buffer);
        return false;
    } else if (strstr(buffer, "FAIL") != NULL) {
        printf("AT ERROR: %s\n", buffer);
        return false;
    }

    printf("AT ERROR: Buffer empty.\n");
    return false;
}


int WiFiUart::send_data(const char *data, int length)
{
    int count;

	for (count = 0; count < length; count++) {
		write_s(data[count]);
	}

    char buffer[1000];
    count = 0;

    while (read_ready()) {
        // read unwanted char out of fifo receiver buffer
        buffer[count] = read_s();
        count++;
    }

    if (strstr(buffer, "SEND OK") != NULL) {
        return true;
    } else if (strstr(buffer, "SEND FAIL") != NULL) {
        printf("%s", buffer);
        return false;
    }

    return false;
}


void WiFiUart::gets(char *buffer, int length)
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
        printf("%s", data);
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