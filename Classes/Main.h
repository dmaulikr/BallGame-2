//
//  Main.h
//  BallGame
//	主界面
//  Created by 沈 冬冬 on 11-12-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class B_Scene;

@interface Main : UIViewController 
{
	UIImageView * backGround;
	
	UIButton *btn;
	UIButton *UIKitBtn;
}

@property (nonatomic,retain) UIImageView * backGround;
@property (nonatomic,retain) UIButton * btn;
@property (nonatomic,retain) UIButton * UIKitBtn;

-(void) startButtonClicked;

@end
