# 1. Start as root
sudo ./auto1_install_packages.sh

# 2. Create user
sudo ./auto2_create_user.sh

# 3. Switch to new user
su - ilorez

# 4. Continue as ilorez
./auto3_setup_git.sh
./auto4_setup_shell.sh
./auto5_install_nvim.sh
./auto6_network_packages.sh

