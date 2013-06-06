//
//  BBAnimatedQuad.h
//  BallGame
//	显示动画的类
//  Created by ben SDD
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "BGImageMesh.h"

@interface BGAnimatedImageMesh:BGImageMesh 
{
	NSMutableArray * frameQuads;		//所有需要显示的帧动画
	CGFloat speed;						//速度
	NSTimeInterval elapsedTime;
	BOOL loops;
	BOOL didFinish;
	int curFrame;
}

@property (assign) CGFloat speed;
@property (assign) BOOL loops;
@property (assign) BOOL didFinish;
@property (assign) int curFrame;
@property (nonatomic,retain) NSMutableArray * frameQuads;

- (id) init;
- (void) dealloc;
- (void)addFrame:(BGImageMesh*)aQuad;
- (void)setFrame:(BGImageMesh*)quad;
- (void)updateAnimation;

@end
