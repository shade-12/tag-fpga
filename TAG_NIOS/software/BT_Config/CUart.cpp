/*
 * BTUart.cpp
 *
 *  Created on: Mar 15, 2021
 *      Author: Shade Wong
 */
#include "CUart.h"
#include "sys/alt_dev.h"
#include "altera_avalon_uart.h"

CUart::CUart():
	// TODO Auto-generated constructor stub
	UartHandle(0)
{

}

CUart::~CUart() {
	// TODO Auto-generated destructor stub


}

void CUart::Open(char *pDeviceName)
{
	UartHandle = open(pDeviceName, O_ACCMODE); // open file for reading and writing
}

void  CUart::Close()
{
    if (UartHandle)
      close(UartHandle);
}

bool CUart::Read(char *pBuffer, int nBufferSize, int *prx_len){
	int nResult;
    bool bSuccess = FALSE;
    if (UartHandle){
        nResult = read(UartHandle, pBuffer, nBufferSize);
        if (nResult >= 0){
            *prx_len = nResult;
            bSuccess = TRUE;
            //if (*prx_len == nBufferSize)
            //    bSuccess = TRUE;
        }
    }
    return bSuccess;
}




bool  CUart::Write(char *pData, int nDataSize)
{
    bool bSuccess = FALSE;
    if (UartHandle){
    	write(UartHandle, pData, nDataSize);
        if (write(UartHandle, pData, nDataSize) == nDataSize)
            bSuccess = TRUE;
    }
    return bSuccess;
}


bool CUart::WriteString(char *pString)
{
	printf("TX--> %s\n",pString);
	return CUart::Write(pString, strlen(pString));
}

bool CUart::NoneBlockingRead(char *pBuffer, int nBufferSize, int *prx_len){
    bool bSuccess;
    fcntl(UartHandle, F_SETFL, O_ACCMODE | O_NONBLOCK);
    bSuccess = CUart::Read(pBuffer, nBufferSize, prx_len);
    fcntl(UartHandle, F_SETFL, O_ACCMODE);
    return bSuccess;
}


bool CUart::ReadWithTimeout(alt_u8 *pBuffer, alt_u16 nBufferSize, alt_u16 *prx_len, alt_u32 timeout){
    bool bSuccess = FALSE;
    if (UartHandle){
        int rx_total_cnt = 0, rx_cnt;
        alt_u32 time_start;
        bool bTimeout = FALSE;
        time_start = alt_nticks();
        while(!bSuccess && !bTimeout){
        	NoneBlockingRead((char *)pBuffer+rx_total_cnt, nBufferSize-rx_total_cnt, &rx_cnt);
            //rx_cnt = read(pUart, pBuffer+rx_total_cnt, nBufferSize-rx_total_cnt);
            rx_total_cnt += rx_cnt;
            if (rx_total_cnt == nBufferSize)
                bSuccess = TRUE;
            else if ((alt_nticks() - time_start) > timeout)
                bTimeout = TRUE;
            else
                usleep(1);
        }
        *prx_len = rx_total_cnt;
    }
    return bSuccess;
}
