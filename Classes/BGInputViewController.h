//
//  BGInputViewController.h
//  用于处理游戏中ui的控制器
//
//  Created by SDD on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGInputViewController : UIViewController {
	NSMutableSet* touchEvents;
	NSMutableArray *interfaceObjects;
	
	CGFloat forwardMagnitude;
	CGFloat rightMagnitude;
	CGFloat leftMagnitude;
	BOOL fireMissile;
}

@property (nonatomic,retain) NSMutableSet* touchEvents;
@property (nonatomic,retain) NSMutableArray *interfaceObjects;
@property (assign) CGFloat forwardMagnitude;
@property (assign) BOOL fireMissile;
@property (assign) CGFloat rightMagnitude;
@property (assign) CGFloat leftMagnitude;

- (void)clearEvents;
- (void)dealloc;
- (void)didReceiveMemoryWarning;
- (void)loadView;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)viewDidUnload;

-(void) loadInterface;
- (void)updateInterface;
- (void)renderInterface;

-(CGRect)screenRectFromMeshRect:(CGRect)rect atPoint:(CGPoint)meshCenter;

@end
