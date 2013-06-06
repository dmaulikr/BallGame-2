//
//  BBSceneObject.h
//  BBOpenGLGameTemplate
//
//  Created by SDD on 1/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "BGPoint.h"
#import "BGMesh.h"

@class BGMesh;

@interface BBSceneObject:NSObject {
	// transform values
	BGPoint translation;			//平移
	BGPoint rotation;				//旋转
	BGPoint scale;					//缩放
	BOOL visible;
	
	BGMesh * mesh;
	
	BOOL active;
	CGRect meshBounds;
}

@property (assign) BGPoint translation;
@property (assign) BGPoint rotation;
@property (assign) BGPoint scale;

@property (assign) BOOL active;

@property (retain) BGMesh * mesh;

@property (assign) CGRect meshBounds;

@property (assign) BOOL visible;

- (id) init;
- (void) dealloc;
- (void)awake;
- (void)render;
- (void)update;


@end
