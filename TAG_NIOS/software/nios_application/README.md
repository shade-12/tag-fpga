### NIOS II based Software Application

#### DESCRIPTION:
Simple program that prints "Hello from Nios II"

The memory footprint of this hosted application is intended to be small (under 100 kbytes) by default
using a standard reference deisgn.


####  PERIPHERALS USED:
This application exercises the following peripherals:
- STDOUT device (UART or JTAG UART)


####  SOFTWARE SOURCE FILES:
This application includes the following software source files:
- main.c: Source file that runs the main application program.
- BTUart.h: Header file
- BTUart.cpp: 
- SDCard.h:
- SDCard.cpp:
- WiFiUart.h:
- WiFiUart.cpp:


#### BOARD/HOST REQUIREMENTS:
This application requires a JTAG connection with a Nios Development board. If
the host communication settings are changed from JTAG UART (default) to use a
conventional UART, a serial cable between board DB-9 connector and the host is
required.


#### THINGS TO NOTE:
1. To reduced the program memories size: Right click on `nios_application_bsp` > Properties >
Nios II BSP Properties > Check `Reduced device drivers`, `Support C++` and `Small C library`.

2. If you happened to update your system after creating the project, you will need to update the project
`Makefile` and re-generate the `BSP project`. To do this: Open the `BSP project` folder > 
Right click on `Makefile`> Select `Delete` > Open NIOS II Command Shell > Type 
`nios2-bsp-generate-files --settings="path/to/settings.bsp" --bsp-dir="path/to/project_bsp"` >
Clean and build project again
