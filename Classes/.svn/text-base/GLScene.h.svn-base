//
//  GLScene.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobjectContainer.h"
@class GLPowerSide;

@interface GLScene:GLDisplayobjectContainer
{
	GLPowerSide *leftSide;
	GLPowerSide *rightSide;
}

@property (nonatomic,retain) GLPowerSide *leftSide;
@property (nonatomic,retain) GLPowerSide *rightSide;

-(void) simuAttack;				//模拟电脑作出回击

-(void) initGLScene;			//初始化opengl的战斗场景

-(void) makeAttack:(int) atkType powerside:(GLPowerSide *)power;				//进行攻击

@end
