/*
 * esp8266.c
 *
 *  Created on: 2016/10/7
 *      Author: User
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "system.h"
#include <fcntl.h>
#include <unistd.h>
#include "esp8266.h"
#include <string.h>
#include <altera_avalon_pio_regs.h>

#define esp8266_uart WIFI_RS232_UART_NAME
//#define ESP8266_DEBUG

FILE *esp8266_file;

void set_esp8266_file_blocking(bool blocking)
{
    if (blocking == false) {
        fcntl(fileno(esp8266_file), F_SETFL, O_NONBLOCK);
    } else {
        int file_fl = fcntl(fileno(esp8266_file), F_GETFL);
        file_fl = file_fl & ~O_NONBLOCK;
        fcntl(fileno(esp8266_file), F_SETFL, file_fl);
    }
}

bool esp8266_init(bool reset)
{
    bool bSuccess = true;
    esp8266_file = fopen(esp8266_uart, "rw+");
    if (esp8266_file == NULL) {
        printf("Open UART_0 failed\n");
        return false;
    }

    if (reset) {
        IOWR_ALTERA_AVALON_PIO_DATA(WIFI_RESET_BASE, 0);
        usleep(50);
        IOWR_ALTERA_AVALON_PIO_DATA(WIFI_RESET_BASE, 1);
        usleep(3 * 1000 * 1000);
        esp8266_dump_rx();
    }

    char ssid[20], passwd[20];
    esp8266_send_command("AT+CWMODE_CUR=1");
    esp8266_send_command("AT+CWLAPOPT=1,0x2");
    printf("Network Name (SSID) List:\n");
    esp8266_send_command("AT+CWLAP");
    printf("Enter the Network Name (SSID): ");
    scanf("%s", ssid);
    printf("\n");
    printf("Enter the Password of Network Name (SSID): ");
    scanf("%s", passwd);
    printf("\n");

    printf("Connecting to WiFi AP (SSID: %s)\n", ssid);
    char cmd[100];
    sprintf(cmd, "AT+CWJAP_CUR=\"%s\",\"%s\"", ssid, passwd);
    bSuccess = esp8266_send_command(cmd);
    if (bSuccess) {
        printf("Connect to WiFi AP successfully\n");
    } else {
        printf("Connect to WiFi AP failed\n");
    }

    return bSuccess;
}

char *esp8266_gets(char *buffer, int buffer_size)
{
    return fgets(buffer, buffer_size, esp8266_file);
}

bool esp8266_send_command(const char *cmd)
{
    fprintf(esp8266_file, "%s\r\n", cmd);
    int length = 0;
    char buffer[1000];
    while (1) {
        if (fgets(buffer + length, sizeof(buffer) - length,
                esp8266_file) != NULL) {
#ifdef ESP8266_DEBUG
            printf("%s", buffer + length);
#endif
            if (strstr(buffer + length, "OK") != NULL) {
                if (strcmp("AT+CWLAP", cmd) == 0) {
                    printf("%s", buffer);
                }
                return true;
            } else if (strstr(buffer + length, "ERROR") != NULL) {
                return false;
            } else if (strstr(buffer + length, "FAIL") != NULL) {
                return false;
            }
            length += strlen(buffer + length);
        }
    }
    return false;
}

bool esp8266_send_data(const char *data, int length)
{
    write(fileno(esp8266_file), data, length);

    length = 0;
    char buffer[1000];
    while (1) {
        if (fgets(buffer + length, sizeof(buffer) - length,
                esp8266_file) != NULL) {
#ifdef ESP8266_DEBUG
            printf("%s", buffer + length);
#endif
            if (strstr(buffer + length, "SEND OK") != NULL) {
                return true;
            } else if (strstr(buffer + length, "SEND FAIL") != NULL) {
                printf("%s", buffer);
                return false;
            }
            length += strlen(buffer + length);
        }
    }
    return false;
}

void esp8266_dump_rx()
{
    char buffer[1000];
    set_esp8266_file_blocking(false);
    while (esp8266_gets(buffer, sizeof(buffer)) != NULL) {
#ifdef ESP8266_DEBUG
        printf("%s", buffer);
#endif
    }
    set_esp8266_file_blocking(true);
    fflush(stdout);
}
