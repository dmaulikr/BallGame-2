//
//  BattleFuncClass.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
  
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "B_Cell.h"
#import "BGButton.h"
#import "BGImage.h"

@class BGGLButton;

@interface BattleFuncClass : NSObject 
{

}

+(B_Cell *) createCellButtonForView:(CGRect)position withTag:(int)tag type:(int)type;

+(void)setInteraction:(BOOL)allow onView:(UIView *)aView includeSelf:(Boolean) selfIncluded;

+(id)createGLCell:(CGRect)position withTag:(int)tag type:(int)type side:(int)side;

+(UIImageView *)getSkillImageByType:(int) type index:(int) index;

+(BGImage *) getGlImageByType:(int)type index:(int)index;

@end
