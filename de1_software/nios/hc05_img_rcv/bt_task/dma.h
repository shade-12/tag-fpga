/*
 * dma.h
 *
 *  Created on: Mar 20, 2021
 *      Author: Shade Wong
 */

#ifndef DMA_H_
#define DMA_H_

/**
 * Write to DMA control port slave address to start DNN accelerator on HPS side.
 * 
 * @return 1 if write complete, 0 otherwise
 **/
int start_dma(void);

#endif /* DMA_H_ */