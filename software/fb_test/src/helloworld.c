/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xv_frmbufrd_l2.h"

XV_FrmbufRd_l2 FrmbufRd;

#define VIDEO_BUFFER_SIZE	(1024*1024*32)

uint8_t videoBuffer[VIDEO_BUFFER_SIZE];


int main()
{
    init_platform();

    print("Hello World\n\r");

    for(uint32_t* p = (uint32_t*)videoBuffer; p < (uint32_t*)(videoBuffer + VIDEO_BUFFER_SIZE); p++)
    {
    	*p = 0x000000FF;
    }

//    r = XVFrmbufRd_Initialize(&FrmbufRd, XPAR_V_FRMBUF_RD_0_DEVICE_ID);
//    assert(r == XST_SUCCESS);
//
//    r = XVFrmbufRd_SetMemFormat(&FrmbufRd,
//    		0,	// Stride
//			XVIDC_CSF_MEM_RGB8,
//			&FrmbufRd.Stream);
//    assert(r == XST_SUCCESS);
//
//    r = XVFrmbufRd_SetBufferAddr(&FrmbufRd,
//    		(UINTPTR)videoBuffer);
//    assert(r == XST_SUCCESS);
//
//    XVFrmbufRd_Start(&FrmbufRd);
//    while(1);
//    XVFrmbufRd_InterruptHandler();

    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_HWREG_WIDTH_DATA, 640);
    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_HWREG_HEIGHT_DATA, 480);
    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_HWREG_STRIDE_DATA, 0);
    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_HWREG_VIDEO_FORMAT_DATA, 20);
    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_HWREG_FRM_BUFFER_V_DATA, (UINTPTR)videoBuffer);

    XV_frmbufrd_WriteReg(XPAR_V_FRMBUF_RD_0_S_AXI_CTRL_BASEADDR, XV_FRMBUFRD_CTRL_ADDR_AP_CTRL, 0x81);
    while(1);

    cleanup_platform();
    return 0;
}
