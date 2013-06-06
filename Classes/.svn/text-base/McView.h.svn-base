//
//  MovieClip.h
//  BallGame
//	用于取代movieclip的类
//	只实现播放功能，不包括逻辑代码
//
//  Created by 沈 冬冬 on 11-12-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sprite;

@interface McView : UIView 
{
	Sprite *contentSprite;					//实际的动画
	NSTimer *timer;
	int curFrame;							//播放的第几帧
	int totalFrames;						//总体帧数
	
	int nextStopFrame;
	int needLoops;
}

@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,assign) int curFrame;
@property (nonatomic,retain) Sprite *contentSprite;
@property (nonatomic,assign) int totalFrames;

-(void) setFileName:(NSString *)name;			//设置图片路径，进行初始化
-(void) enterFrame;
-(void) play;									//开始播放
-(void) stop;									//停止播放
-(void) gotoAndStop:(int) frame;				//跳转到某一帧停止
-(void) gotoAndPlay:(int) frame;				//跳转刀某一帧播放
-(void) playInterval:(int)startValue endIndex:(int)endValue loops:(int)loops;		//播放某个区间,指定循环次数

@end
