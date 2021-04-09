/*
 * main.c
 *
 *  Created on: 2016/10/14
 *      Author: User
 */

#include <stdio.h>
#include "system.h"
#include "esp8266.h"
#include <string.h>
#include <unistd.h>

char *get_time(char *str);

int main()
{
    printf("Hello from Nios II!\n");

    while (esp8266_init(true) == false) {
        usleep(3 * 1000 * 1000);
    }
    char str[100];
    int time;
    int hour, minute, second;
    while (1) {
        if (get_time(str) != NULL) {
            if (sscanf(str, "%d:%d:%d", &hour, &minute, &second) == 3) {
                time = hour * 10000 + minute * 100 + second;
                printf("Time: %d:%d:%d\n", hour, minute, second);
            }
        }
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
        success = esp8266_send_command(cmd_buffer);
    }
    if (success) {
        sprintf(cmd_buffer, "AT+CIPSEND=%d", strlen(get_time_request));
        success = esp8266_send_command(cmd_buffer);
    }
    if (success) {
        success = esp8266_send_data(get_time_request, strlen(get_time_request));
    }

    int length = 0;

    if (success) {
        while (1) {
            esp8266_gets(buffer, sizeof(buffer));
            if (strstr(buffer, "+IPD") != NULL) {
                length = strlen(buffer);
                while (1) {
                    esp8266_gets(buffer + length, sizeof(buffer) - length);
                    if (strcmp(buffer + length, "\r\n") == 0)
                        break;
                    length += strlen(buffer + length);
                }
                break;
            }
        }
        esp8266_gets(buffer, 9);
        printf("time: %s\n", buffer);
    }

    if (success) {
        strcpy(str, buffer);
        return str;
    } else {
        return NULL;
    }
}
