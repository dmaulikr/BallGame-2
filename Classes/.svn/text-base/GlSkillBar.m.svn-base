//
//  GlSkillBar.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GlSkillBar.h"
#import "UIDefine.h"
#import "Constants.h"
#import "ColorDefine.h"

@implementation GlSkillBar

@synthesize curSkillValue,tagname,colorViewContainer,colorBlock,skillAttack;

-(id) init
{
	self = [super init];
	if (self) {
		self.pos = BGPointMake(skillBarFrame.origin.x,skillBarFrame.origin.y, 0);
		self.scale = BGPointMake(skillBarFrame.size.width, skillBarFrame.size.height, 1);
	}
	return self;
}

-(void) initComponents					//清理控件
{
	tagname = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 20)];
	[tagname setText:@"Skill"];
	//[self addChild:tagname];
	
	colorViewContainer = [[GLDisplayobjectContainer alloc] init];
	colorViewContainer.pos = BGPointMake(skillColorContainerPosx, 0, 0);
	colorViewContainer.scale = BGPointMake(skillColorBlockWidth, skillBarFrame.size.height, 1);
	colorViewContainer.displayBackGroundColor = greenColor;
	[self addChild:colorViewContainer];
	colorViewContainer.clipContent = YES;
	
	colorBlock =[[GLDisplayobject alloc] init];
	colorBlock.pos = BGPointMake(0 - skillColorBlockWidth, 0, 0);
	colorBlock.scale = BGPointMake(skillColorBlockWidth, skillBarFrame.size.height, 1);
	colorBlock.displayBackGroundColor = yellowColor;
	[colorViewContainer addChild:colorBlock];
	
	[self clearInfo];
}

-(void) clearInfo
{
	curSkillValue = 0;
	skillAttack = 0;
	colorBlock.pos = BGPointMake(0 - skillColorBlockWidth, colorBlock.pos.y, colorBlock.pos.z);
}

-(void) updateShow:(int) oldValue				//更新显示
{
	if (oldValue == curSkillValue) 
	{
		return;
	}
	
	float posx = ((curSkillValue / maxBarValue) - 1)  * skillColorBlockWidth;	
	//colorBlock.pos = BGPointMake(posx, colorBlock.pos.y, colorBlock.pos.z);
	colorBlock.destion = BGPointMake(posx, colorBlock.pos.y, colorBlock.pos.z);
	colorBlock.duration = barChangeDuaration * 1000;
	[colorBlock startMove];
}

-(void) updateSkillValue:(int)value isAdd:(Boolean)add
{
	int oldValue = curSkillValue;
	if (add) 
	{
		curSkillValue += value;
	}
	else 
	{
		curSkillValue = value;
	}
	
	curSkillValue = MIN(curSkillValue,maxBarValue);			//不超过最大值
	
	if (curSkillValue == maxBarValue && oldValue < maxBarValue)					//士气蓄满
	{
		skillAttack++;
	}
	
	[self updateShow:oldValue];
}

- (void)dealloc {
	curSkillValue = 0;
	[tagname release];
	[colorViewContainer release];
	[colorBlock release];
	skillAttack = 0;
    [super dealloc];
}

@end
