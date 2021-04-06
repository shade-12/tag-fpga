## TAG - *The Animal Guardian* 🐘

### Hardware Accelerated DNN on DE1-SoC

This project aims to develop a custom HPS and FPGA system that accelerates the human detection DNN and send the result to cloud database for storage. The system consists of an embedded softcore CPU, *Nios II* and a HPS component that uses the ARM processor on DE1-SoC board.


#### HPS & FPGA High-Level Design

##### HPS
- Custom DNN accelerator IP component to accelerate the dot product calculation

#### FPGA
- Receive image data from RaspberryPi via Bluetooth
- Write received image data into SD card
- Copy image data from FPGA memory address to HPS memory address using Altera DMA Controller core
- Receive DNN result from HPS
- Send DNN result to cloud database via WiFi


#### Deep Neural Network Accelerator

The multi-layer perceptron (MLP) is used in this project to detect the human presence in our image dataset captured using a RaspberryPi camera. That is, our MLP will take a 28×28-pixel 24bit RGB image as input and determine there is a human present in the image.

Our MLP consists of several linear layers that first multiply the previous layer's outputs by a weight matrix and add a constant “bias” value to each output, and then apply a non-linear activation function to obtain the current layer's outputs (called activations). Our MLP will have a 784-pixel input (the 28×28-pixel image), two 1000-neuron hidden layers, and a 10-neuron output layer; the output neuron with the highest value will tell us which digit the network thinks it sees.

* Traning script for these networks is stored in a separate repository.

