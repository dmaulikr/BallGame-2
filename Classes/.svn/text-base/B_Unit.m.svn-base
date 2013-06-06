//
//  B_Unit.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_Unit.h"
#import "Constants.h"
#import "Values.h"
#import "UIDefine.h"

@implementation B_Unit
@synthesize type;
@synthesize specialEffect;
@synthesize role;
@synthesize curArmCount;
@synthesize armCountShow;

-(void) setUnitRole:(int) role
{
	
}

-(void) setUnitType:(int) type
{
	
}

-(void) setUnitIndex:(int) index
{
	int posx = index * 100;
	CGRect frame = CGRectMake(posx, 0, unitWidth, unitHeight);
	[self.view setFrame:frame];
}

-(void)loadView
{
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, unitWidth, unitHeight)];
	self.view.backgroundColor = [UIColor brownColor];
	
	armCountShow = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
	armCountShow.center = self.view.center;
	[self.view addSubview:armCountShow];
	
	[self clearInfo];
	
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

-(void)viewDidLoad
{
	
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
