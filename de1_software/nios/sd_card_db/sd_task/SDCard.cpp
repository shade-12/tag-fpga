/*
 * SDCard.cpp
 *
 *  Created on: Mar 16, 2021
 *      Author: Shade Wong
 */
#include "SDCard.h"
#include "sys/alt_dev.h"
#include "altera_up_sd_card_avalon_interface.h"


SDCard::SDCard()
{
    // TODO Auto-generated constructor stub
}


SDCard::~SDCard()
{
	// TODO Auto-generated destructor stub
}


int SDCard::open(const char *device_name)
{
	SDCARD_DEV = alt_up_sd_card_open_dev(device_name);

    if (SDCARD_DEV == 0) {
        return 0;
    }
        
    return 1;
}


bool SDCard::card_present(void)
{
    return alt_up_sd_card_is_Present();
}