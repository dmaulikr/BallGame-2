//
//  BBTexturedButton.h
//  BallGame	带有图片的button显示
//
//  Created by SDD on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BGButton.h"
#import "BGImageMesh.h"

@interface BGGLButton : BGButton 
{
	BGImageMesh * upQuad;
	BGImageMesh * downQuad;
}

- (id) initWithUpKey:(NSString*)upKey downKey:(NSString*)downKey;
- (void) dealloc;
- (void)awake;
- (void)setNotPressedVertexes;
- (void)setPressedVertexes;
- (void)update;

@end
