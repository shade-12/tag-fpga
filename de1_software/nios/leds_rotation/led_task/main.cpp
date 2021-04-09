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
  printf("NIOS II SOFTWARE APPLICATION: LED TEST\n");
  printf("===========================================\n\n");

  led_task();

  return 0;
}
