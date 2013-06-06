//
//  GLArmy.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobjectContainer.h"
#import "GLPowerSide.h"

@interface GLArmy:GLDisplayobjectContainer 
{
	NSMutableDictionary *unitsObj;
	NSArray *unitIndex;
	GLPowerSide* powerSide;
}

@property (nonatomic,retain) NSMutableDictionary *unitsObj;
@property (nonatomic,retain) NSArray *unitIndex;
@property (nonatomic,retain) GLPowerSide* powerSide;

-(void) makeUnitAttack:(int)type damavalue:(int) value;

-(Boolean) assignDamage:(int) value;

-(id) initWithPower:(GLPowerSide*) power;

@end
