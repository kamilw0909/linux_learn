# sda* ==> sda partition number


# mkswap /dev/sda*
# swapon /dev/sda*

# mount os installation partition
#mount /dev/sda* /mnt


pacstrap -i /mnt base base-devel vim

# mkdir /mnt/boot/efi

# sda* => efi partition
# mount /dev/sda* /mnt/boot/efi


genfstab -U /mnt >> /mnt/etc/fstab


arch-chroot /mnt


vim /etc/locale.gen
# uncomment us and pl language
locale-gen

localectl set-locale LANG=pl_PL.UTF-8


tzselect
ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime


pacman -S intel-ucode linux linux-firmware


ls /boot
# shold output vmlinuz-linux


pacman -S refind
refind-install

# sda* --> sda where arch was install
#blkid /dev/sda* >> /boot/refind_linux.conf

vim /boot/refind_linux.conf
# PARTUUID xxx from blkid in end of file 
# change file to --> "Boot using default options" "root=PARTUUID=xxx rw add_efi_memmap initrd=boot\intel-ucode.img initrd=boot\initramfs-linux.img"

# change refind screen deafult resolution
# in refind.conf file change ->  resolution 1600 900


# add root password
passwd


echo kamil_my_komp_name > /etc/hostname

vim /etc/hosts
# add in file:
# 	127.0.0.1 localhost
# 	::1       localhost
# 	127.0.0.1 myComputerName


pacman -S sudo


useradd -m -G wheel,storage,power yourNewUser
passwd yourNewUser

EDITOR=vim visudo
# uncomment in file:
#	%wheel ALL=(ALL) ALL


## VIRTUAL ENVIRONMENT

pacman -S xf86-video-intel
pacman -S xorg xorg-server

# or another
pacman -S cinnamon nemo-fileroller

pacman -S lightdm lightdm-webkit2-greeter
vim /etc/lightdm/lightdm.conf
# scroll down to the [Seat:*] section. Uncomment the greeter-session line and set it to lightdm-webkit2-greeter
# uncomment display setup script and set it to xrandr -s 1600x900



## ADD APPS

pacman -S wpa_supplicant wireless_tools networkmanager nm-connection-editor network-manager-applet gnome-keyring pavucontrol pulseaudio alsa-utils git xf86-input-synaptics

systemctl enable NetworkManager.service

systemctl enable lightdm.service

# exit from arch-chroot
exit
shutdown now

# unplug pendrive and run pc


## APPS for work
# blueberry - bluetooth manager from linux mint
# terminator - terminal emulator
# vlc - music and video player
# gimp - image editor
# flameshot - screenshot 
# evince - gnome pdf viewer
# freeoffice - yay install
# yay for AUR app installation
# tlp power management
# ntfs-3g - for mounting ntfs filesystem

sudo pacman -S blueberry terminator vlc gimp flameshot evince tlp ntfs-3g
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S freeoffice


sudo rfkill unblock bluetooth
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

