Clean My Mac
============
    
macOS can become slow after being used for long time (e.g. 1 year). Deep clean right now is not possible without
paid software.
    
Most Mac cleaner apps don't really boost the performance as much as advertised. I have tried all sorts of existing apps inside and outside the App Store - the result wasn't promising.
    
So I come up with an idea of writing a shell script to do this.

I've tried this on 3 of my Mac computers, 2 MacBook Air machines and a iMac, all running Mac OS X 10.10.4.
The results were fantastic, I saved ~4.5 GB on both of the MacBook Air machines and ~7GB on my 2010 iMac, and it also sped up the system dramatically. I've also used this in speeding/cleaning up my family's older Macs, and it works quite well.

Known Bugs
=============
Notification Center layout and settings may be reset.

May cause macOS Lock Screen and Desktop wallpapers not to match.

Script Usage
=============
    
Download the script, execute, then enter your password when prompted:
```shell
sh clean_my_mac.sh
```
![http://i.imgur.com/L7gzMUK.gif](http://i.imgur.com/L7gzMUK.gif)
