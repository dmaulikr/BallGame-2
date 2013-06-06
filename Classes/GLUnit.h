//
//  GLUnit.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobjectContainer.h"
#import "GLArmy.H"

@interface GLUnit : GLDisplayobjectContainer {
	
	int curArmCount;			//当前的士兵数量
	
	int role;
	int type;
	int specialEffect;
	
	IBOutlet UILabel *armCountShow;
	
	GLArmy* armyInfo;
}

@property (nonatomic,assign) int role;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int specialEffect;
@property (nonatomic,assign) int curArmCount;

@property (nonatomic,assign) IBOutlet UILabel *armCountShow;
@property (nonatomic,retain) GLArmy *armyInfo;

-(id) initWithIndex:(int) index army:(GLArmy *)army;

-(void) setUnitRole:(int) role;
-(void) setUnitType:(int) type;

-(void) showAttackMove:(int)value;
-(void) showdefenseMove:(int)value;

-(void) clearInfo;

@end
