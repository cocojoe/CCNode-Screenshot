/*
 * CCNode+Screenshot for cocos2d: https://github.com/pedrohub/
 *
 * Created by Martin Walsh on 23/08/2012.
 * Copyright (c) 2012 Pedro LTD http://www.visitpedro.com All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Description : Take a screenshot
 * Installation: Simply drop both files into your project and include the header were required.
 *
 * Supported   : iOS4+, cocos2d 2.0, (Unoffical) cocos2d 1.0 (See Below)
 * ARC         : Works with ARC & Non-Arc
 * Tested      : iOS5 Simulator (All Devices)
 *             iPhone (Retina) 5.1
 *
 * Example:
 * [self getScreenshot:^(UIImage *image){
 *      CCLOG(@"Saving Screenshot to Photo Album");
 *      UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
 *  }];
 * 
 * Misc:
 * Any questions you can find me (@cocojoe) on the cocos2d forum: http://www.cocos2d-iphone.org/forum/ 
 */
