//
//  BGAnimation.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "BGAnimation.h"
#import "BGSwfMaker.h"
#import "BGAnimatedImageMesh.h"
#import "BGSceneController.h"
#import "PostionFunc.h"

@implementation BGAnimation

-(id) initWithAtlasKeys:(NSArray*)keys loops:(BOOL)loops
{
	self = [super init];
	if (self) {
		self.mesh = [BGSwfMaker animationFromAtlasKeys:keys];
		//[(BGAnimatedImage*)mesh setSpeed:speedValue];
		[(BGAnimatedImageMesh*)mesh setLoops:loops];
	}
	return self;
}

//通过一个整个系列来初始化
-(id) initwithTotalName:(NSString *)totalName loops:(BOOL)loops
{
	self = [super init];
	if (self) {
		self.mesh = [BGSwfMaker animationFromSwfName:totalName];
		[(BGAnimatedImageMesh*)mesh setLoops:loops];
	}
	return self;
}

-(void)awake
{
	translation = [PostionFunc turnPositonToScenePositon:self];	
	//[super awake];
}

//逐帧调用,设置需要显示的帧
-(void)update
{
	[super update];
	
	[(BGAnimatedImageMesh*)mesh updateAnimation];
	if ([(BGAnimatedImageMesh*)mesh didFinish]) 
	{
		[[BGSceneController sharedSceneController] removeObjectFromScene:self];	
	}	
}
@end
