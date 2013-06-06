//
//  BattleCell.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "B_CellVIew.h"
#import <QuartzCore/QuartzCore.h>

@interface B_Cell : UIViewController {
	int effecttype;
	int colorType;
	id cellParent;
	int column;
	int row;
	CATransition *transition; 
	
	NSTimer *insertwaitTimer;	//插入需要等待的时间
	
	IBOutlet UIImageView *imageView;
	
}

@property (nonatomic,assign) int colorType;
@property (nonatomic,assign) int effecttype;
@property (nonatomic,retain) id cellParent;
@property (nonatomic,assign) int column;
@property (nonatomic,assign) int row;
@property (nonatomic,retain) CATransition *transition;

@property (nonatomic,retain) NSTimer *insertwaitTimer;	//插入需要等待的时间

@property (nonatomic,retain) IBOutlet UIImageView *imageView;

-(void) initcell:(CGRect)frame;
-(void) dealloc;
-(void) setSelfVisible:(Boolean) b_show;

-(void) setDownValue:(int) downValue;						//需要向下位移的距离
-(void) setFillPos:(int) upValue;			//补进来的时候高度
-(void) setCellType:(int)cellType;
-(void) setcellEffectType:(int)effectType;

-(void) makeMove;
//-(void)moveFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;

@end
