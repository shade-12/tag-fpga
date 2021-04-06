/*
 * BTUart.h
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#ifndef CUart_H__
#define CUart_H_

#include "terasic_includes.h"




class CUart {
protected:
	int UartHandle;


public:
	CUart();
	virtual ~CUart();

	void  Open(char *pDeviceName);
	void  Close();
	bool  Write(char *pData, int nDataSize);
	bool  WriteString(char *pString);
	bool  Read(char *pBuffer, int nBufferSize, int *prx_len);
	bool  ReadWithTimeout(alt_u8 *pBuffer, alt_u16 nBufferSize, alt_u16 *prx_len, alt_u32 timeout);
	bool  NoneBlockingRead(char *pBuffer, int nBufferSize, int *prx_len);
};

#endif /* CUart_H_ */
