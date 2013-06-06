//
//  GLUnit.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLUnit.h"
#import "Constants.h"
#import "Values.h"
#import "UIDefine.h"
#import "BGSceneController.h"
#import "PostionFunc.h"
#import "SceneDefines.h"

@implementation GLUnit

@synthesize type;
@synthesize specialEffect;
@synthesize role;
@synthesize curArmCount;
@synthesize armCountShow;
@synthesize armyInfo;

-(void) setUnitRole:(int) role
{
	
}

-(void) setUnitType:(int) type
{
	
}

-(id) initWithIndex:(int) index army:(GLArmy *)army
{
	self = [super init];
	if (self) 
	{
		self.armyInfo = army;
		int posx = index * glUnitGap;
		self.scale = BGPointMake(unitWidth, unitHeight, 0);
		self.pos = BGPointMake(posx,0, 0);
		
		[self clearInfo];
	}
	return self;
}

-(void) clearInfo
{
	curArmCount = initArmCount;
	armCountShow.text = [NSString stringWithFormat:@"%d",curArmCount];
}

-(void) showAttackMove:(int)value				//单个unit的具体攻击
{
	
}

-(void) showdefenseMove:(int)value
{
	curArmCount -= value;
	armCountShow.text = [NSString stringWithFormat:@"%d",curArmCount];
}

- (void)dealloc {
	specialEffect = 0;
	type = 0;
	role = 0;
	curArmCount = 0;
	[armCountShow release];
    [super dealloc];
}

@end
