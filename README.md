CarScan
=======

This is a (currently) small Ruby program which processes an image to find cars on a street. The primary purpose of this would be to gauge traffic through traffic cameras.

Currently, the "object detection" is simplistic and quite primitive; in most cases, it will miss many potential objects for various reasons. The `ObjDetection` class matches the street against a typical street color (gray), and then groups all of the globs of pixels which it does not consider to be street. Finally, to rule out many globs which are probably *not* cars, it eliminates objects which are too out-of-proportion.

Result
======

In a matter of seconds, CarScan can scan this image:

![Original](https://github.com/unixpickle/CarScan/raw/master/img/D6Cam093.jpg)

Producing an image with all of the detected cars highlighted:

![Scanned for cars](https://github.com/unixpickle/CarScan/raw/master/img/carsdetected.png)
