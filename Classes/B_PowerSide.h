//
//  BattlePowerSide.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class B_CellVIew;
@class B_army;
@class B_Scene;
@class B_AtkDefStore;
@class B_Cell;
@class B_skillBar;

@interface B_PowerSide : UIViewController {
	
	int sidetype;
	
	B_PowerSide *opponent;
	
	B_CellVIew *battleView;
	B_army *armyView;
	B_AtkDefStore *atkPowerInfo;
	B_AtkDefStore *defPowerInfo;
	B_skillBar *skillBar;
	
	B_Scene *scene;
}

@property (nonatomic,assign) int sidetype;

@property (nonatomic,retain) B_CellVIew *battleView;
@property (nonatomic,retain) B_army *armyView;
@property (nonatomic,retain) B_Scene *scene;
@property (nonatomic,retain) B_AtkDefStore *atkPowerInfo;
@property (nonatomic,retain) B_AtkDefStore *defPowerInfo;
@property (nonatomic,retain) B_skillBar *skillBar;

@property (nonatomic,retain) B_PowerSide *opponent;				//对手信息

-(void) handleDisapperCell:(NSMutableDictionary *) cellTypeInfo cellType:(int) type;				//处理单次消失的cell

-(void) initPowerSide;					//初始化powerside

-(void) simuCelleClicked:(int)level;			//AI部分，模拟点击

-(void) bearDamage:(int) value;								//受到攻击

-(void) initGLSideInfo;				//初始化opengl版本的powerside

@end
