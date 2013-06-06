//
//  BBTexturedButton.m
//  BallGame
//
//  Created by SDD on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BGGLButton.h"
#import "BGSwfMaker.h"
#import "BGSceneController.h"
#import "BGInputViewController.h"

@implementation BGGLButton

- (id) initWithUpKey:(NSString*)upKey downKey:(NSString*)downKey
{
	self = [super init];
	if (self != nil) {
		upQuad = [BGSwfMaker quadFromAtlasKey:upKey];
		downQuad = [BGSwfMaker quadFromAtlasKey:downKey];
		
		[upQuad retain];
		[downQuad retain];
	}
	return self;
}

-(void) setUpKey:(NSString *)upKey
{
	upQuad = [BGSwfMaker quadFromAtlasKey:upKey];
	[upQuad retain];
}

-(void) setDownKey:(NSString *)downKey
{
	downQuad = [BGSwfMaker quadFromAtlasKey:downKey];
	[downQuad retain];
}

//初始化
-(void)awake
{
	[self setNotPressedVertexes];
	screenRect = [[BGSceneController sharedSceneController].inputController 
								screenRectFromMeshRect:self.meshBounds 
								atPoint:CGPointMake(translation.x, translation.y)];	
}

-(void)setPressedVertexes
{
	self.mesh = downQuad;
}

-(void)setNotPressedVertexes
{
	self.mesh = upQuad;
}

- (void)update
{
	[super update];
}

- (void) dealloc
{
	[upQuad release];
	[downQuad release];
	[super dealloc];
}

@end
