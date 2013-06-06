//
//  SwfImageParser.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwfImageParser.h"

@implementation SwfImageParser

@synthesize originalName;
@synthesize frameCount;
@synthesize frameWidth;
@synthesize frameHeight;
@synthesize frameCountPrtRow;

-(UIImage *) setFileName:(NSString *)name
{
	if (name == nil) 
	{
		return nil;
	}
	NSArray *nameTypeArr = [name componentsSeparatedByString:@"."];
	NSArray *nameArray = [[nameTypeArr objectAtIndex:0] componentsSeparatedByString:@"_"];
	
	originalName = [nameArray objectAtIndex:0];
	frameCount = [[nameArray objectAtIndex:1] intValue];
	frameWidth = [[nameArray objectAtIndex:2] intValue];
	frameHeight = [[nameArray objectAtIndex:3] intValue];
	frameCountPrtRow = [[nameArray objectAtIndex:4] intValue];
	
	bitmapArr = [[NSArray alloc] init];
	
	UIImage * image = [UIImage imageNamed:name];
	CGImageRef imageRef = image.CGImage;
	
	CGRect rect;

	int posX;
	int posY;
	//NSNumber *num;
	UIImage* result;
	for (int i = 0; i < 1; i++) 
	{
		posX = (i % frameCountPrtRow) * frameWidth;
		posY = i / frameCountPrtRow * frameHeight;
		
		//获得需要切的部分的rect
		rect = CGRectMake(posX, posY, frameWidth, frameHeight);
		//获得指定rect区域的位图信息
		CGImageRef partimgRef = CGImageCreateWithImageInRect(imageRef, rect);
		
		/*
		 //初始化需要呗绘制的图
		 CGContextRef bitmap = CGBitmapContextCreate(nil, 250, 250, 8, 4*250, CGImageGetColorSpace(partimgRef),kCGImageAlphaNoneSkipLast);
		 //将源图绘制到目的图，这是为了缩放
		 CGContextDrawImage(bitmap, CGRectMake(0, 0, 250, 250), partimgRef);	
		 //将绘制数据换成imageref
		 CGImageRef  ref = CGBitmapContextCreateImage(bitmap);
		 */
		
		result = [UIImage imageWithCGImage:partimgRef];
		
		/*
		 CGContextRelease(bitmap); 
		 CGImageRelease(ref);
		 */
	}
	
	return result;
	
}

@end
