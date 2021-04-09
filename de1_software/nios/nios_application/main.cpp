/*
 * main.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include "terasic_includes.h"
#include "tasks.h"

#define RUN_BT    0
#define RUN_WIFI  0
#define RUN_LED   1

int main()
{
  printf("NIOS II SOFTWARE APPLICATION\n");
  printf("===========================================\n\n");

  #if (RUN_BT)
    bt_task();
  #endif

  #if (RUN_WIFI)
     wifi_task();
  #endif

  #if (RUN_LED)
     led_task();
  #endif

  return 0;
}
