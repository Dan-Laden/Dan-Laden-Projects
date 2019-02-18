#### DO NOT ATTEMPT TO EXECUTE!!!! ####
# copy the downloaded tar into /tmp
cp ~/Downloads/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz /tmp
# move to /tmp and unpack the copied tar
cd /tmp
tar xf gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz
# move into the unpacked directory
cd gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu
# install
sudo cp -r aarch64-linux-gnu/* /usr/aarch64-linux-gnu
sudo cp -r bin/* /usr/bin
sudo cp -r include/* /usr/include
sudo cp -r lib/* /usr/lib
sudo cp -r libexec/* /usr/libexec
sudo cp -r share/* /usr/share