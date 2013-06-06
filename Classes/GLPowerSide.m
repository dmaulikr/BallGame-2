//
//  GLPowerSide.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLPowerSide.h"
#import "GLArmy.h"
#import "Constants.h"
#import "GLScene.h"
#import "GlSkillBar.h"
#import "UIDefine.h"
#import "GLBattleStore.h"
#import "GLCellArea.h"
#import "BGMovieClip.h"

@implementation GLPowerSide

@synthesize battleView;
@synthesize armyView;
@synthesize sidetype;
@synthesize scene;
@synthesize atkPowerStore;
@synthesize defPowerStore;
@synthesize skillBar;

@synthesize opponent;

-(void) initPowerSide
{
	[atkPowerStore clearInfo];
	[defPowerStore clearInfo];
	[skillBar clearInfo];
}

-(void) initGLSideInfo
{	
	if (self.sidetype == userSide) {
		self.scale = BGPointMake(attackPoserSideFrame.size.width, attackPoserSideFrame.size.height, 0);
		self.pos = BGPointMake(attackPoserSideFrame.origin.x, attackPoserSideFrame.origin.y, 1);
	}
	else {
		self.pos = BGPointMake(defensePoserSideFrame.origin.x, defensePoserSideFrame.origin.y, 1);
		self.scale = BGPointMake(defensePoserSideFrame.size.width, defensePoserSideFrame.size.height, 0);
	}

	if (battleView == nil)
	{
		battleView = [[GLCellArea alloc] init];
		battleView.power = self;
		battleView.clipContent = YES;
		battleView.mouseChildren = YES;
		
		[self addChild:battleView];
		[battleView initGLBattle];
		
		if (self.sidetype == userSide) {
			battleView.mouseChildren = YES;
		}
	}
	
	if (atkPowerStore == nil) 
	{
		atkPowerStore = [[GLBattleStore alloc] initWithType:attackTypeDefine];
		[self addChild:atkPowerStore];
	}
	
	if (defPowerStore == nil)
	{
		defPowerStore = [[GLBattleStore alloc] initWithType:defenseTypeDefine];
		[self addChild:defPowerStore];
	}
	
	if (armyView == nil) 
	{
		armyView = [[GLArmy alloc] initWithPower:self];
		armyView.mouseChildren = NO;
		[self addChild:armyView];
	}
	
	if (skillBar == nil) 
	{
		skillBar = [[GlSkillBar alloc] init];
		[self addChild:skillBar];
		[skillBar initComponents];
	}
	
	BGMovieClip *testAnimation = [[BGAnimation alloc] initwithTotalName:@"002" loops:YES];
	testAnimation.scale = BGPointMake(175, 175, 1);
	testAnimation.pos = BGPointMake(110.0, 50.0, 0.0);
	[self addChild:testAnimation];
	[testAnimation release];
	
}

-(void) handleDisapperCell:(NSMutableDictionary *)cellTypeInfo cellType:(int)type			//更新攻击以及防守的数值
{
	if (cellTypeInfo == nil) {
		return;
	}
	for(NSNumber *key in cellTypeInfo)
	{
		int type = [key intValue];
		NSNumber *value = [cellTypeInfo objectForKey:key];
		if (type == attackTypeDefine) {
			[atkPowerStore increaseValue:[value intValue]];
		}
		else if (type == defenseTypeDefine) {
			[defPowerStore increaseValue:[value intValue]];
		}
	}
}

-(void) bearDamage:(int) value					//遭受损失
{	
	int damageValue = 0;
	int defensePointsLeft = 0;
	
	if (value > self.defPowerStore.curValue) {
		damageValue = value - self.defPowerStore.curValue;
		defensePointsLeft = 0;
	}
	else {
		damageValue = 0;
		defensePointsLeft = self.defPowerStore.curValue - value;
	}
	
	[self.defPowerStore updateValue:defensePointsLeft];
	
	Boolean isDead = [armyView assignDamage:damageValue];
	if (isDead) {
		//NSLog(@"one is dead!!");
	}
	
}

-(void) simuCelleClicked:(int)level				//模拟点击
{	
	int index = [battleView getCellToClick];
	GLCell *cell = [battleView getCellByIndex:index];
	if (cell) 
	{
		
		[battleView colorButtonClicked:cell];
	}
}

- (void)dealloc 
{
	[battleView release];
	[armyView release];
	[scene release];
	[atkPowerStore release];
	[defPowerStore release];
    [super dealloc];
}

@end
