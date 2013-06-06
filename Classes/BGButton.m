//
//  BGButton.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BGButton.h"
#import "BGMesh.h"
#import "BGInputViewController.h"
#import "BGSceneController.h"

static NSInteger BBSquareVertexStride = 2;
static NSInteger BBSquareColorStride = 4;

static GLenum BBSquareOutlineRenderStyle = GL_LINE_LOOP;
static NSInteger BBSquareOutlineVertexesCount = 4;
static CGFloat BBSquareOutlineVertexes[8] = {-0.5f,-0.5f,0.5f,-0.5f,0.5f,0.5f,-0.5f,0.5f};

static CGFloat BBSquareOutlineColorValues[16] = {1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0};

static GLenum BBSquareFillRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger BBSquareFillVertexesCount = 4;
static CGFloat BBSquareFillVertexes[8] = {-0.5,-0.5, 0.5,-0.5, -0.5,0.5, 0.5,0.5};

@implementation BGButton

@synthesize target,btnPressedHandler,btnUpHandler,mouseEnable;

-(id) init
{
	self = [super init];
	if (self) {
		normalColor = BBSquareOutlineColorValues;
		pressedColor = BBSquareOutlineColorValues;
	}
	return self;
}

-(void) awake
{
	pressed = NO;
	
	mesh = [[BGMesh alloc] initWithVertexes:BBSquareOutlineVertexes vertexCount:BBSquareOutlineVertexesCount
								 vertexStride:BBSquareVertexStride renderStyle:BBSquareOutlineRenderStyle];
	
	
	mesh.colors = normalColor;
	mesh.colorStride = BBSquareColorStride;
	
	screenRect = [[BGSceneController sharedSceneController].inputController 
				  screenRectFromMeshRect:self.meshBounds 
				  atPoint:CGPointMake(translation.x, translation.y)];		//获得自己在场景上的位置
}

-(void)update
{
	if (mouseEnable) 
	{
		[self handleTouches];
	}
	[super update];
}

-(void)handleTouches
{
	NSSet * touches = [[BGSceneController sharedSceneController].inputController touchEvents];
	if ([touches count] == 0) 
		return;
	
	BOOL pointInBounds = NO;
	for (UITouch * touch in [touches allObjects]) {
		CGPoint touchPoint = [touch locationInView:[touch view]];
		if (CGRectContainsPoint(screenRect, touchPoint)) 
		{
			pointInBounds = YES;
			
			if (touch.phase == UITouchPhaseStationary) 
			{
				[self touchDown];
			}
			if(touch.phase == 3)
			{
				[self touchUp];
			}
		}
	}
	if (!pointInBounds)
		[self touchUp];
}

-(void)touchDown
{
	if (pressed) 
		return; //当前已经按下
	pressed = YES;
	[self setPressedVertexes];
	if (btnPressedHandler) 
	{
		[target performSelector:btnPressedHandler];
	}
}

-(void)touchUp
{
	if (!pressed) 
		return; //当前没有按下
	pressed = NO;
	[self setNotPressedVertexes];
	if (btnUpHandler) 
	{
		[target performSelector:btnUpHandler];
	}
}

-(void)setPressedVertexes
{
	mesh.vertexes = BBSquareFillVertexes;
	mesh.renderStyle = BBSquareFillRenderStyle;
	mesh.vertexCount = BBSquareFillVertexesCount;	
	mesh.colors = pressedColor;
}

-(void)setNotPressedVertexes
{	
	mesh.vertexes = BBSquareFillVertexes;
	mesh.renderStyle = BBSquareFillRenderStyle;
	mesh.vertexCount = BBSquareFillVertexesCount;	
	mesh.colors = normalColor;
}

@end
