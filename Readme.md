CCNode+Screenshot
=================

Description
___________

Take a screenshot

Installation
____________

Simply drop both files into your project and include the header were required.

Supported
_________

iOS4+, cocos2d 2.0, (Unofficial) cocos2d 1.0 (See Code)

ARC         
___

Supports ARC/Non-Arc

Tested      
______

* iOS5 Simulator (All Devices)
* iPhone (Retina) 5.1

Example
_______

```objective-c
[self getScreenshot:^(UIImage *image){
    CCLOG(@"Saving Screenshot to Photo Album");
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
 }];
```
  
Misc
____

Any questions you can find me (@cocojoe) on the cocos2d forum: 
http://www.cocos2d-iphone.org/forum/ 
