//
//  GLCell.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLCell.h"
#import "UIDefine.h"
#import "BGSceneController.h"
#import "Constants.h"
#import "BGGLButton.h"
#import "ColorDefine.h"
#import "BGImage.h"
#import "Values.h"
#import "GLCellArea.h"

@implementation GLCell

@synthesize effecttype, cellParent, column, row, transition, insertwaitTimer, imageView;
//@synthesize colorType;

-(id) initcell:(CGPoint)posValue colorType:(int)cellColorType cellType:(int)cellType
{
	self = [super init];
	if (self) 
	{
		self.scale = BGPointMake(cellWidth, cellHeight, 1.0);
		self.pos = BGPointMake(posValue.x,posValue.y, 0.0);
		self.rotation = BGPointMake(0.0, 0.0, 0.0);
		self.target = self;
		self.btnPressedHandler = @selector(touchDownHandler);
		self.btnUpHandler = @selector(touchUpHandler);	
		self.active = YES;
		self.colorType = cellColorType;
		
		[self setcellEffectType:cellType];
	}
	
	return self;
}

-(void) initImages
{
	imageView = [[BGImage alloc] initWithMaterialName:@"002_1"];
	imageView.pos = BGPointMake(0, 0, 0);
	imageView.rotation = BGPointMake(0.0, 0.0, 0.0);
	imageView.scale = BGPointMake(cellWidth, cellHeight, 1.0);
	imageView.mouseEnable = NO;
	[self addChild:(GLDisplayobject*)imageView];				//先不增加  用于区分颜色
}

-(int) colorType
{
	return colorType;
}

-(void) setColorType:(int) value
{
	colorType = value;
	if (self.colorType == redCell) 
	{
		self.displayBackGroundColor = redColor;
	}
	else if(self.colorType == blueCell)
	{
		self.displayBackGroundColor = blueColor;
	}
	else if (self.colorType == yellowCell) 
	{
		self.displayBackGroundColor = yellowColor;
	}
	else if(self.colorType == orangeCell)
	{
		self.displayBackGroundColor = orangeColor;
	}
	else 
	{
		self.displayBackGroundColor = greenColor;
	}
}

-(void) update
{
	[super update];
}

-(void) touchDownHandler
{
	
}

-(void) touchUpHandler			//处理鼠标消息
{
	if (cellParent) 
	{
		[cellParent colorButtonClicked:self];
	}
}

-(void) setSelfVisible:(Boolean) b_show
{
	self.visible = b_show;
}

-(void) setcellEffectType:(int)typevalue
{
	self.effecttype = typevalue;
	if (typevalue == attackTypeDefine)
	{
		[imageView changeMaterialName:@"002_1"];
	}
	else 
	{
		[imageView changeMaterialName:@"002_2"];
	}
}

//让cell下降几个格子
-(void) setDownValue:(int) downValue
{
	if (downValue <= 0) {
		return;
	}
	
	self.destion = BGPointMake(self.pos.x, self.pos.y + downValue * cellHeight, self.pos.z);
	self.duration = movingDownDuration;
	
	self.row += downValue;
	[self startMove];
}

//设置补充的格子信息
-(void) setFillPos:(int) upValue
{
	GLfloat newY = 0 - upValue*cellHeight + verticalGap;
	self.pos = BGPointMake(self.pos.x, newY, self.pos.z);
	self.row = upValue - 1;
	self.visible = YES;
	
	insertwaitTimer = [NSTimer scheduledTimerWithTimeInterval:cellinsertwaittime target:self selector:@selector(makeMove) 
													 userInfo:nil repeats:NO];
}

-(void) makeMove
{	
	BGPoint curDest = BGPointMake(self.pos.x, (row) * cellHeight + verticalGap, self.pos.z);
	self.destion = curDest;
	self.duration = movingDownDuration;
	[self startMove];
}

-(void) dealloc
{
	[insertwaitTimer invalidate];
	[imageView release];
	[super dealloc];
}

@end
