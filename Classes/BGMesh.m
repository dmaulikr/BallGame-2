//
//  BBMesh.m
//  BallGame
//
//  Created by SDD on 3/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BGMesh.h"

@implementation BGMesh

@synthesize vertexCount,vertexStride,colorStride,renderStyle,vertexes,colors,centroid,radius;

-(id)initWithVertexes:(CGFloat*)verts vertexCount:(NSInteger)vertCount vertexStride:(NSInteger)vertStride renderStyle:(GLenum)style
{
	self = [super init];
	if (self != nil) {
		self.vertexes = verts;
		self.vertexCount = vertCount;
		self.vertexStride = vertStride;
		self.renderStyle = style;
		self.centroid = [self calculateCentroid];
		self.radius = [self calculateRadius];
	}
	return self;
}

-(BGPoint)calculateCentroid
{
	CGFloat xTotal = 0;
	CGFloat yTotal = 0;
	CGFloat zTotal = 0;
	NSInteger index;
	// step through each vertex and add them all up
	for (index = 0; index < vertexCount; index++) {
		NSInteger position = index * vertexStride;
		xTotal += vertexes[position];
		yTotal += vertexes[position + 1];
		if (vertexStride > 2) 
			zTotal += vertexes[position + 2];
	}
	// now average each total over the number of vertexes
	return BGPointMake(xTotal/(CGFloat)vertexCount, yTotal/(CGFloat)vertexCount, zTotal/(CGFloat)vertexCount);
}

-(CGFloat)calculateRadius
{
	CGFloat rad = 0.0;
	NSInteger index;
	for (index = 0; index < vertexCount; index++) {
		NSInteger position = index * vertexStride;
		BGPoint vert;
		if (vertexStride > 2) {
			vert = BGPointMake(vertexes[position], vertexes[position + 1], vertexes[position + 2]);		
		} else {
			vert = BGPointMake(vertexes[position], vertexes[position + 1], 0.0);
		}
		CGFloat thisRadius = BBPointDistance(centroid, vert);
		if (rad < thisRadius) rad = thisRadius;
	}
	return rad;
}

//逐帧执行
-(void)render
{
	//画出图形
	glVertexPointer(vertexStride, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorStride, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);
	
	//opengle的混合功能，用来显示半透明
	glEnable(GL_BLEND);							
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
	
	//画
	glDrawArrays(renderStyle, 0, vertexCount);	
	glDisable(GL_BLEND);
	
}

+(CGRect)meshBounds:(BGMesh*)mesh scale:(BGPoint)scale
{
	if (mesh == nil) 
		return CGRectZero;
	// need to run through my vertexes and find my extremes
	if (mesh.vertexCount < 2) 
		return CGRectZero;
	CGFloat xMin,yMin,xMax,yMax;
	xMin = xMax = mesh.vertexes[0];
	yMin = yMax = mesh.vertexes[1];
	NSInteger index;
	for (index = 0; index < mesh.vertexCount; index++) {
		NSInteger position = index * mesh.vertexStride;
		if (xMin > mesh.vertexes[position] * scale.x) 
			xMin = mesh.vertexes[position] * scale.x;
		if (xMax < mesh.vertexes[position] * scale.x) 
			xMax = mesh.vertexes[position] * scale.x;
		if (yMin > mesh.vertexes[position + 1] * scale.y) 
			yMin = mesh.vertexes[position + 1] * scale.y;
		if (yMax < mesh.vertexes[position + 1] * scale.y) 
			yMax = mesh.vertexes[position + 1] * scale.y;
	}
	CGRect meshBounds = CGRectMake(xMin, yMin, xMax - xMin, yMax - yMin);
	if (CGRectGetWidth(meshBounds) < 1.0)
		meshBounds.size.width = 1.0;
	if (CGRectGetHeight(meshBounds) < 1.0) 
		meshBounds.size.height = 1.0;
	return meshBounds;
}

- (void) dealloc
{
	[super dealloc];
}

@end
