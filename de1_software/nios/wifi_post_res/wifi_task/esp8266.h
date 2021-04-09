/*
 * esp8266.h
 *
 *  Created on: 2016/10/7
 *      Author: User
 */

#ifndef ESP8266_H_
#define ESP8266_H_

#include <stdbool.h>

bool esp8266_init(bool reset);
bool esp8266_send_command(const char *cmd);
bool esp8266_send_data(const char *data, int length);
void esp8266_dump_rx();
void esp8266_listen();
char *esp8266_gets(char *buffer, int buffer_size);

#endif /* ESP8266_H_ */
