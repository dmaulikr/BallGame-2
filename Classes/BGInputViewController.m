//
//  BGInputViewController.m
//  沈冬冬
//
//  Created by SDD on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BGInputViewController.h"
#import "BGButton.h"
#import "BGGLButton.h"
#import "BGAnimation.h"
#import "BGSceneController.h"

@implementation BGInputViewController

@synthesize touchEvents;
@synthesize interfaceObjects,forwardMagnitude, rightMagnitude, leftMagnitude,fireMissile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
		touchEvents = [[NSMutableSet alloc] init];
	}
	return self;
}

-(void) loadView
{
}

-(CGRect)screenRectFromMeshRect:(CGRect)rect atPoint:(CGPoint)meshCenter
{
	CGPoint rectOrigin = CGPointZero;
	
	//NSLog(@"the origin center is %f and %f",meshCenter.x,meshCenter.y);
	
	rectOrigin.x = meshCenter.x;
	
	meshCenter.y += (CGRectGetHeight(rect)/2.0);
	meshCenter.y = 768 - meshCenter.y;
	rectOrigin.y = meshCenter.y;
	
	rectOrigin.x = rectOrigin.x - (CGRectGetWidth(rect)/2.0); // height and width 
	//rectOrigin.y = screenCenter.y - (CGRectGetWidth(rect)/2.0); // are flipped
	
	return CGRectMake(rectOrigin.x, rectOrigin.y, CGRectGetWidth(rect), CGRectGetHeight(rect));
}

-(void) loadInterface
{
	if (interfaceObjects == nil) 
		interfaceObjects = [[NSMutableArray alloc] init];
	
	BGGLButton * fireButton = [[BGGLButton alloc] initWithUpKey:@"fireUp" downKey:@"fireDown"];
	fireButton.scale = BGPointMake(100.0, 100.0, 1.0);
	fireButton.translation = BGPointMake(100, 100, 0.0);
	fireButton.target = self;
	fireButton.btnPressedHandler = @selector(fireButtonDown);
	fireButton.btnUpHandler = @selector(fireButtonUp);
	fireButton.active = YES;
	[fireButton awake];
	//[[BBSceneController sharedSceneController] addObjectToScene:fireButton];
	[fireButton release];
	
	BGButton *testBtn  = [[BGButton alloc] init];
	testBtn.scale = BGPointMake(100.0, 100.0, 1.0);
	testBtn.translation = BGPointMake(400, 100, 0.0);
	testBtn.target = self;
	//testBtn.btnPressedHandler = @selector(fireButtonDown);
	//testBtn.btnUpHandler = @selector(fireButtonUp);
	testBtn.active = YES;
	[testBtn awake];
	//[[BBSceneController sharedSceneController] addObjectToScene:testBtn];
	
	BBSceneObject * object = [[BBSceneObject alloc] init];
	object.scale = BGPointMake(100.0, 100.0, 1.0);
	object.translation = BGPointMake(200.0, 300.0, 1.0);
	[object awake];
	//[[BBSceneController sharedSceneController] addObjectToScene:object];
	return;	
	
	BGGLButton * rightButton = [[BGGLButton alloc] initWithUpKey:@"rightUp" downKey:@"rightDown"];
	rightButton.scale = BGPointMake(50.0, 50.0, 1.0);
	rightButton.translation = BGPointMake(-155.0, -130.0, 0.0);
	rightButton.target = self;
	rightButton.btnPressedHandler = @selector(rightButtonDown);
	rightButton.btnUpHandler = @selector(rightButtonUp);
	rightButton.active = YES;
	//[rightButton awake];
	//[interfaceObjects addObject:rightButton];
	[rightButton release];
	
	// left arrow
	BGGLButton * leftButton = [[BGGLButton alloc] initWithUpKey:@"leftUp" downKey:@"leftDown"];
	leftButton.scale = BGPointMake(50.0, 50.0, 1.0);
	leftButton.translation = BGPointMake(-420.0, -130.0, 0.0);
	leftButton.rotation = BGPointMake(0.0, 0.0, 180.0);
	leftButton.target = self;
	leftButton.btnPressedHandler = @selector(leftButtonDown);
	leftButton.btnUpHandler = @selector(leftButtonUp);
	leftButton.active = YES;
	//[leftButton awake];
	//[interfaceObjects addObject:leftButton];
	[leftButton release];
	
	// forward button
	BGGLButton * forwardButton = [[BGGLButton alloc] initWithUpKey:@"thrustUp" downKey:@"thrustDown"];
	forwardButton.scale = BGPointMake(50.0, 50.0, 1.0);
	forwardButton.translation = BGPointMake(185, 75.0, 0.0);
	forwardButton.rotation = BGPointMake(0.0, 0.0, 0.0);
	forwardButton.target = self;
	forwardButton.btnPressedHandler = @selector(forwardButtonDown);
	forwardButton.btnUpHandler = @selector(forwardButtonUp);	
	forwardButton.active = YES;
	[forwardButton awake];
	//[interfaceObjects addObject:forwardButton];
	[forwardButton release];
	 
}

// just a handy way for other object to clear our events
- (void)clearEvents
{
	[touchEvents removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[touchEvents addObjectsFromArray:[touches allObjects]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[touchEvents addObjectsFromArray:[touches allObjects]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[touchEvents addObjectsFromArray:[touches allObjects]];
}

//逐帧执行，刷新
- (void)updateInterface
{
	[interfaceObjects makeObjectsPerformSelector:@selector(update)];
}

//将UI上的所有控件进行渲染
- (void)renderInterface
{
	[interfaceObjects makeObjectsPerformSelector:@selector(render)];
}

-(void)fireButtonDown 
{ 
	self.fireMissile = YES; 
}

-(void)fireButtonUp { 
}

-(void)leftButtonDown 
{	
	self.leftMagnitude = 1.0; 
}

-(void)leftButtonUp 
{ 
	self.leftMagnitude = 0.0;	
}

-(void)rightButtonDown 
{	
	self.rightMagnitude = 1.0;	
}

-(void)rightButtonUp 
{	
	self.rightMagnitude = 0.0;
}

-(void)forwardButtonDown 
{	
	self.forwardMagnitude = 1.0;	
}

-(void)forwardButtonUp 
{	
	self.forwardMagnitude = 0.0;	
}

#pragma mark unload, dealloc

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
