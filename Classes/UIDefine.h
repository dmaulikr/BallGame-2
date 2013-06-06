//
//  UIDefine.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//攻击 盾牌 skill点数的配置

static const int gameWidth = 1024;
static const int gameHeight = 768;

//战场区域大小
static const int battleColumns = 10;
static const int  battleRows = 8;

static const int startPos = 70;
static const int startPoxY = 5;

//cell的高度宽度
static const int cellWidth = 40;
static const int cellHeight = 40;

static const int cellOriginY = 80;

//y轴方向的gap值
static const int verticalGap = 0;

//以下是unit的宏定义
static const int unitCount = 5;
static const int unitWidth = 60;
static const int unitHeight = 60;

static const int skillImageWidth = 20;
static const int skillImageHeigt = 20;
static const int skillImageGap = 10;

static const int maxCountPerLine = 10;

//关于skillbar的一些定义
static const int skillColorContainerPosx = 50;
static const int skillColorBlockWidth = 340;
static const float barChangeDuaration = 0.5;

static const int glUnitGap = 80;

//battleView的位置
static const CGRect battleViewFrame = {origin:{0.0f, 280.0f}, size:{400.0f, 320.0f}};

//攻击方powerside的frame
static const CGRect attackPoserSideFrame = {origin:{0.0f, 100.0f}, size:{400.0f, 718.0f}};
//防守方powerside的frame
static const CGRect defensePoserSideFrame = {origin:{500.0f, 100.0f}, size:{400.0f, 718.0f}};

//攻击，防守 力量条
static const CGRect powerInfoFrameUserSide = {origin:{00.0f, 55.0f}, size:{400, 45}};
static const CGRect powerInfoFrameDefeSide = {origin:{00.0f, 95.0f}, size:{400, 45}};

//skillbar的frame  士气条
static const CGRect skillBarFrame = {origin:{0.0f, 15.0f}, size:{400, 30}};

//英雄势力的位置
static const CGRect armyInfoFrame = {origin:{0.0f, 170.0f}, size:{400, 60}};
