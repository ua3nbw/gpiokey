# OrangePi GPIO Key

This is a modified WiringPi for OrangePi. We call it WiringOP. Test fo Orangepi pc

## Download
### For Orangepi Pi
     git clone https://github.com/WereCatf/WiringOP.git -b h3 

## Installation
    cd WiringOP
    chmod +x ./build
    sudo ./build
    cd ..
    git clone https://github.com/ua3nbw/gpiokey.git
    cd gpiokey
    gcc -o wpi wpi.c -lpthread -lwiringPi
    ./wpi &
    
   Thanks! 
    
