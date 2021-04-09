/*
 * wifi_task.c
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include "system.h"
#include "terasic_includes.h"
#include "WiFiUart.h"
#include "tasks.h"


char *get_time(char *str);
WiFiUart WiFi_UART;


int wifi_task()
{
    int open_success = WiFi_UART.open(WIFI_RS232_UART_NAME);
    WiFi_UART.flush();

    if (!open_success) {
        printf("OPEN ERROR: RS232 UART port fail to open.\n");
        return 0;
    }

    int connect_success = WiFi_UART.connect();

    if (!connect_success)
        return 0;

    char str[100];
    int hour = 0, minute = 0, second = 0;

    while (1) {
        if (get_time(str) != NULL)
            printf("Time: %d:%d:%d\n", hour, minute, second);
    }

    return 0;
}

const char *time_server_domain = "demo.terasic.com";

const char *get_time_request =
        "GET /time/ HTTP/1.1\r\n\
Host: demo.terasic.com\r\n\
User-Agent: terasic-rfs\r\n\
\r\n\
";

char *get_time(char *str)
{
    bool success = true;
    char cmd_buffer[100];
    char buffer[1000];

    if (success) {
        sprintf(cmd_buffer, "AT+CIPSTART=\"TCP\",\"%s\",80",
                time_server_domain);
        success = WiFi_UART.send_command(cmd_buffer);
    }
    if (success) {
        sprintf(cmd_buffer, "AT+CIPSEND=%d", strlen(get_time_request));
        success = WiFi_UART.send_command(cmd_buffer);
    }
    if (success) {
        success = WiFi_UART.send_data(get_time_request, strlen(get_time_request));
    }

    int length = 0;

    if (success) {
        while (1) {
            WiFi_UART.gets(buffer, sizeof(buffer));
            if (strstr(buffer, "+IPD") != NULL) {
                length = strlen(buffer);
                while (1) {
                    WiFi_UART.gets(buffer + length, sizeof(buffer) - length);
                    if (strcmp(buffer + length, "\r\n") == 0)
                        break;
                    length += strlen(buffer + length);
                }
                break;
            }
        }
        WiFi_UART.gets(buffer, 9);
        printf("time: %s\n", buffer);
    }

    if (success) {
        strcpy(str, buffer);
        return str;
    } else {
        return NULL;
    }
}