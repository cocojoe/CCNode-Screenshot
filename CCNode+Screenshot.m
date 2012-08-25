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
 * Installation: Simply drop both files into your project and add #import "CCNode+Screenshot.h" were required.
 *
 * Supported   : iOS4+, cocos2d 2.0, (Unofficial) cocos2d 1.0 (See Below)
 * ARC         : Works with ARC & Non-Arc
 * Tested      : iOS5 Simulator (All Devices)
 *               iPhone (Retina) 5.1
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

#import "CCNode+Screenshot.h"
#import "CCDirector.h"
#import <objc/runtime.h>

static char SCREENSHOTBLOCK_KEY;

@implementation CCNode (Screenshot)

@dynamic completionBlock;

-(void) getScreenshot:(ScreenshotCompletionBlock) block;
{
    objc_setAssociatedObject(self, &SCREENSHOTBLOCK_KEY, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // Will be black screen if not scheduled
    [self scheduleOnce:@selector(screenshot:) delay:0];
}

#pragma mark Private API
-(void) screenshot:(ccTime) dt
{
    
    // cocos2d 1.0, change 'view' to 'openGLView'
    UIView * eagleView = (UIView*)[[CCDirector sharedDirector] view];
	GLint backingWidth, backingHeight;
    
	// Bind the color renderbuffer used to render the OpenGL ES view
	// If your application only creates a single color renderbuffer which is already bound at this point,
	// this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
	// Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
    // In Cocos2D the render-buffer is already binded (and it's a private property...).
    //	glBindRenderbufferOES(GL_RENDERBUFFER_OES, _colorRenderbuffer);
    
	// Get the size of the backing CAEAGLLayer
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    
	NSInteger x = 0, y = 0, width = backingWidth, height = backingHeight;
	NSInteger dataLength = width * height * 4;
	GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
	// Read pixel data from the framebuffer
	glPixelStorei(GL_PACK_ALIGNMENT, 4);
	glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
	// Create a CGImage with the pixel data
	// If your OpenGL ES content is opaque, use kCGImageAlphaNoneSkipLast to ignore the alpha channel
	// otherwise, use kCGImageAlphaPremultipliedLast
	CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGImageRef iref = CGImageCreate (
                                     width,
                                     height,
                                     8,
                                     32,
                                     width * 4,
                                     colorspace,
                                     // Fix from Apple implementation
                                     // (was: kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast).
                                     kCGBitmapByteOrderDefault,
                                     ref,
                                     NULL,
                                     true,
                                     kCGRenderingIntentDefault
                                     );
    
	// OpenGL ES measures data in PIXELS
	// Create a graphics context with the target size measured in POINTS
	NSInteger widthInPoints, heightInPoints;
	if (NULL != UIGraphicsBeginImageContextWithOptions)
	{
		// On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
		// Set the scale parameter to your OpenGL ES view's contentScaleFactor
		// so that you get a high-resolution snapshot when its value is greater than 1.0
		CGFloat scale = eagleView.contentScaleFactor;
		widthInPoints = width / scale;
		heightInPoints = height / scale;
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
	}
    
	CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    
	// UIKit coordinate system is upside down to GL/Quartz coordinate system
	// Flip the CGImage by rendering it to the flipped bitmap context
	// The size of the destination area is measured in POINTS
	CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
	CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);
    
	// Retrieve the UIImage from the current context
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	// Clean up
	free(data);
	CFRelease(ref);
	CFRelease(colorspace);
	CGImageRelease(iref);
    
    // Block Execution
    ScreenshotCompletionBlock completionBlock = objc_getAssociatedObject(self, &SCREENSHOTBLOCK_KEY);
    completionBlock(image);

}

@end
