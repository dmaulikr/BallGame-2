//
//  MovieClip.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "McView.h"
#import "RoleSprite.h"
#import "Constants.h"
#import "UIDefine.h"

@implementation McView

@synthesize timer;
@synthesize curFrame;
@synthesize contentSprite;
@synthesize totalFrames;

-(void) setFileName:(NSString *)name					//设置资源文件的的路径
{	
	NSArray *nameTypeArr = [name componentsSeparatedByString:@"."];			//获得文件名
	NSArray *nameArray = [[nameTypeArr objectAtIndex:0] componentsSeparatedByString:@"_"];		//解析文件名
	
	//NSString *originalName = [nameArray objectAtIndex:0];				//文件名字本身，目前没有用处
	
	self.totalFrames = [[nameArray objectAtIndex:1] intValue];
	int contentWidth = [[nameArray objectAtIndex:2] intValue];
	int contentHeight = [[nameArray objectAtIndex:3] intValue];
	int frameCountPerLine = [[nameArray objectAtIndex:4] intValue];
	
	timer = [NSTimer scheduledTimerWithTimeInterval: 1.0/frmaePerSec
											 target:self 
										   selector:@selector(enterFrame) 
										   userInfo:nil 
											repeats:YES];
	
	int rows = self.totalFrames / frameCountPerLine + 1;
	
	contentSprite = [RoleSprite fromFile:name withRows: rows withColumns:frameCountPerLine
							contentWidth:contentWidth contentHeight:contentHeight];
	
	curFrame = 0;
	[self enterFrame];
}

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	// Reset the transformation
	CGAffineTransform t0 = CGContextGetCTM(context);
	t0 = CGAffineTransformInvert(t0);
	CGContextConcatCTM(context,t0);
	
	[contentSprite draw: context];
	
	CGContextRestoreGState(context);
}

//engerFrame处理函数
-(void)enterFrame
{
	contentSprite.frameIndex = curFrame;
	[self setNeedsDisplay];
	curFrame = (curFrame+1) % totalFrames;
}

-(void) play
{
}

-(void) stop
{
}

-(void) gotoAndPlay:(int)frame
{
	curFrame = frame;
	nextStopFrame = 0;
	needLoops = 0;
	[self play];
}

-(void) gotoAndStop:(int)frame
{
	curFrame = frame;
	nextStopFrame = 0;
	needLoops = 0;
	[self stop];
}	

-(void) playInterval:(int)startValue endIndex:(int)endValue loops:(int)loops			//播放一段区间动画区间
{
	startValue = MIN(startValue,totalFrames);
	endValue = MIN(endValue,totalFrames);
	
	startValue = MAX(startValue,1);
	endValue = MAX(endValue,1);
	
	if (endValue < startValue) {
		endValue = totalFrames;
	}
	
	curFrame = startValue;
	nextStopFrame = endValue;
	needLoops = loops;
	[self gotoAndPlay:curFrame];
}

- (void)dealloc {
	[contentSprite release];
	[timer invalidate];
	curFrame = 0;
    [super dealloc];
}


@end
