    //
//  B_skillBar.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_skillBar.h"
#import "UIDefine.h"
#import "Constants.h"

@implementation B_skillBar

@synthesize curSkillValue;
@synthesize tagname;
@synthesize colorViewContainer;
@synthesize colorBlock;
@synthesize skillAttack;

-(void)loadView 
{
	self.view = [[UIView alloc] initWithFrame:skillBarFrame];
	//self.view.backgroundColor = [UIColor grayColor];
	
	tagname = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 20)];
	[tagname setText:@"Skill"];
	[self.view addSubview:tagname];
	
	colorViewContainer = [[UIView alloc] initWithFrame:CGRectMake(skillColorContainerPosx, 0, skillColorBlockWidth,skillBarFrame.size.height)];
	colorViewContainer.backgroundColor = [UIColor grayColor];
	[self.view addSubview:colorViewContainer];
	colorViewContainer.clipsToBounds = YES;
	
	colorBlock = [[UIView alloc] initWithFrame:CGRectMake(0 - skillColorBlockWidth,0, skillColorBlockWidth, skillBarFrame.size.height)];
	colorBlock.backgroundColor = [UIColor redColor];
	[colorViewContainer addSubview:colorBlock];
	
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	[self clearInfo];
}

-(void) updateShow:(int) oldValue				//更新显示
{
	if (oldValue == curSkillValue) 
	{
		return;
	}
	
	float posx = ((curSkillValue / maxBarValue) - 1)  * skillColorBlockWidth;
	
	CGRect pos = colorBlock.frame;
	pos.origin.x = posx;
	
	CGContextRef context = UIGraphicsGetCurrentContext();  
	[UIView beginAnimations:nil context:context];  
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
	[UIView setAnimationDuration:barChangeDuaration];  
	
	[colorBlock setFrame:pos];
	[UIView commitAnimations];  
	
	
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

-(void) clearInfo
{
	curSkillValue = 0;
	skillAttack = 0;
	
	CGRect pos = colorBlock.frame;
	pos.origin.x = 0 - skillColorBlockWidth;
	colorBlock.frame = pos;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
