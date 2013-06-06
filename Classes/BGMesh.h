//
//  BBMesh.h
//  BallGame
//
//  Created by SDD on 3/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "BGPoint.h"

@interface BGMesh : NSObject {

	GLfloat * vertexes;
	GLfloat * colors;
	
	GLenum renderStyle;
	NSInteger vertexCount;
	NSInteger vertexStride;
	NSInteger colorStride;	
	
	BGPoint centroid;				//重心
	CGFloat radius;					//半径
}

@property (assign) NSInteger vertexCount;
@property (assign) NSInteger vertexStride;
@property (assign) NSInteger colorStride;
@property (assign) GLenum renderStyle;

@property (assign) BGPoint centroid;
@property (assign) CGFloat radius;

@property (assign) GLfloat * vertexes;
@property (assign) GLfloat * colors;

-(id)initWithVertexes:(CGFloat*)verts 
		   vertexCount:(NSInteger)vertCount 
		  vertexStride:(NSInteger)vertStride
		   renderStyle:(GLenum)style;

+(CGRect)meshBounds:(BGMesh*)mesh scale:(BGPoint)scale;

-(BGPoint)calculateCentroid;
-(CGFloat)calculateRadius;
-(void)render;

@end
