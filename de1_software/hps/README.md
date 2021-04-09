Steps to build preloader:

1. Go to `preloader/Makefile` > Comment out the following two lines:
    ```makefile
    @$(RM) $(PRELOADER_SRC_DIR)
	$(untar_recipe)
    ```

2. Run the following command in SoC EDS Command Shell (admin mode):
    ```sh
    tar zxf /cygdrive/c/intelFPGA/18.0/embedded/host_tools/altera/preloader/uboot-socfpga.tar.gz
    ```

3. Run `make`

* If you ever decide to move the project directory, you will have to regenerate the preloader. *