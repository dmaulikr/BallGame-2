/*
 *  Constants.h
 *  BallGame
 *
 *  Created by 沈 冬冬 on 11-11-2.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

//游戏的帧数
static const int gameFrameRate = 30;
//游戏中一帧的时间
static const float frameInterval = 1000 / 30;

//颜色的种类
static const int cellColors = 5;
//cell的个数
static const int MaxcellCount = 80;

static const int maxSingleColorCellCount = 35;

//cell的类型
static const int redCell = 0;
static const int blueCell = 1;
static const int yellowCell = 2;
static const int orangeCell = 3;
static const int blackCell = 4;

//定义攻击或者防守类型
static const int attackTypeDefine = 0;				//剑
static const int defenseTypeDefine = 1;				//盾

//定义左右两方势力
static const int userSide = 0;
static const int otherSide = 1;

//cell落下时等待的时间
static const float cellFallWaitTime = 0.3;
//插入cell时的等待时间
static const float cellinsertwaittime = 0.2;
//插入cell以及攻击需要等待的总时间
static const float cellAttackTime = 0.8;
//被攻击时候的效果播放的等待时间
static const float defenseDecreaseTimrt = 0.3;

//士气值的最大个数
static const float maxBarValue = 50.0;
//帧率定义
static const float frmaePerSec = 24.0;