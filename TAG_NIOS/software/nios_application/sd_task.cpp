/**
 * References:
 * https://www.youtube.com/watch?v=NmMX80iOAW4&ab_channel=IntelFPGA
 * file:///C:/altera/15.0/ip/altera/university_program/memory/altera_up_sd_card_avalon_interface/doc/SD_Card_Interface_for_SoPC_Builder.pdf
 * 
**/

#include <stdio.h>
#include "system.h"
#include "altera_up_sd_card_avalon_interface.h"

#define SDCARD_IFC_NAME (const char *)("/dev/sd_card_ic")


short int sd_fileh, sd_fileh2, att;
char buffer[512] = "WELCOME TO THE SD CARD AVALON INTERFACE :|";
char data[512];
int i, pixel, att3;


int sd_task()
{
    printf("SD CARD ACCESS TEST\n");
    printf("===========================================\n\n");

    alt_up_sd_card_dev *SDCARD_DEV = alt_up_sd_card_open_dev(SDCARD_IFC_NAME);

    if (SDCARD_DEV != 0) {
        printf("INIT SUCCESS: SD Card IP Core HAL device driver.\n");

        // Check if SD card is present at the SD card socket
        if (alt_up_sd_card_is_Present()) 
            printf("W FAT16: SD Card contains a FAT16 partition.\n");
        else
            printf("WTHT FAT16: SD Card does not contain a FAT16 partition.\n");

        
        // Create new text file and write data to it
        sd_fileh = alt_up_sd_card_fopen("test1.txt", true);

        if (sd_fileh < 0)
            printf("ERROR: Problem creating file - %i\n", sd_fileh);
        else {
            printf("SD ACCESS SUCCESS: Writing data to new file ...\n");

            int index = 0;

            // Write buffer data into test1.txt
            while (buffer[index] != '\0') {
                alt_up_sd_card_write(sd_fileh, buffer[index]);
                index = index + 1;
            }

            printf("WRITE DONE: All buffer data has been successfully written into file.\n");

            alt_up_sd_card_fclose(sd_fileh);
            printf("FILE CLOSED\n");
        }


        // Read text file from SD Card
        sd_fileh2 = alt_up_sd_card_fopen("test2.txt", false);

        if (sd_fileh2 > 0)
            printf("ERROR: Problem opening file - %i\n", sd_fileh2);
        else {
            printf("SD ACCESS SUCCESS: Reading data from opened file ...\n\n");

            // Read content from the text file
            for (i = 0; i < 12; i++) {
                data[i] = alt_up_sd_card_read(sd_fileh2);
                printf("%c", data[i]);
            }

            printf("\nREAD DONE: Closing file ...\n");
            alt_up_sd_card_fclose(sd_fileh2);

            printf("EXIT\n");
        }

    } else {
        printf("INIT ERROR: %s\n", SDCARD_DEV);
    }

    return 0;
}