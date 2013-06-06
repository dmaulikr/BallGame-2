//
//  GLDisplayobjectContainer.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLDisplayobjectContainer.h"
#import "BGSceneController.h"
#import "GLDisplayobject.h"

@implementation GLDisplayobjectContainer

@synthesize childArray,mouseChildren,clipContent;

-(id) init
{
	self = [super init];
	if (self) {
		childArray = [[NSMutableArray alloc] init];
		mouseChildren = YES;
	}
	return self;
}

-(void) adjustPos				//让每个child都调整坐标
{
	[super adjustPos];
	for (GLDisplayobject * singleChild in childArray) {
		if (singleChild) {
			[singleChild adjustPos];
		}
	}
}

-(void) setRealPos:(BGPoint) realPosition
{
	realPos = realPosition;
}

-(void) update
{
	[super update];
}

-(void) addChild:(GLDisplayobject *)child 			//增加child
{
	if (!child) {
		return;
	}
	if ([childArray containsObject:child]) {
		return;
	}
	
	[childArray addObject:child];
	[[BGSceneController sharedSceneController] addObjectToScene:child];
	child.parent = self;
	
	[child adjustPos];		//让新加入的child调整位置
	[child awake];
}

-(void) removeChild:(GLDisplayobject *)child		//移除child
{
	if (!child) {
		return;
	}
	if (![childArray containsObject:child]) {
		return;
	}
	[childArray removeObject:child];
	[[BGSceneController sharedSceneController] removeObjectFromScene:child];
}

-(void) startMove
{
	//BGPoint movedGap = BGPointMake(destion.x - self.pos.x, 
//								   destion.y - self.pos.y,
//								   destion.z - self.pos.z);		//这是移动的gap，用于移动child
	
	//for (GLDisplayobject * singleChild in childArray) 
//	{
//		if (singleChild) {
//			singleChild.destion = BGPointADDPoint(singleChild.pos, movedGap);
//			singleChild.duration = self.duration;
//			[singleChild startMove];
//		}
//	}
	
	[super startMove];
}

-(void) setMouseChildren:(BOOL)enabled;
{
	for (GLDisplayobject * singleChild in childArray) {
		if (singleChild) {
			singleChild.mouseEnable = enabled;
		}
	}
}

-(void) setVisible:(BOOL)bVisible
{
	visible = bVisible;
	for (GLDisplayobject * singleChild in childArray) {
		if (singleChild) {
			singleChild.visible	= bVisible;
		}
	}
}

-(void) dealloc
{
	[childArray release];
	[super dealloc];
}

@end
