//
//  B_PowerInfo.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface B_AtkDefStore : UIViewController 
{
	int type;				//判断是攻击或者是防守类型
	
	int curValue;			//当前的数值
	
	int maxValue;			//记录最多的点数
	
	IBOutlet UILabel* tagShow;
	
	NSMutableArray *imageArr;
	
	NSTimer *attackTimer;		//被攻击的时候，点数减少的等待时间
	
}

@property (nonatomic,assign) int type;
@property (nonatomic,assign) int curValue;

@property (nonatomic,retain) IBOutlet UILabel* tagShow;

@property (nonatomic,retain) NSMutableArray *imageArr;

@property (nonatomic,assign) int maxValue;

@property (nonatomic,assign) NSTimer* attackTimer;

-(void) updateValue:(int) value;			//更新攻击的数值

-(void) increaseValue:(int) value;

-(void) clearInfo;

-(void) showSkillImages;					//显示当前的点数


@end
