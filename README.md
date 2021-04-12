# TAG - *The Animal Guardian* 🐘

## Hardware Accelerated DNN on DE1-SoC

This project implements a custom HPS/FPGA system on DE1-SoC that accelerates the human detection DNN and send the result to cloud database for storage. It acts as a remote server to RaspberryPi, where the RaspberryPi sends captured images to the DE1-SoC via Bluetooth, at a constant rate. Our custom embedded system then run the pre-trained DNN with the input image data, finally producing the result of whether or not a person is present in the image and send the final result to cloud database for storage via WiFi.


## HPS & FPGA High-Level Design

The system is created using *Qsys* in Quartus (v15.0).

![HPS/FPGA High-Level Design](https://github.com/shade-12/tag-fpga/blob/main/docs/img/High_Level_Design.png?raw=true)

### HPS

System components:
- Custom DNN Accelerator IP
- JTAG to FPGA bridge
- JTAG UART for ARM 0
- JTAG UART for ARM 1

Main functionalities:
- Accelerate the dot product calculation for pre-trained DNN
- Write DNN result to SDRAM


### FPGA

System components:
- NIOS II Processor
- System ID Peripheral
- JTAG UART
- SDRAM
- RS232 UART for WiFi chip (ESP8266) on RFS card
- RS232 UART for Bluetooth chip (HC-05) on RFS card
- DMA Controller

Main functionalities:
- Receive image data from RaspberryPi via Bluetooth
- Copy image data from FPGA memory address to HPS memory address using Altera DMA Controller core
- Receive DNN result from HPS
- Send DNN result to cloud database via WiFi


### Deep Neural Network Accelerator

The multi-layer perceptron (MLP) is used in this project to detect the human presence in our image dataset captured using a RaspberryPi camera. That is, our MLP will take a 28×50-pixel image as input and determine there is a human present in the image.

Our MLP consists of several linear layers that first multiply the previous layer's outputs by a weight matrix and add a constant “bias” value to each output, and then apply a non-linear activation function to obtain the current layer's outputs (called activations). Our MLP will have a 1400-pixel input (the 28×50-pixel image), two 1000-neuron hidden layers, and a 10-neuron output layer; the output neuron with the highest value will tell us which digit the network thinks it sees.

*Traning script for these networks is stored in a separate repository.*


### References

[1] [Cornell ECE5760 - DE1-SoC: ARM HPS and FPGA Addresses and Communication](https://people.ece.cornell.edu/land/courses/ece5760/DE1_SOC/HPS_peripherials/FPGA_addr_index.html)

[2] [SoC-FPGA Design Guide [DE1-SoC Edition]](https://github.com/sahandKashani/SoC-FPGA-Design-Guide/blob/master/DE1_SoC/SoC-FPGA%20Design%20Guide/SoC-FPGA%20Design%20Guide%20%5BDE1-SoC%20Edition%5D.pdf)

[3] [DE1-SoC User Manual](https://www.intel.com/content/dam/altera-www/global/en_US/portal/dsn/42/doc-us-dsnbk-42-1004282204-de1-soc-user-manual.pdf)

[4] [Design of Qsys system showcasing Nios II processor - SD card interface](https://www.youtube.com/watch?v=NmMX80iOAW4&ab_channel=IntelFPGA)

[5] [FPGA-to-HPS bridges Design Example](https://www.intel.com/content/www/us/en/programmable/support/support-resources/design-examples/soc/fpga-to-hps-bridges-design-example.html)