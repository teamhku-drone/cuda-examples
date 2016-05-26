# cuda-examples
Learning simple CUDA examples

## Installation guide for CUDA 

```
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v3.0/cuda-repo-l4t-r21.3-6-5-prod_6.5-42_armhf.deb
sudo dpkg -i cuda-repo-l4t-r21.3-6-5-prod_6.5-42_armhf.deb
sudo apt-get update
sudo apt-get install cuda-toolkit-6-5
sudo usermod -a -G video ubuntu
echo ' ' >> ~/.bashrc
echo '# Cuda dependencies' >> ~/.bashrc
echo 'export PATH=/usr/local/cuda-6.5/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-6.5/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
```

## Installation guide for OpenCV built with CUDA
```
# Method 1
wget http://developer.download.nvidia.com/embedded/OpenCV/L4T_21.1/libopencv4tegra-repo_l4t-r21_2.4.10.1_armhf.deb
sudo dpkg -i libopencv4tegra-repo_l4t-r21_2.4.10.1_armhf.deb
sudo apt-get update
sudo apt-get install libopencv4tegra libopencv4tegra-dev

# Method 2 (Compile from scratch)
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 2.4
cd ..
mv opencv ~
cd ~/opencv
mkdir build
cd build
cmake -DWITH_CUDA=ON -DCUDA_ARCH_BIN="3.2" -DCUDA_ARCH_PTX="" -DBUILD_TESTS_OFF -DBUILD_PERF_TESTS=OFF ..
sudo make -j4 install
echo "# Use OpenCV and other custom-built libraries." >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/" >> ~/.bashrc
source ~/.bashrc
```
Reference: https://github.com/e-lab/torch-toolbox/blob/master/Tutorials/Install-CUDA-6.5-on-Jetson-TK1.md
