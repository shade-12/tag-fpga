/*
 * main.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */

#include <stdio.h>
#include "../../src/terasic_includes.h"
#include "../../src/tasks.h"

int main()
{
  printf("NIOS II SOFTWARE APPLICATION: WIFI TEST\n");
  printf("===========================================\n\n");

  wifi_task();

  return 0;
}