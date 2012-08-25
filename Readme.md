CCNode+Screenshot
=================

Description
-----------

Take a screenshot

Installation
------------

Simply drop both files into your project and add #import "CCNode+Screenshot.h" were required.

Supported
---------

iOS4+, cocos2d 2.0, (Unofficial) cocos2d 1.0 (See Code)

ARC         
---

Supports ARC/Non-Arc

Tested      
------

* iOS5 Simulator (All Devices)
* iPhone (Retina) 5.1

Example
-------

```smalltalk
[self getScreenshot:^(UIImage *image){
    CCLOG(@"Saving Screenshot to Photo Album");
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
 }];
```
  
Misc
----

Any questions you can find me (@cocojoe) on the cocos2d forum: 
http://www.cocos2d-iphone.org/forum/ 
