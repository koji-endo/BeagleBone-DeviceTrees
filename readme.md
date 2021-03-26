# BeagleBone Device Tree modified for Two-Photon projects

In this two-photon project, we focused on PRU, and so we set the BeagleBone AI's pin configuration as we can use PRU fully. Pin configuration methods have been changed recently. For example, Yoneda 2013 [^0] shows the following code, but actually, the `slots` file no longer exists. For detail, please take a look at [Beagleboard:BeagleBoneBlack Debian - eLinux.org](https://elinux.org/Beagleboard:BeagleBoneBlack_Debian)'s `Where did the slots file go` section.

```bash
# dtc = device tree compiler
dtc -O dtb -o pinctrl-gpio-00A0.dtbo -b 0 -@ pinctrl-gpio.dts
cp ./pinctrl-gpio-00A0.dtbo /lib/firmware/
# 
echo pinctrl-gpio >/sys/devices/bone_capemgr.8/slots
```

[^0]: Yoneda (2013) BeagleBone Blackで遊ぼう! 978-4-89977-393-1

So what you can do is 

1) edit `dts` file.

In short, you can create a custom `dts` file to assign GPIO pins. Following snippet was taken from `src/arm/am5729-beagleboneai-prugpuoff-in.dts`.

```
&cape_pins_default {  
 pinctrl-single,pins = <  
DRA7XX_CORE_IOPAD(0x350C, PIN_INPUT_PULLDOWN | MUX_MODE13) // P8.12(pr1_pru0_gpo3)
 ... LINES OMITTED ...
DRA7XX_CORE_IOPAD(0x3734, PIN_INPUT_PULLDOWN | MUX_MODE15) // P8.38(driver off)
 >;  
};  
```

Address `0x350C` shows physical address `0x4A00_350C`. Please see p.4651 of [^1]. 
`MUX_MODE13` means `0xD: pr1_pru0_gpo3`. You can see p.4842 of [^1], and know `MUX_MODE15` means `0xF: Driver off`. Also, you can find info from [System Reference Manual · beagleboard/beaglebone-ai Wiki](https://github.com/beagleboard/beaglebone-ai/wiki/System-Reference-Manual#6124-pru-icss1-pin-access).


[^1]: AM572x Sitara™ Processors Silicon Revision 2., 1.1(2019) `sypanse2:/home/common/ResearchProjects/00two-photon/refs/ti_manuals/am572x_trm.pdf`

2) compile the device tree binary.  
For requirements, please see [Dockerfile](./Dockerfile). Docker can create an empty environment easily and good for dependency testing.

```bash
make src/arm/am5729-beagleboneai-prugpuoff-in.dtb
```

3) put `dtb` file on `/boot/dtbs/`

Note if you're using linux machine, you can mount the micro SD card and edit from your PC. (Mac OS does not support ext4 format and Windows... I don't know at all.)

```
cp PATH_TO/am5729-beagleboneai-pruin.dtb /boot/dtbs/
```

4) edit `/boot/uEnv.txt`

At line 7, you can set `dtb=YOUR_CUSTOM_DTB_FILE`.

```
#Docs: http://elinux.org/Beagleboard:U-boot_partitioning_layout_2.0

uname_r=4.14.108-ti-r113
#uuid=
#dtb=
cmdline=coherent_pool=1M net.ifnames=0 rng_core.default_quality=100 quiet
dtb=am5729-beagleboneai-prugpuoff-in.dtb

#In the event of edid real failures, uncomment this next line:
#cmdline=coherent_pool=1M net.ifnames=0 rng_core.default_quality=100 quiet video=HDMI-A-1:1024x768@60e

#Use an overlayfs on top of a read-only root filesystem:
#cmdline=coherent_pool=1M net.ifnames=0 rng_core.default_quality=100 quiet overlayroot=tmpfs

##enable x15: eMMC Flasher:
##make sure, these tools are installed: dosfstools rsync
#cmdline=init=/opt/scripts/tools/eMMC/init-eMMC-flasher-v3-no-eeprom.sh
```

5) reboot BeagleBone AI
