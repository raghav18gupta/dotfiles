# # # # # # # # # # # # # # # # # # Resources # # # # # # # # # # # # # # # #
# https://dev.to/siatwe/install-a-minimal-arch-linux-in-half-an-hour--1l6p  #
# https://www.youtube.com/watch?v=dOXYZ8hKdmc&t=1400s                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # Download this script: # # # # #
# $ wget bit.ly/archinstaller         #
# $ mv archinstaller archinstaller.sh #
# # # # # # # # # # # # # # # # # # # #

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
vared -p "Press any key to run 'cfdisk /dev/sda': " -c tmp
cfdisk /dev/sda
clear

# ----- Partition Formatting -----
vared -p "Do you want to formate the partions by running:
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3

Type y/anything else: " -c ask
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
vared -p "Press any key to install base and base-devel: " -c tmp
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab
vared -p "Press any key to enter in newly installed system" -c tmp
arch-chroot /mnt /bin/bash
clear
sudo pacman -Syu

# ----- generate locale.gen -----
echo "Uncomment 'en_US.UTF-8 UTF-8' in nano editor"
vared -p "Press any key if you are ready: " -c tmp
nano /etc/locale.gen
locale-gen

# ----- set timezone -----
echo "setting timezone..."
ls -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc --utc

# ----- set hostname -----
vared -p "Please give a good host-name for your PC: " -c host
echo $host > /etc/hostname
echo "
127.0.1.1 localhost.localdomain $host
127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
" >> /etc/hosts

# ----- Install important packages -----
vared -p "Press any key to install networkmanager: " -c tmp
pacman -S networkmanager zsh
systemctl enable NetworkManager

# ----- Set root password -----
vared -p "Set root password: " -c tmp
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
vared -p "Press any key to reboot: " -c tmp
umount -R /mnt
reboot
