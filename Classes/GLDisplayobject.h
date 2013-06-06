//
//  GLDisplayobject.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGButton.h"
#import "ASFunction.h"

@class GLDisplayobjectContainer;

@interface GLDisplayobject:BGButton 
{
	BGPoint pos;						//用于设置的位置
	BGPoint realPos;					//真正的位置
	
	BGPoint clipedPos;					//裁剪过程中pos的变化
	BGPoint clipedScale;				//裁剪过程中scale的变化
	
	int displayBackGroundColor;			//设置背景颜色
	
	BOOL isMoving;			//是否在运动
	BOOL isPaused;			//是否被暂停
	
	BGPoint destion;
	
	GLfloat duration;		//持续时间，毫秒为单位
	
	BGPoint speed;
	BGPoint rotationalSpeed;
	
	int curUpdatedCount;					//当前已经刷新的次数
	int needUpdateCount;					//记录需要update的次数，准确判断运动需要刷新的次数
	
	ASFunction *tweenEndCallback;			//特效完成后的回调函数
	
	GLDisplayobjectContainer *parent;					//parent
	
}

@property (assign) BGPoint destion;
@property (assign) GLfloat duration;
@property (assign) BGPoint speed;
@property (assign) BGPoint rotationalSpeed;
@property (assign) BOOL isMoving;
@property (assign) BOOL isPaused;
@property (retain) ASFunction *tweenEndCallback;

@property (nonatomic,assign) BGPoint realPos;
@property (assign) GLDisplayobjectContainer *parent;

@property (assign) BGPoint clipedPos;
@property (assign) BGPoint clipedScale;

-(void) checkMoveFinished;
-(void) update;
-(void) render;
-(void) stopMove;
-(void) jumpToEnd:(BOOL) needCallFunc;
-(void) startMove;
-(void) pauseMove;
-(void) resumeMove;
-(void) MoveEndHandler;

-(void) adjustPos;		//调整位置，当pos，或者parent发生变化时
-(void) clipSelf;		//对自己进行裁剪

-(BGPoint) pos;
-(void) setPos:(BGPoint) position;

-(void) setParent:(GLDisplayobjectContainer *)parentCon;

-(void) setDisplayBackGroundColor:(int)color;

-(void) dealloc;

@end
