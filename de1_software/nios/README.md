## NIOS II based Software Application


### Description
This directory contains the main NIOS II-based software application, `system_application` that runs on FPGA for our project. The main tasks of the applciation are as follow:
- Wait for incoming image data from RaspberryPi via Bluetooth
- Incoming image data of size (28 x 50) is stored in a 1-D array of size 1400 in SDRAM
- After all bytes have been received, DMA controller write to DNN accelerator address
- Wait for human detection 1-bit result from HPS
- Send 1-bit result to cloud database with a PATCH request via WiFi

Other directories are created from NIOS II Eclipse Program to test the functionality of each individual component: bluetooth, wifi and leds.

### Main System Components
- NIOS II (1/e) processor
- SDRAM Controller
- RS232 UART for WiFi chip (ESP8266) on RFS card
- RS232 UART for Bluetooth chip (HC-05) on RFS card
- DMA Controller


###  Software Source Files
This `system_application` directory includes the following software source files:
- `main.cpp`: Runs the main application program.
- `bt_task.cpp`: Runs program that receive image from RaspberryPi via Bluetooth.
- `wifi_task.cpp`: Runs program that send DNN human detection result to cloud database.
- `BTUart.h`: `BTUart` object prototype
- `BTUart.cpp`: Functions implementation
- `WiFiUart.h`: Functions implementation
- `WiFiUart.cpp`: `WiFiUart` object prototype


### Board/Host Requirements
This application requires a JTAG connection with a Nios Development board. If the host communication settings are changed from JTAG UART (default) to use a conventional UART, a serial cable between board DB-9 connector and the host is required.


### Things to Note

1. To reduced the program memories size: Right click on `nios_application_bsp` > Properties > Nios II BSP Properties > Check `Reduced device drivers`, `Support C++` and `Small C library`.

2. If you happened to update your system after creating the project, you will need to update the project `Makefile` and re-generate the `BSP project`. To do this: Open the `BSP project` folder > Right click on `Makefile`> Select `Delete` > Open NIOS II Command Shell > Type `nios2-bsp-generate-files --settings="path/to/settings.bsp" --bsp-dir="path/to/project_bsp"` > Clean and build project again.
