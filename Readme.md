CCNode+Screenshot
=================

Description
-----------

Nice and easy way to take a screenshot

Installation
------------

Simply drop both files into your project and add #import "CCNode+Screenshot.h" were required.

iOS6 Notes
----------

I have not tried on an iOS6 device yet however I have heard that you may end up with a black screen, if this
is the case please try enabling the preserveBackbuffer in your AppDelegate.

```smalltalk
CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
    pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
	depthFormat:0	//GL_DEPTH_COMPONENT24_OES
	preserveBackbuffer:YES
	sharegroup:nil
	multiSampling:NO
	numberOfSamples:0];
```

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
