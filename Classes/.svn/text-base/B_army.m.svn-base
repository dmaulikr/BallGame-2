//
//  B_army.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_army.h"
#import "Constants.h"
#import "B_Unit.h"
#import "UIDefine.h"

@implementation B_army

@synthesize unitsObj;
@synthesize unitIndex;

-(void)loadView
{	
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 170, 400, 60)];
	self.view.backgroundColor = [UIColor whiteColor];
	self.view.clipsToBounds = YES;
	
	unitsObj = [[NSMutableDictionary alloc] init];
	
	unitIndex = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:redCell],[NSNumber numberWithInt:blueCell],
				 [NSNumber numberWithInt:yellowCell],[NSNumber numberWithInt:orangeCell],[NSNumber numberWithInt:blackCell],nil];
	
	for (int i = 0; i < unitCount; i++)				//初始化unit
	{
		B_Unit* tempArmy = [B_Unit alloc];
		[self.view addSubview:tempArmy.view];
		//[tempArmy loadView];
		[tempArmy setUnitIndex:i];
		[unitsObj setObject:tempArmy forKey:[NSNumber numberWithInt:i]];
	}
}

-(void) makeUnitAttack:(int)type damavalue:(int) value			//攻击
{
	B_Unit *singleUnit = [unitsObj objectForKey:[NSNumber numberWithInt:type]];
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
		B_Unit * singleUnit = [unitsObj objectForKey:index];
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

-(void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)viewDidUnload {
	unitsObj = nil;
	unitIndex = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[unitsObj release];
    [super dealloc];
}


@end
