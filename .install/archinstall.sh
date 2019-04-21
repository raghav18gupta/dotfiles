# # # # # # # # # # # # # # # # # # Resources # # # # # # # # # # # # # # # #
# https://dev.to/siatwe/install-a-minimal-arch-linux-in-half-an-hour--1l6p  #
# https://www.youtube.com/watch?v=dOXYZ8hKdmc&t=1400s                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # How to use this script: # # # #
# $ wget bit.ly/archinstaller         #
# $ mv archinstaller archinstaller.sh #
# $ chmod 777 archinstaller.sh        #
# $ ./archinstaller.sh                #
# # # # # # # # # # # # # # # # # # # #

# This script is buggy and not tested yet

# ----- Syncronize -----
sudo pacman -Syu
clear

# ----- Disk Partion -----
echo "
Installing Arch with UEFI+GPT.
Make sure you have following partions:

/dev/sda1   512M   Linux_Filesystem     (UEFI Bootloader)
/dev/sda2   >20G   Linux_Filesystem     (/)
/dev/sda3   Rest   Linux_Filesystem     (/home)

"
read "?Press enter to run 'cfdisk /dev/sda': "
cfdisk /dev/sda
clear

# ----- Partition Formatting -----
read "ask?Do you want to formate the partions by running:
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3

Type y/enter(no): "
if [ $ask = 'y' ];
then
    mkfs.fat -F32 /dev/sda1
    mkfs.ext4 /dev/sda2
    mkfs.ext4 /dev/sda3
fi
clear

# ----- Mount / and /home partions -----
echo "Mounting / and /home partions..."
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
echo "done!"
lsblk

# ----- install `base` and `base-devel` -----
read "?Press enter to install base and base-devel: "
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab
read "?Press enter to enter in newly installed system"
arch-chroot /mnt /bin/bash
clear
sudo pacman -Syu

# ----- generate locale.gen -----
echo "Uncomment 'en_US.UTF-8 UTF-8' in nano editor"
read "?Press enter if you are ready: "
nano /etc/locale.gen
locale-gen

# ----- set timezone -----
echo "setting timezone..."
ls -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc --utc

# ----- set hostname -----
read "host?Please give a good host-name for your PC: "
echo $host > /etc/hostname
echo "
127.0.1.1 localhost.localdomain $host
127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
" >> /etc/hosts

# ----- Install important packages -----
read "?Press enter to install important packages: "
pacman -S networkmanager zsh
systemctl enable NetworkManager

# ----- Set root password -----
read "?Set root password, press enter: "
passwd
clear

# ----- grub -----
echo "Installing grub..."
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI
echo 'bcf boot add 1 fs0:\EFI\GRUB\grub\grubx64.efi "Custom GRUB"
exit' > /boot/efi/startup.nsh

# ----- reboot -----
exit
echo "Arch Installation is completed!!!!
You can reboot and login as a root for now
"
read "?Press enter to reboot: "
umount -R /mnt
reboot
