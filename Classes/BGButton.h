//
//  BGButton.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBSceneObject.h"
@class BBSceneObject;

@interface BGButton:BBSceneObject 
{
	BOOL pressed;
	id target;
	SEL btnPressedHandler;
	SEL btnUpHandler;
	CGRect screenRect;
	
	GLfloat * normalColor;				//正常颜色
	GLfloat * pressedColor;				//按下去的颜色
	
	BOOL mouseEnable;
}

@property (assign) id target;
@property (assign) SEL btnPressedHandler;
@property (assign) SEL btnUpHandler;
@property (assign) BOOL mouseEnable;			//鼠标事件是否响应

- (void)awake;
- (void)handleTouches;
- (void)setNotPressedVertexes;
- (void)setPressedVertexes;
- (void)touchDown;
- (void)touchUp;
- (void)update;

-(id) init;

@end
