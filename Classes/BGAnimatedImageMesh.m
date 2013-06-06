//
//  BBAnimatedQuad.m
//  BallGame
//
//  Created by SDD on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BGAnimatedImageMesh.h"
#import "BGSceneController.h"

@implementation BGAnimatedImageMesh

@synthesize speed,loops,didFinish,curFrame,frameQuads;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.speed = 12; // 12 fps
		self.loops = NO;
		self.didFinish = NO;
		elapsedTime = 0.0;
	}
	return self;
}

-(void)addFrame:(BGImageMesh*)aQuad
{
	if (frameQuads == nil) 
		frameQuads = [[NSMutableArray alloc] init];
	[frameQuads addObject:aQuad];
}

-(void)updateAnimation
{
	if (loops) 
		curFrame = curFrame % [frameQuads count];
	if (curFrame >= [frameQuads count]) 
	{
		didFinish = YES;
		return;
	}
	[self setFrame:[frameQuads objectAtIndex:curFrame]];
	curFrame++;
}

-(void)setFrame:(BGImageMesh*)quad
{
	self.uvCoordinates = quad.uvCoordinates;
	self.materialKey = quad.materialKey;
}

- (void) dealloc
{
	[frameQuads release];
	uvCoordinates = 0;
	[super dealloc];
}

@end
