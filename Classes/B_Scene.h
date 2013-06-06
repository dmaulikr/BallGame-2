//
//  B_BattleScene.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class B_PowerSide;

@interface B_Scene : UIViewController {

	B_PowerSide *leftSide;
	B_PowerSide *rightSide;
	
}

@property (nonatomic,retain) B_PowerSide *leftSide;
@property (nonatomic,retain) B_PowerSide *rightSide;

-(void) simuAttack;				//模拟电脑作出回击

-(void) makeAttack:(int) atkType powerside:(B_PowerSide *)power;				//进行攻击

@end
