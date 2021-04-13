/*
 * hps_application.h
 *
 *  Created on: Feb 20, 2021
 *      Author: Shade Wong
 */

#ifndef HPS_APPLICATION_H_
#define HPS_APPLICATION_H_

#include <stdbool.h>
#include <stdint.h>

#include "socal/hps.h"
#include "../hps_soc_system.h"

void setup_hps_timer();
void delay_us(uint32_t us);
void start_dma();

#endif /* HPS_APPLICATION_H_ */
