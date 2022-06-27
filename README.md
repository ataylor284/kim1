KIM-1 Programs
==============

Some just-for-fun programs I've been writing and playing around with on my Corsham KIM-1 clone.

* examples - some hello world type programs testing out the features
* supermon - a port of Jim Butterfield's supermon64
* msbasic - the original Microsoft 6502 BASIC interpreter via mist64
* btploader - a "papertape" loader that uses base64 instead of hex encoding
* scripts - some python scripts to do stuff like create btp files and send paper tape files to a serial port

Docker
------

I've included a Dockerfile to build everything.

```
docker build . -t kim-builder
docker run -it -v `pwd`:/build -w /build kim-builder:latest 
```

Scripts
-------

* to\_kim.py - send a papertape file to a KIM-1 via serial 
```
python ../scripts/to_kim.py -s -pL /dev/cu.usbserial-A50285BI < file.ptp 
```

* makebtp.py - convert a raw binary file to btp format
```
python scripts/makebtp.py -s 0x2000 bin/msbasic-kb9.bin | python ../scripts/to_kim.py -s /dev/cu.usbserial-A50285BI
```

Resources
---------

* https://archive.org/details/KIM-1_Users_Manual/mode/2up
* https://archive.org/details/The_First_Book_of_KIM/mode/2up
* https://www.commodore.ca/commodore-products/productscsg-mos-commodore-kim-1-history-pictures/
* https://www.corshamtech.com/product-category/kim-1-products/
