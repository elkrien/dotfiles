# LINUX ARCH na IDEAPAD 100S-14IBR

Poniżej znajduje się instrukcja instalacji czystego Linux Arch na komputerze Lenovo Ideapad 100S-14IBR. Wykonuj komendy po kolei zgodne z poniższymi wskazówkami oraz opisem.

1. Ściągnij i nagraj na Pendrive ISO z systemem Linux Arch (np. używające Balena Etcher) - [https://archlinux.org/](https://archlinux.org/download/)

3. Ustaw układ klawiatury i wyświetlanie polskich znaków:

   ```sh
   loadkeys pl
   setfont Lat2-Terminus16.psfu.gz -m 8859-2
   ```
   
3. Podłącz się do sieci (słowo *haslodowifi* zastąp prawdziwym hasłem:

   ```sh
   bash
   iwctl station wlan0 scan
   iwctl --passphrase haslodowifi station wlan0 connect MM5
   ping archlinux.org (CTRL+C - żeby przerwać)
   ```

5. Zaktualizuj zegar systemowy:

   ```sh
   timedatectl set-ntp true
   ```
   
5. Formatowanie i montowanie partycji (są już stworzone):

   ```sh
   mkfs.fat -F32 /dev/mmcblk1p1
   mkswap /dev/mmcblk1p4
   swapon /dev/mmcblk1p4
   mkfs.ext4 /dev/mmcblk1p2
   mount /dev/mmcblk1p2 /mnt
   ```

6. Instalacja sterowników i pluginów do obsługi dźwięku:

   ```sh
   pacstrap /mnt base linux linux-firmware
   ```

7. Generowanie fstab i wejście do chroot:

   ```sh
   genfstab -U /mnt >> /mnt/etc/fstab
   arch-chroot /mnt
   ```

8. Ustawianie strefy czasowej i języka:

   ```sh
   ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
   hwclock --systohc
   pacman -S nano
   nano /etc/locale.gen 
   ```

   usuń znak # na początku linijek: 

   ```sh
   en_US.UTF-8 UTF-8  
   pl_PL.UTF-8 UTF-8
   ```

   ```sh
   locale-gen
   nano /etc/locale.conf  
   ```

   - dodaj: LANG=pl_PL.UTF-8
   nano /etc/vconsole.conf - dodaj: KEYMAP=pl

   Ustawianie nazwy hosta i tworzenie użytkownika:

   ```sh
   nano /etc/hostname - dodaj archLenovo
   nano /etc/hosts - dodaj:
   127.0.0.1	localhost
   ::1		localhost
   127.0.1.1	archLenovo.localdomain	archLenovo
   passwd - ustaw hasło root'a
   useradd -m mm
   passwd mm - ustaw hasło dla mm
   usermod -aG wheel,audio,video,optical,storage mm
   pacman -S sudo
   EDITOR=nano visudo - usuń # przy %wheel ALL=(ALL) ALL
   ```

   Instalacja serwisów sieciowych (m.in. samba, avahi):

   ```sh
    ./006-network-discovery.sh
   ```

   Instalacja czcionek:

   ```sh
   ./007-fonts.sh
   ```

   Instalacja aplikacji:

   ```sh
    ./008-applications.sh
   ```

   Instalacja terminala, zmiana shell i dostosowanie jego wyglądu:

   ```sh
    ./009-terminal.sh
   ```

   Instalacja bluetooth (opcjonalnie):

   ```sh
   ./010-bluetooth.sh
   ```

9. Uruchom ponownie komputer

   ```sh
   sudo reboot
   ```

10. Wyczyść cache po wszyskich instalacjach:

   ```sh
   sudo pacman -Sc
   ```

11. Przejdź do zabawy z dostosowaniem wyglądu systemu i aplikacji wg pliku XFCE-themes.md



 
