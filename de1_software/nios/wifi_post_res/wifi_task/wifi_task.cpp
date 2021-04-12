/*
 * wifi_task.c
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include <string.h>
#include "system.h"
#include "WiFiUart.h"
#include "../../src/terasic_includes.h"
#include "../../src/tasks.h"

volatile int *tagid  = (volatile int *) 0x0a900000; /* tag id */
volatile int *result = (volatile int *) 0x0b000004; /* dnn result */


int wifi_task()
{
    WiFiUart WiFi_UART;

    int open_success = WiFi_UART.open(WIFI_RS232_UART_NAME);
    WiFi_UART.flush();

    if (!open_success) {
        printf("OPEN ERROR: RS232 UART port fail to open.\n");
        return 0;
    }

    int init_success = WiFi_UART.init();

    if (!init_success)
        return -1;

    WiFi_UART.update_entry(tagid, result);

    // Check if 200 is received
    int count = 0;
    char *buffer;

    while (!WiFi_UART.read_ready()) {}

    while (WiFi_UART.read_ready()) {
        buffer[count] = WiFi_UART.read_s();
        count++;
    }

    WiFi_UART.flush();
	
	if (strcmp(buffer,"200\r\n") == 0) {
        printf("UPDATE SUCCESS: Database entry updated.\n");
        return 1;
    }
	
    printf("ERROR: Failed to updated database entry.\n");
    return -1;
}