//
//  BBSceneObject.m
//  BBOpenGLGameTemplate
//
//  Created by SDD on 1/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BBSceneObject.h"
#import "BGSceneController.h"
#import "BGInputViewController.h"
#import "BGMesh.h"

#pragma mark Spinny Square mesh
static CGFloat spinnySquareVertices[8] = {
-0.5f, -0.5f,
0.5f,  -0.5f,
-0.5f,  0.5f,
0.5f,   0.5f,
};

static CGFloat spinnySquareColors[16] = {
1.0, 1.0,   0, 1.0,
0,   1.0, 1.0, 1.0,
0,     0,   0,   0,
1.0,   0, 1.0, 1.0,
};

@implementation BBSceneObject

@synthesize translation,rotation,scale,active,visible;

@synthesize mesh,meshBounds;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		translation = BGPointMake(0.0, 0.0, 0.0);
		rotation = BGPointMake(0.0, 0.0, 0.0);
		scale = BGPointMake(1.0, 1.0, 1.0);
		
		visible = YES;
		active = NO;
		meshBounds = CGRectZero;
	}
	return self;
}

//创建的时候执行一次
-(void)awake
{
	mesh = [[BGMesh alloc] initWithVertexes:spinnySquareVertices vertexCount:4 vertexStride:2 renderStyle:GL_TRIANGLE_STRIP];
	
	[mesh calculateCentroid];
	
	mesh.colors = spinnySquareColors;
	mesh.colorStride = 4;
}

//更新数据
-(void)update
{
	if (!visible) {
		return;
	}
	NSSet * touches = [[BGSceneController sharedSceneController].inputController touchEvents];
	for (UITouch * touch in [touches allObjects]) {
		if (touch.phase == UITouchPhaseEnded) 
		{
			active = !active;				
		} 
	}
}

//渲染
-(void)render
{
	if (!visible) {
		return;
	}
	// clear the matrix
	glPushMatrix();
	glLoadIdentity();
	
	//移动到特定位置
	glTranslatef(translation.x,translation.y,translation.z);
	
	//rotate
	glRotatef(rotation.x, 1.0f, 0.0f, 0.0f);
	glRotatef(rotation.y, 0.0f, 1.0f, 0.0f);
	glRotatef(rotation.z, 0.0f, 0.0f, 1.0f);
	
	//scale
	glScalef(scale.x, scale.y, scale.z);
	
	[mesh render];
	
	//restore the matrix
	glPopMatrix();
}

-(CGRect) meshBounds
{
	if (CGRectEqualToRect(meshBounds, CGRectZero)) {
		meshBounds = [BGMesh meshBounds:mesh scale:scale];
	}
	return meshBounds;
}

- (void) dealloc
{
	//meshBounds = nil;
	[super dealloc];
}

@end
