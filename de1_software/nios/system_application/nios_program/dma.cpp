/*
 * dma.cpp
 *
 *  Created on: Mar 20, 2021
 *      Author: Shade Wong
 * 
 * References:
 * https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/nios2/n2cpu_nii51006.pdf
 */

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include "system.h"
#include "dma.h"
#include "sys/alt_dma.h"
#include "alt_types.h"

void *dnn_acc = (void *) 0xFF200000; /* DNN accelerator */
void *tag_id = (void *) 0x0A900000; /* tag id */

volatile int dma_complete = 0; /* flag used to indicate the transaction is complete */


/* function that is called when the transaction completes */
void dma_done(void* handle)
{
    dma_complete = 1;
}


int start_dma(void)
{
    alt_dma_txchan tx;

    /* Obtain a handle for the device */
    if ((tx = alt_dma_txchan_open (DMA_FPGA_TO_HPS_NAME)) == NULL)
    {
        printf ("Error: failed to open device\n");
        exit (1);
    }
    else
    {
        alt_dma_txchan_ioctl(tx, ALT_DMA_TX_ONLY_ON, dnn_acc);

        /* Post the transmit request */
        if (alt_dma_txchan_send (tx, tag_id, 1, dma_done, NULL) < 0)
        {
            printf ("Error: failed to post transmit request\n");
            exit (1);
        }
        /* Wait for the transaction to complete */
        while (!dma_complete);
        
        printf ("Transaction complete\n");
        alt_dma_txchan_close (tx);
    }

    return dma_complete;
}