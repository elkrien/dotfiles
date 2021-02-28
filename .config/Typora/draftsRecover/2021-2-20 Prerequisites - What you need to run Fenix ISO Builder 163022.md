# Prerequisites - What you need to run Fenix ISO Builder

1. **The Operating System**: **Arch Linux** or its derivative (like *RebornOS*, *EndeavourOS*, *Manjaro*, etc.) on your build system.

2. **Python**: Install the package `python` on Arch based OSs.

   ```sh
   sudo pacman -S --needed python
   ```

3. **Pip**: Install the package `python-pip` on Arch based OSs.

   ```sh
   sudo pacman -S --needed python-pip
   ```

4. **Pipenv** Install the package `pipenv` by running the following command in a terminal:

   ```sh
   sudo pip install pipenv
   ```

5. **Other OS packages**: Install `git`, `linux-headers`, and `arch-install-scripts` on Arch based OSs.

   ```sh
   sudo pacman -S --needed git linux-headers arch-install-scripts
   ```

6. **Runtime dependencies**: Install the Python modules required for Fenix ISO Builder by running the following commands (replace `<project_base_dir>` with the appropriate directory):

   ```sh
   cd <project_base_dir>
   pipenv install
   ```

7. **The program itsself**: Download **Fenix ISO Builder** from `https://gitlab.com/rebornos-team/fenix/fenix-iso-builder`. Or just go to any directory you want to download it to, and run

   > ```
   > cd <dir_of_your_choice>
   > git clone https://gitlab.com/rebornos-team/fenix/fenix-iso-builder
   > ```

This will download the program. Its base directory would be `fenix-iso-builder`.

If you performed all the above steps successfully, congratulations! You are ready to run Fenix ISO Builder. Proceed to [Usage](https://rebornos-team.gitlab.io/fenix/fenix-iso-builder/usage.html#usage) for further steps.