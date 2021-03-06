//
//  GLPowerSide.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobjectContainer.h"
#import "GLCell.h"

@class GLArmy;
@class GLScene;
@class GLBattleStore;
@class GlSkillBar,GLCellArea;

@interface GLPowerSide:GLDisplayobjectContainer 
{
	int sidetype;
	
	GLPowerSide *opponent;
	
	GLCellArea *battleView;
	GLArmy *armyView;
	GLBattleStore *atkPowerStore;
	GLBattleStore *defPowerStore;
	GlSkillBar *skillBar;
	
	GLScene *scene;
}

@property (nonatomic,assign) int sidetype;

@property (nonatomic,retain) GLCellArea *battleView;
@property (nonatomic,retain) GLArmy *armyView;
@property (nonatomic,retain) GLScene *scene;
@property (nonatomic,retain) GLBattleStore *atkPowerStore;
@property (nonatomic,retain) GLBattleStore *defPowerStore;
@property (nonatomic,retain) GlSkillBar *skillBar;

@property (nonatomic,retain) GLPowerSide *opponent;				//对手信息

-(void) handleDisapperCell:(NSMutableDictionary *) cellTypeInfo cellType:(int) type;				//处理单次消失的cell

-(void) initPowerSide;					//初始化powerside

-(void) simuCelleClicked:(int)level;			//AI部分，模拟点击

-(void) bearDamage:(int) value;								//受到攻击

-(void) initGLSideInfo;				//初始化opengl版本的powerside

@end
