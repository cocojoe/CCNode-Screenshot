Description
_________________

Take a screenshot

Installation
_________________

Simply drop both files into your project and include the header were required.

Supported
_________________

iOS4+, cocos2d 2.0, (Unofficial) cocos2d 1.0 (See Code)

ARC         
_________________

Works with ARC & Non-Arc

Tested      
_________________

iOS5 Simulator (All Devices)
iPhone (Retina) 5.1

Example
_________________

[self getScreenshot:^(UIImage *image){
    CCLOG(@"Saving Screenshot to Photo Album");
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
 }];
  
Misc
_________________

Any questions you can find me (@cocojoe) on the cocos2d forum: http://www.cocos2d-iphone.org/forum/ 
