//
//  GLScene.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLScene.h"

#import "GLCell.h"
#import "GLPowerSide.h"
#import "BattleFuncClass.h"
#import "Constants.h"
#import "B_army.h"
#import "B_skillBar.h";
#import "UIDefine.h"
#import "GLBattleStore.h"

@implementation GLScene

@synthesize leftSide;
@synthesize rightSide;

-(void) simuAttack
{
	[rightSide simuCelleClicked:0];
}

-(void) initGLScene			//初始化opengl战斗场景的初始化
{
	if (leftSide == nil) {
		leftSide = [GLPowerSide alloc];
		leftSide.sidetype = userSide;
		leftSide.scene = self;
	}
	if (rightSide == nil) {
		rightSide = [GLPowerSide alloc];
		rightSide.sidetype = otherSide;
		rightSide.scene = self;
	}
	
	leftSide.opponent = rightSide;
	rightSide.opponent = leftSide;		

	
	self.pos = BGPointMake(0, 0, 0);
	self.realPos = BGPointMake(0, 0, 0);
	
	[leftSide initGLSideInfo];
	[rightSide initGLSideInfo];
	
	[self addChild:leftSide];
	[self addChild:rightSide];
}

-(void) makeAttack:(int) atkType powerside:(GLPowerSide *)power				//进行攻击
{
	if(power.atkPowerStore.curValue > 0)  			//如果攻击值大于0，进行攻击
	{	
		GLPowerSide *opponent = power.opponent;
		
		//实际使用到的攻击值
		[opponent bearDamage:power.atkPowerStore.curValue];
		
		[power.skillBar updateSkillValue:power.atkPowerStore.curValue isAdd:YES];
		
		[power.armyView makeUnitAttack:atkType damavalue:power.atkPowerStore.curValue];
		[power.atkPowerStore updateValue:0];					//进行攻击，清空攻击方的攻击值
		
	}
}

- (void)dealloc {
	[leftSide release];
	[rightSide release];
    [super dealloc];
}

@end