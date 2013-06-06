//
//  GLDisplayobject.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLDisplayobject.h"
#import "BGSceneController.h"
#import "Constants.h"
#import "GLDisplayobject.h"
#import "ColorDefine.h"
#import "PostionFunc.h"
#import "GLDisplayobjectContainer.h"

@implementation GLDisplayobject

//@synthesize x,y,z,parent;
@synthesize realPos,parent;
@synthesize destion,speed,rotationalSpeed,isPaused,isMoving,duration,tweenEndCallback;
@synthesize clipedPos,clipedScale;

-(id) init
{
	self = [super init];
	if (self) {
		mouseEnable = NO;
		self.displayBackGroundColor = blackColor;
	}
	return self;
}

-(void) setPos:(BGPoint) posValue
{
	pos = posValue;
	[self adjustPos];
}

-(BGPoint) pos
{
	return pos;
}

-(void) setParent:(GLDisplayobjectContainer*)parentCon
{
	parent = parentCon;
	[self adjustPos];
}

-(void) adjustPos			//调整坐标
{
	if (parent) {
		self.realPos = BGPointMake(parent.realPos.x + pos.x, parent.realPos.y + pos.y, parent.realPos.z + pos.z);
	}
	else {
		self.realPos = BGPointMake(pos.x, pos.y, pos.z);
	}
	[self awake];
}

-(void) setDisplayBackGroundColor:(int) color
{
	displayBackGroundColor = color;
	if (color == redColor) 
	{
		normalColor = GLColorsRed;
		pressedColor = GLColorsRedPressed;
	}
	else if (color == greenColor) 
	{
		normalColor = GLColorsGreen;
		pressedColor = GLColorsGreenPressed;
	}
	else if (color == blueColor) 
	{
		normalColor = GLColorsBlue;
		pressedColor = GLColorsBluePressed;
	}
	else if (color == yellowColor) 
	{
		normalColor = GLColorsYellow;
		pressedColor = GLColorsYellowPressed;
	}
	else if (color == orangeColor) 
	{
		normalColor = GLColorsOrange;
		pressedColor = GLColorsOrangePressed;
	}
	else if (color == whiteColor) 
	{
		normalColor = GLColorWhite;
		pressedColor = GLColorWhitePressed;
	}
	else {
		normalColor = GLColorBlack;
		pressedColor = GLColorBlackPressed;
	}
}

-(void)update
{
	if (isMoving) 
	{
		if(!isPaused)
		{
			CGFloat deltaTime = [[BGSceneController sharedSceneController] deltaTime] * 1000;
			
			self.pos = BGPointMake(speed.x*deltaTime + pos.x, speed.y*deltaTime+ pos.y, speed.z * deltaTime+pos.z);
			
			translation = [PostionFunc turnPositonToScenePositon:self];	
			
			rotation.x += rotationalSpeed.x * deltaTime;
			rotation.y += rotationalSpeed.y * deltaTime;
			rotation.z += rotationalSpeed.z * deltaTime;
			
			[self checkMoveFinished];			
		}
	}
	[super update];
}

-(void) render
{
	if (visible)			//只有visibel为true的时刷新
	{
		BGPoint tempPos = BGPointMake(self.pos.x, self.pos.y, self.pos.z);
		BGPoint tempScale = BGPointMake(self.scale.x, self.scale.y, self.scale.z);
		if (!isPointEmpty(parent.clipedPos) || !isPointEmpty(parent.clipedScale)) 
		{
			if(self.pos.y < parent.clipedPos.y)				//y方向上被裁剪
			{
				self.pos = BGPointMake(self.pos.x, 0, self.pos.z);
				self.scale = BGPointMake(self.scale.x, self.scale.y - (parent.clipedPos.y - self.pos.y), self.scale.z);
				self.scale = BGPointFilter(self.scale.x,self.scale.y,self.scale.z);
			}
			if (self.pos.x < parent.clipedPos.x)				//x方向上被裁剪
			{
				self.pos = BGPointMake(0, self.pos.y, self.pos.z);
				self.scale = BGPointMake(self.scale.x - (parent.clipedPos.y - self.pos.x), self.scale.y, scale.z);
				self.scale = BGPointFilter(self.scale.x,self.scale.y,self.scale.z);
			}
			if (self.pos.y >= parent.clipedPos.y)				//y方向没有裁剪，但是坐标改变
			{
				self.pos = BGPointMake(self.pos.x, self.pos.y - parent.clipedPos.y, self.pos.z);
			}
			if (self.pos.x >= parent.clipedPos.x)				//
			{
				self.pos = BGPointMake(self.pos.x - parent.clipedPos.x, self.pos.y, self.pos.z);
			}
			
		}
		else if (parent && parent.clipContent)				//处理裁剪的情形
		{
			//render的时候需要检查是否要进行裁剪
			
			if (tempPos.x < 0) 
			{
				self.scale = BGPointFilter(tempPos.x + tempScale.x,tempScale.y,tempScale.z);
				self.pos = BGPointMake(0,tempPos.y,tempPos.z);
			}
			if (tempPos.y < 0) {
				self.scale = BGPointFilter(tempScale.x, tempPos.y + tempScale.y,tempScale.z);
				self.pos = BGPointMake(tempPos.x,0,tempPos.z);
			}			
						
		}
		
		//调整过位置之后，判断大小是否越界
		if (self.scale.x > parent.scale.x)  
		{
			self.scale = BGPointFilter(parent.scale.x - self.pos.x, self.scale.y,self.scale.z);
		}
		if (self.scale.y > parent.scale.y)
		{
			self.scale = BGPointFilter(self.scale.x, parent.scale.y - self.pos.y,self.scale.z);
		}
		
		//记录此次裁剪发生的变化值
		self.clipedPos = BGPointSubtract(self.pos,tempPos);
		self.clipedScale = BGPointSubtract(self.scale, tempScale);
		
		[super render];
		
		pos = tempPos;
		self.scale = tempScale;
	}

}

-(void) awake
{
	translation = [PostionFunc turnPositonToScenePositon:self];	
	[super awake];
	[super setNotPressedVertexes];
}

-(void) clipSelf
{
	NSLog(@"自己裁剪");
}

-(void) checkMoveFinished			//查看是否已经move结束
{
	curUpdatedCount++;
	if (curUpdatedCount >= needUpdateCount) 
	{
		[self stopMove];
	}
}

-(void) stopMove
{
	isMoving = NO;
	isPaused = NO;
	curUpdatedCount = 0;
	needUpdateCount = 0;
	[tweenEndCallback release];
	self.pos = self.destion;
	return;
}

-(void) jumpToEnd:(BOOL)needCallFunc			//跳转到运行结束
{
	translation.x = destion.x;
	translation.y = destion.y;
	translation.z = destion.z;
	if (needCallFunc) {
		[self MoveEndHandler];
	}
	[self stopMove];
}

-(void) startMove				//开始移动，计算速度
{
	if (duration <= 0) 
	{
		return;
	}
	
	GLfloat speedx = (destion.x - self.pos.x) / duration;
	GLfloat speedy = (destion.y - self.pos.y) / duration;
	GLfloat speedz = (destion.z - self.pos.z) / duration;
	
	speed = BGPointMake(speedx, speedy, speedz);
	
	isMoving = YES;
	isPaused = NO;
	
	curUpdatedCount = 0;
	needUpdateCount = duration / frameInterval;				//初始化需要update的次数
	
}

-(void) pauseMove
{
	isPaused = YES;
}

-(void) resumeMove
{
	isPaused = NO;
}

-(void) MoveEndHandler
{
	if(tweenEndCallback)
		NSLog(@"Move End");
}

-(void) dealloc
{
	[super dealloc];
}

@end
