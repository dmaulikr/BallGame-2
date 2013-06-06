//
//  B_Unit.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface B_Unit : UIViewController {
	
	int curArmCount;			//当前的士兵数量
	
	int role;
	int type;
	int specialEffect;
	
	IBOutlet UILabel *armCountShow;
	
}

@property (nonatomic,assign) int role;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int specialEffect;
@property (nonatomic,assign) int curArmCount;

@property (nonatomic,assign) IBOutlet UILabel *armCountShow;

-(void) setUnitIndex:(int) index;
-(void) setUnitRole:(int) role;
-(void) setUnitType:(int) type;

-(void) showAttackMove:(int)value;
-(void) showdefenseMove:(int)value;

-(void) clearInfo;

@end
