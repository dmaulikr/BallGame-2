    //
//  Main.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Main.h"
#import "Constants.h"
#import "SceneDefines.h"
#import "Global.h"
#import "GameViewController.h"
#import "UIDefine.h"

@implementation Main
@synthesize backGround;
@synthesize btn,UIKitBtn;

- (void)loadView 
{
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gameWidth, gameHeight)];
	
	backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, gameWidth, gameHeight)];
	[backGround setImage:[UIImage imageNamed:@"gameback.jpg"]];
	
	btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
	btn.center = self.view.center;
	[btn setTitle:@"Play" forState:UIControlStateNormal];
	[btn setBackgroundColor:[UIColor redColor]];
	[btn addTarget:self action:@selector(startButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	
	UIKitBtn = [[UIButton alloc] initWithFrame:CGRectMake(400, 600, 200, 100)];
	[UIKitBtn setTitle:@"Play UIKit Version" forState:UIControlStateNormal];
	[UIKitBtn setBackgroundColor:[UIColor redColor]];
	[UIKitBtn addTarget:self action:@selector(startButtonClickedUIVersion) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:backGround];
	[self.view addSubview:btn];
	[self.view addSubview:UIKitBtn];
	
}

-(void) startButtonClicked
{
	self.view.hidden = YES;
	[[Global g_gameController] showParticularScene:battleScene];			//显示突破
}

-(void) startButtonClickedUIVersion
{
	self.view.hidden = YES;
	[[Global g_gameController] showParticularScene:equipScene];			//显示突破
}

- (void)viewDidLoad
{
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[backGround release];
	[btn release];
    [super dealloc];
}


@end
