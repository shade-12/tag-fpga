/*
 * wifi_task.c
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include "system.h"
#include "WiFiUart.h"
#include "../../src/terasic_includes.h"
#include "../../src/tasks.h"

char *str(volatile int *num);
char *patch_dnn_res(char *str);
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

    while (1) {
        if (patch_dnn_res(str) != NULL)
            printf("Response: %s\n", str);
    }

    return 0;
}


volatile int *tagid  = (volatile int *) 0x0a900000; /* tag id */
volatile int *rid    = (volatile int *) 0x0b001000; /* reading id */
volatile int *result = (volatile int *) 0x0b000000; /* dnn result */

const char *server_endpoint = "k7t0ap6b0i.execute-api.us-west-2.amazonaws.com";
const char *req = "PATCH /dev/sensors HTTP/1.1\r\n\
                  Host: k7t0ap6b0i.execute-api.us-west-2.amazonaws.com\r\n\
                  Content-Type: application/json\r\n\
                  \r\n\
                  tagId=";

const char *tagid_str = str(tagid);
const char *rid_str = str(rid);
const char *result_str = (result) ? "true" : "false";


/* Convert integer to string */
char * str(volatile int *num) {
    char snum[5];
    sprintf(snum, "%i", num);
    return snum;
}


char *patch_dnn_res(char *str)
{
    char *patch_result_req;
    patch_result_req = (char *) malloc(strlen(req) + strlen(tagid_str) + strlen(rid_str) + strlen(result_str) + 1); /* make space for the new string */
    strcpy(patch_result_req, req);
    strcat(patch_result_req, tagid_str);
    strcat(patch_result_req, "&readingId=");
    strcat(patch_result_req, rid_str);
    strcat(patch_result_req, "&poach=");
    strcat(patch_result_req, result_str);
    strcat(patch_result_req, "\r\n\r\n");

    bool success = true;
    char cmd_buffer[100];
    char buffer[1000];

    if (success) {
        sprintf(cmd_buffer, "AT+CIPSTART=\"TCP\",\"%s\",80", server_endpoint);
        success = WiFi_UART.send_command(cmd_buffer);
    }
    if (success) {
        sprintf(cmd_buffer, "AT+CIPSEND=%d", strlen(patch_result_req));
        success = WiFi_UART.send_command(cmd_buffer);
    }
    if (success) {
        success = WiFi_UART.send_data(patch_result_req, strlen(patch_result_req));
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
        printf("Response: %s\n", buffer);
    }

    if (success) {
        strcpy(str, buffer);
        return str;
    } else {
        return NULL;
    }
}