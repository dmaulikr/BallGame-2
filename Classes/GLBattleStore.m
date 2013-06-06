//
//  GLBattleStore.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLBattleStore.h"
#import "Constants.h"
#import "BattleFuncClass.h"
#import "UIDefine.h"
#import "BGImage.h"
#import "ColorDefine.h"

@implementation GLBattleStore
@synthesize type,curValue,tagShow,imageArr,maxValue;
@synthesize attackTimer;

-(id) initWithType:(int) storeType
{
	self = [super init];
	if (self) {
		CGRect frame = CGRectMake(10, 0, 50, 40);
		tagShow = [[UILabel alloc] initWithFrame:frame];
		
		if(storeType == attackTypeDefine) 
		{
			//表示攻击条
			tagShow.text = @"Attack";
			self.pos = BGPointMake(powerInfoFrameUserSide.origin.x, powerInfoFrameUserSide.origin.y, 0);
			self.scale = BGPointMake(powerInfoFrameUserSide.size.width, powerInfoFrameUserSide.size.height, 1);
		}
		else 
		{
			//表示防守条
			tagShow.text = @"Defense";
			self.pos = BGPointMake(powerInfoFrameDefeSide.origin.x, powerInfoFrameDefeSide.origin.y, 0);
			self.scale = BGPointMake(powerInfoFrameDefeSide.size.width, powerInfoFrameDefeSide.size.height, 1);
		}
		self.displayBackGroundColor = whiteColor;
		imageArr = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void) clearInfo
{
	curValue = 0;
}

-(void) updateValue:(int) value			//更新数值
{
	int oldValue = curValue;
	curValue = value;
	if (type == defenseTypeDefine && oldValue > value)			//如果是盾牌，并且数量减少
	{
		attackTimer = [NSTimer scheduledTimerWithTimeInterval:defenseDecreaseTimrt target:self selector:@selector(showSkillImages) 
													 userInfo:nil repeats:NO];
	}
	else {
		[self showSkillImages];
	}
}

-(void) increaseValue:(int) value
{
	curValue += value;
	[self showSkillImages];
}

-(void) showSkillImages
{
	if ([imageArr count] < curValue) 
	{
		int lackCount = curValue - [imageArr count];
		for (int i = 0; i < lackCount; i++) 
		{
			BGImage * image= [BattleFuncClass getGlImageByType:type index:[imageArr count] + 1];
			[imageArr addObject:image];
			[self addChild:image];
			
		}
	}
	else if([imageArr count] > curValue)
	{
		int overValue = [imageArr count] - curValue;
		for (int i = 0; i < overValue; i++) {
			BGImage *overImage = [imageArr objectAtIndex:[imageArr count] - i - 1];
			if (overImage) {
				overImage.visible = NO;
			}
		}
	}
	
	for (int i = 0; i < curValue; i++) {
		BGImage * tempImage = [imageArr objectAtIndex:i];
		if (tempImage) {
			tempImage.visible = YES;
		}
	}
	
}

-(void)dealloc 
{ 
	type = 0;
	curValue = 0;
	maxValue = 0;
	
	[tagShow release];
	[imageArr release];
	[attackTimer release];
	
    [super dealloc];
}

@end
