//
//  GlSkillBar.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobjectContainer.h"
#import "GLDisplayobject.h"

@interface GlSkillBar : GLDisplayobjectContainer {
	IBOutlet UILabel * tagName;				//tag 显示名字
	GLDisplayobjectContainer *colorViewContainer;				//包含显示的颜色色块
	GLDisplayobject *colorBlock;						//颜色块
	
	int curSkillValue;				//当前的能两条
	int skillAttack;				//已经存在的技能攻击的数量
}

@property (nonatomic,assign) int curSkillValue;
@property (nonatomic,retain) UILabel *tagname;
@property (nonatomic,retain) GLDisplayobjectContainer *colorViewContainer;
@property (nonatomic,retain) GLDisplayobject *colorBlock;
@property (nonatomic,assign) int skillAttack;

-(void) initComponents;	

-(void) updateSkillValue:(int)value isAdd:(Boolean)add;
-(void) updateShow:(int) oldValue;

-(void) clearInfo;

@end
