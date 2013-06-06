//
//  Sprite.h
//  SDD
// 用于播放的基类
//  Created by Scott Penberthy on 3/14/10.
//  Copyright 2010 Acme Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sprite : NSObject {
	CGFloat x;				// x 
	CGFloat y;				// y 
	CGFloat r;				// 红色
	CGFloat g;				// 绿色 
	CGFloat b;				// 蓝色 
	CGFloat alpha;			// alpha
	
	CGFloat contentWidth;			// width 
	CGFloat contentHeight;         // height 
	
	int frameCountPerLine;			//一行中保存了几张图片
	
	CGFloat scale;			// scale
	
	int frameIndex;				//记录帧图片中的第几个文件
	
	CGRect box;				//边界
	
	BOOL render;		// 是否正在渲染
	BOOL offScreen;		// 是否已经超出屏幕
}

@property (assign) BOOL wrap, render, offScreen;
@property (assign) CGFloat x, y, r, g, b, alpha;
@property (assign) CGFloat contentWidth, contentHeight, scale;
@property (assign) CGRect box;
@property (assign) int frameIndex,frameCountPerLine;

- (void) updateBox;
- (void) draw: (CGContextRef) context;

@end

