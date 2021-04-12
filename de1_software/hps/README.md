### Generating a Header File for HPS Peripherals

1. Open the SoC EDS Command Shell in admistrator mode.

2. `cd` into your project directory, in our case, it is `tag-fpga`.

3.  Execute the following command:
```
$ sopc-create-header-files \
 de1_hardware/hps_fpga/tag_nios_system.sopcinfo \
 --single de1_software/hps/hps_soc_system.h --module ARM_A9_HPS
```

### Steps to Build Preloader

1. Go to `preloader/Makefile` > Comment out the following two lines:
    ```makefile
    @$(RM) $(PRELOADER_SRC_DIR)
	$(untar_recipe)
    ```

2. Run the following command in SoC EDS Command Shell (admin mode):
    ```sh
    tar zxf /cygdrive/d/tag2/de1_software/hps/preloader/uboot-socfpga.tar.gz
    ```

3. Run `make`

* If you ever decide to move the project directory, you will have to regenerate the preloader. *

### Reference

[1] [SoC-FPGA Design Guide [DE1-SoC Edition]](https://github.com/sahandKashani/SoC-FPGA-Design-Guide/blob/master/DE1_SoC/SoC-FPGA%20Design%20Guide/SoC-FPGA%20Design%20Guide%20%5BDE1-SoC%20Edition%5D.pdf)