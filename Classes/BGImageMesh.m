//
//  BGFrameImage.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BGImageMesh.h"
#import "BGMesh.h"
#import "BGSwfMaker.h"

static CGFloat BBTexturedQuadVertexes[8] = {-0.5,-0.5, 0.5,-0.5, -0.5,0.5, 0.5,0.5};
static CGFloat BBTexturedQuadColorValues[16] = {1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0};

@implementation BGImageMesh

@synthesize uvCoordinates,materialKey,alpha;

- (id) init
{
	self = [super initWithVertexes:BBTexturedQuadVertexes vertexCount:4 vertexStride:2 renderStyle:GL_TRIANGLE_STRIP];
	if (self != nil) {
		alpha = 1;
		//顶点
		uvCoordinates = (CGFloat *) malloc(8 * sizeof(CGFloat));
		colors = BBTexturedQuadColorValues;
		colorStride = 4;
	}
	return self;
}

//逐帧调用
-(void)render
{
	glVertexPointer(vertexStride, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorStride, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);	
	
	
	//opengle的混合功能，用来显示半透明
	glEnable(GL_BLEND);							
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
	
	if (materialKey != nil) {
		[BGSwfMaker bindMaterial:materialKey];
		
		glEnableClientState(GL_TEXTURE_COORD_ARRAY); 
		glTexCoordPointer(2, GL_FLOAT, 0, uvCoordinates);
	} 
	//渲染
	glDrawArrays(renderStyle, 0, vertexCount);	
	glDisable(GL_TEXTURE_2D);						//渲染之后解除绑定
	glDisable(GL_BLEND);							//关闭混合功能
}

- (void) dealloc
{
	free(uvCoordinates);
	[super dealloc];
}

@end
