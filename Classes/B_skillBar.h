//
//  B_skillBar.h
//  BallGame
//	能量条
//  Created by 沈 冬冬 on 11-12-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface B_skillBar : UIViewController 
{
	IBOutlet UILabel * tagName;				//tag 显示名字
	UIView *colorViewContainer;				//包含显示的颜色色块
	UIView *colorBlock;						//颜色块
	
	int curSkillValue;				//当前的能两条
	int skillAttack;				//已经存在的技能攻击的数量
}

@property (nonatomic,assign) int curSkillValue;
@property (nonatomic,retain) UILabel *tagname;
@property (nonatomic,retain) UIView *colorViewContainer;
@property (nonatomic,retain) UIView *colorBlock;
@property (nonatomic,assign) int skillAttack;

-(void) updateSkillValue:(int)value isAdd:(Boolean)add;
-(void) updateShow:(int) oldValue;

-(void) clearInfo;

@end
