    //
//  B_PowerInfo.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_AtkDefStore.h"
#import "Constants.h"
#import "BattleFuncClass.h"
#import "UIDefine.h"

@implementation B_AtkDefStore

@synthesize type;
@synthesize curValue;
@synthesize tagShow;
@synthesize imageArr;

@synthesize maxValue;

@synthesize attackTimer;

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
		//[self showSkillImages];
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
			UIImageView * image= [BattleFuncClass getSkillImageByType:type index:[imageArr count] + 1];
			[imageArr addObject:image];
			[self.view addSubview:image];
		}
	}
	else if([imageArr count] > curValue)
	{
		int overValue = [imageArr count] - curValue;
		for (int i = 0; i < overValue; i++) {
			UIImageView *overImage = [imageArr objectAtIndex:[imageArr count] - i - 1];
			if (overImage) {
				[overImage setHidden:YES];
			}
		}
	}
	
	for (int i = 0; i < curValue; i++) {
		UIImageView * tempImage = [imageArr objectAtIndex:i];
		if (tempImage) {
			[tempImage setHidden:NO];
		}
	}
	
}

- (void)loadView 
{
	CGRect frame;

	frame = CGRectMake(10, 0, 50, 40);
	tagShow = [[UILabel alloc] initWithFrame:frame];
	
	if(type == attackTypeDefine) 
	{
		//表示攻击条
		tagShow.text = @"Attack";
		self.view = [[UIView alloc] initWithFrame:powerInfoFrameUserSide];
	}
	else 
	{
		//表示防守条
		tagShow.text = @"Defense";
		self.view = [[UIView alloc] initWithFrame:powerInfoFrameDefeSide];
	}
	
	self.view.backgroundColor = [UIColor whiteColor]; 
	
	imageArr = [[NSMutableArray alloc] init];
	
	[self.view addSubview:tagShow];
	
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
	tagShow = nil;
	tagShow = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc 
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
