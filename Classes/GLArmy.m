//
//  GLArmy.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLArmy.h"
#import "Constants.h"
#import "GLUnit.h"
#import "UIDefine.h"

@implementation GLArmy

@synthesize unitsObj;
@synthesize unitIndex;
@synthesize powerSide;

-(id) initWithPower:(GLPowerSide*) power;
{
	self = [super init];
	if (self) {
		
		self.pos = BGPointMake(armyInfoFrame.origin.x, armyInfoFrame.origin.y, 0);
		self.scale = BGPointMake(400, 60, 1);
		
		self.powerSide = power;
		
		unitsObj = [[NSMutableDictionary alloc] init];
		
		unitIndex = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:redCell],[NSNumber numberWithInt:blueCell],
					 [NSNumber numberWithInt:yellowCell],[NSNumber numberWithInt:orangeCell],[NSNumber numberWithInt:blackCell],nil];
		
		for (int i = 0; i < unitCount; i++)				//初始化unit
		{
			GLUnit* tempArmy = [[GLUnit alloc] initWithIndex:i army:self];
			[self addChild:tempArmy];
			if (power.sidetype == otherSide) {
				//tempArmy.scale
			}
			
			[unitsObj setObject:tempArmy forKey:[NSNumber numberWithInt:i]];
		}
	}
	return self;
}

-(void) makeUnitAttack:(int)type damavalue:(int) value			//攻击
{
	GLUnit *singleUnit = [unitsObj objectForKey:[NSNumber numberWithInt:type]];
	if (singleUnit) 
	{
		[singleUnit showAttackMove:value];
	}
}

-(Boolean) assignDamage:(int) value					//分配损失
{
	int totalDamage = value;
	for(NSNumber* index in unitIndex) 
	{
		GLUnit * singleUnit = [unitsObj objectForKey:index];
		if (singleUnit)
		{
			if (totalDamage <= singleUnit.curArmCount) {
				[singleUnit showdefenseMove:totalDamage];
				totalDamage = 0;
				break;
			}
			else {
				[singleUnit showdefenseMove:singleUnit.curArmCount];
				totalDamage -= singleUnit.curArmCount;
			}
		}
	}
	return (totalDamage <= 0);
}

@end
