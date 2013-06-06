//
//  Sprite.m
//  SDD
//
//  Created by Scott Penberthy on 3/14/10.
//  Copyright 2010 Acme Games. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite
@synthesize x,y,contentWidth,contentHeight,scale,frameIndex,box,wrap,render;
@synthesize r,g,b,alpha,offScreen,frameCountPerLine;

- (id) init
{
	self = [super init];
	if (self) 
	{
		wrap = NO;
		x = y = 0.0;
		contentWidth = contentHeight = 1.0;
		scale = 1.0;
		r = 1.0;
		g = 1.0;
		b = 1.0;
		alpha = 1.0;
		offScreen = NO;
		box = CGRectMake(0,0,0,0);
		frameIndex = 0;
		render = YES;
	}
	return self;
}

//画出自身的边界
- (void) outlinePath: (CGContextRef) context
{

	CGFloat w2 = box.size.width*0.5;
	CGFloat h2 = box.size.height*0.5;
	
	CGContextBeginPath(context);
	CGContextSetRGBStrokeColor(context, 0,1,0,alpha);
	CGContextMoveToPoint(context, -w2, h2);
	CGContextAddLineToPoint(context, w2, h2);
	CGContextAddLineToPoint(context, w2, -h2);
	CGContextAddLineToPoint(context, -w2, -h2);
	CGContextAddLineToPoint(context, -w2, h2);
	CGContextClosePath(context);
}

//自己填充
- (void) drawBody: (CGContextRef) context
{	
	CGContextSetRGBFillColor(context, r, g, b, alpha);
	[self outlinePath: context];	
	CGContextDrawPath(context,kCGPathFill);
}

#define kScreenWidth 320
#define kScreenHeight 480
- (void) updateBox
{
	CGFloat w = contentWidth*scale;
	CGFloat h = contentHeight*scale;
	CGFloat w2 = w*0.5;
	CGFloat h2 = h*0.5;
	CGPoint origin = box.origin;
	CGSize bsize = box.size;
	CGFloat left = -kScreenHeight*0.5;
	CGFloat right = -left;
	CGFloat top = kScreenWidth*0.5;
	CGFloat bottom = -top;
	
	offScreen = NO;
	if (wrap) {
		if ((x+w2) < left) x = right + w2;
		else if ((x-w2) > right) x = left - w2;
		else if ((y+h2) < bottom) y = top + h2;
		else if ((y-h2) > top) y = bottom - h2; 
	}
	else {
		offScreen = 
		((x+w2) < left) ||
		((x-w2) > right) ||
		((y+h2) < bottom) ||
		((y-h2) > top);
	}
	
	origin.x = x-w2*scale;
	origin.y = y-h2*scale;
	bsize.width = w;
	bsize.height = h;
	box.origin = origin;
	box.size = bsize;
}

- (void) draw: (CGContextRef) context
{
	CGContextSaveGState(context);
	
	//获得位置
	CGAffineTransform t = CGAffineTransformIdentity;
	t = CGAffineTransformScale(t,scale,scale);
	CGContextConcatCTM(context, t);
	
	[self drawBody: context];
	CGContextRestoreGState(context);
}

@end
