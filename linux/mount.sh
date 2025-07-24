lsblk -f

sudo mount /dev/sda1 /mnt/usb




cp /mnt/usb/A10_2.pem ~/
chmod 400 ~/A10_2.pem
scp -i ~/A10_2.pem -r ubuntu@132.145.137.151:/home/ubuntu/A10 /media/ubuntu/USB_Drive/Xtal_v6

sudo umount /media/ubuntu/USB_Drive/
