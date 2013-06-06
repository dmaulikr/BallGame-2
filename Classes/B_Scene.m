    //
//  B_BattleScene.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_Scene.h"
#import "B_PowerSide.h"
#import "B_Cell.h"
#import "BattleFuncClass.h"
#import "Constants.h"
#import "B_AtkDefStore.h"
#import "B_army.h"
#import "B_skillBar.h";
#import "UIDefine.h"
#import "ColorDefine.h"

@implementation B_Scene

@synthesize leftSide;
@synthesize rightSide;

-(void) simuAttack
{
	[rightSide simuCelleClicked:0];
}

-(void)loadView
{	
	if (leftSide == nil) {
		leftSide = [B_PowerSide alloc];
		leftSide.sidetype = userSide;
		leftSide.scene = self;
	}
	if (rightSide == nil) {
		rightSide = [B_PowerSide alloc];
		rightSide.sidetype = otherSide;
		[BattleFuncClass setInteraction:NO onView:rightSide.view includeSelf:NO];				//电脑方不能点击
		rightSide.scene = self;
	}
	
	leftSide.opponent = rightSide;
	rightSide.opponent = leftSide;
	
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gameWidth, gameHeight)];
	
	[self.view addSubview:leftSide.view];
	[self.view addSubview:rightSide.view];
}

-(void) makeAttack:(int) atkType powerside:(B_PowerSide *)power				//进行攻击
{
	if(power.atkPowerInfo.curValue > 0)  			//如果攻击值大于0，进行攻击
	{	
		B_PowerSide *opponent = power.opponent;
		
		//实际使用到的攻击值
		[opponent bearDamage:power.atkPowerInfo.curValue];
	
		[power.skillBar updateSkillValue:power.atkPowerInfo.curValue isAdd:YES];
		
		[power.armyView makeUnitAttack:atkType damavalue:power.atkPowerInfo.curValue];
		[power.atkPowerInfo updateValue:0];					//进行攻击，清空攻击方的攻击值
		
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	rightSide = nil;
	leftSide = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[leftSide release];
	[rightSide release];
    [super dealloc];
}


@end
