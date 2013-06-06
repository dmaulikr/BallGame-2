//
//  BattleCell.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_Cell.h"
#import "Constants.h"
#import "BattleFuncClass.h"
#import "UIDefine.h"

@implementation B_Cell

@synthesize colorType;
@synthesize effecttype;
@synthesize cellParent;
@synthesize column;
@synthesize row;
@synthesize transition;

@synthesize insertwaitTimer;

@synthesize imageView;

-(void)loadView
{
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
	self.imageView = image;
	[image release];
	
	imageView.userInteractionEnabled = NO;
	[self.view addSubview:imageView];
}

-(void) initcell:(CGRect)frame
{
	UIView *tempView = [[UIView alloc] initWithFrame:frame];;
	self.view = tempView;
	[tempView release];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (cellParent) {
		[cellParent colorButtonClicked:self];
	}
}

-(void) setSelfVisible:(Boolean) b_show
{
	self.view.hidden = !b_show;
}

-(void) setCellType:(int)cellType
{
	self.colorType = cellType;
	if (self.colorType == 0) {
		self.view.backgroundColor = [UIColor redColor];
	}
	else if(self.colorType == 1)
	{
		self.view.backgroundColor = [UIColor yellowColor];
	}
	else if (self.colorType == 2) {
		self.view.backgroundColor = [UIColor greenColor];
	}
	else if(self.colorType == 3){
		self.view.backgroundColor = [UIColor orangeColor];
	}
	else {
		self.view.backgroundColor = [UIColor blueColor];	
	}
}

-(void) setcellEffectType:(int)typevalue
{
	self.effecttype = typevalue;
	if (typevalue == attackTypeDefine)
	{
		[imageView setImage:[UIImage imageNamed:@"sword.png"]];  	
	}
	else 
	{
		[imageView setImage:[UIImage imageNamed:@"shield.png"]];  
	}
}

-(void) setDownValue:(int) downValue
{
	if (downValue <= 0) {
		return;
	}
	
	CGRect pos = self.view.frame;
	pos.origin.y += downValue * cellHeight;
	
	self.row += downValue;
	
	CGContextRef context = UIGraphicsGetCurrentContext();  
	[UIView beginAnimations:nil context:context];  
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
	[UIView setAnimationDuration:0.2];  
	
	self.view.frame = pos;
	[UIView commitAnimations];  
}

-(void) setFillPos:(int) upValue
{
	CGRect pos = self.view.frame;
	pos.origin.y = 0 - upValue*cellHeight + verticalGap;
	self.view.frame = pos;
	self.row = upValue - 1;
	[self setSelfVisible:YES];
	
	insertwaitTimer = [NSTimer scheduledTimerWithTimeInterval:cellinsertwaittime target:self selector:@selector(makeMove) 
											   userInfo:nil repeats:NO];
	//[self makeMove];
}

-(void) makeMove
{	
	CGRect pos = self.view.frame;
	CGContextRef context = UIGraphicsGetCurrentContext();  
	[UIView beginAnimations:nil context:context];  
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
	[UIView setAnimationDuration:0.2];  
	//[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(moveFinished:finished:context:)];
	pos.origin.y = (row) * 40 + verticalGap;
	self.view.frame = pos;
	[UIView commitAnimations];  
}

- (void)dealloc {
	colorType = 0;
	[cellParent release];	
	column = 0;
	row = 0;
	[transition release];
	effecttype = 0;
	[imageView release];
    [super dealloc];
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

@end
