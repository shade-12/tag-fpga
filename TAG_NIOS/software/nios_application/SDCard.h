/*
 * SDCard.h
 *
 *  Created on: Mar 16, 2021
 *      Author: Shade Wong
 */
#ifndef SDCARD_H_
#define SDCARD_H_

#include "terasic_includes.h"
#include "altera_up_sd_card_avalon_interface.h"


class SDCard {
	protected:
		alt_up_sd_card_dev* SDCARD_DEV;			// Opened SDCARD device structure
	public:
		SDCard();
		virtual ~SDCard();

		/**
		 * Initializes the SD Card IP Core HAL device driver.
		 * @param device_name - the instance name of SD Card IP Core in the Qsys system
		 * @return 1 if sucess, 0 otherwise
		**/
		int open(const char *device_name);

		/**
		 * Checks if an SD card is present in the SD card socket.
         * @return true when an SD card is present in the SD card socket, and false otherwise
		 */
		bool card_present(void);
};

#endif /* SDCARD_H_ */