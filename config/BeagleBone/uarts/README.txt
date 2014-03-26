The source of the .dtbo files here is from this post:
http://www.armhf.com/index.php/beaglebone-black-serial-uart-device-tree-overlays-for-ubuntu-and-debian-wheezy-tty01-tty02-tty04-tty05-dtbo-files/

More related material here:
http://hipstercircuits.com/enable-serialuarttty-on-beaglebone-black/


BeagleBone system configuration steps (as root):
1) Copy the 2 .dtbo files to /lib/firmware

2) edit /etc/rc.local and add the following right before the final 'exit 0' line:

###################################################################
# initilize UART for LCD
/home/ubuntu/llt/config/BeagleBone/uarts/initialize_uarts.sh
#
sleep 3
#
# display DHCP assigned IP address on LCD
ruby /home/ubuntu/llt/config/BeagleBone/uarts/lcd-ip-addr.rb
###################################################################


3) reboot and run command below to confirm /dev/ttyO1 and /dev/ttyO2:

dmesg | grep ttyO

