# LiFePO4wered host software on LibreElec

from Roman Sarin

```
1. Get another SD Card and install Raspbian
2. Go through the steps in the documentation to get the GIT depot onto your Raspbian install
3. Edit the lifepo4wered-daemon.c file and change the shutdown function to this:

void shutdown(void) {
  syslog(LOG_INFO, "LiFePO4wered/Pi triggered shutdown");
  char *params[6] = {"shutdown", "-h", "-t", "60", "now", NULL}; // shutdown halt in 10 seconds
  execv("/sbin/shutdown", params);
}

4. Build the files
5. Copy the BUILD directory to a USB stick
6. Shutdown the pi and swap to the LibreElec SD Card
7. Boot the pi
8. SSH into LibreElec 
9. Copy the files from the usb to sbin directory 
	a.  cp /media/ESD-USB/LiFePo4wered-Pi/build/DAEMON/lifepo4wered-daemon /usr/sbin/
	b.  cp /media/ESD-USB/LiFePo4wered-Pi/build/CLI/lifepo4wered-cli /usr/sbin
10. Make the files executable chmod u+x filenames
11. Make sure I2c is enabled by editing config.txt file
nano /flash/config.txt (at the end)

################################################################################
# Adding information to turn on i2c1 for later rpis
dtparam=i2c1=on
dtparam=i2s=on

12. nano /storage/.config/autostart.sh
	
	(
	        ~/LiFePO4wered-Pi/build/DAEMON/lifepo4wered-daemon
	)&
	
13. Now manually start the daemon so you can configure it
14. Now configure it, I'm using the following, this makes sure the Pi starts up when plugged in and shutsdown cleanly when power is removed. However it also means you can't power it off in software it'll just reboot again.
	a. lifepo4wered-cli set AUTO_SHDN_TIME 2
	b. lifepo4wered-cli set AUTO_BOOT 3
	c. lifepo4wered-cli set CFG_WRITE 0x46 
15. Now reboot the Pi and start testing.
```
