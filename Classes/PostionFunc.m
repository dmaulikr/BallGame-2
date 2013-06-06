//
//  PostionFunc.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-10.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PostionFunc.h"
#import "SceneDefines.h"
#import "Constants.h"
#import "UIDefine.h"

@implementation PostionFunc

+(CGPoint) turnLoacalPosToScenePos:(CGPoint) pos sceneIndex:(int)scene side:(int)cellSide
{
	CGPoint realPos = CGPointMake(pos.x, pos.y);		
	int curScene = scene;
	
	//以下是cell的位置变化
	if (curScene == On_CellViewPos)						//将把battleview的坐标转为在powerside中的坐标
	{
		realPos.x += battleViewFrame.origin.x;
		realPos.y += battleViewFrame.origin.y;
		curScene = On_PowerSidePos;
	}
	
	//unit的位置变化 将再rmy中的位置转为再powerside中
	if (curScene == On_ArmyPos) 
	{
		realPos.x += armyInfoFrame.origin.x;
		realPos.y += armyInfoFrame.origin.y;
		curScene = On_PowerSidePos;
	}
	
	//将powerside的左边转为scene中的坐标
	if (curScene == On_PowerSidePos)					
	{
		if (cellSide == userSide)				//在攻击方阵营
		{				
			realPos.x += attackPoserSideFrame.origin.x;
			realPos.y += attackPoserSideFrame.origin.y;
		}
		else 
		{									//敌方阵营
			realPos.x += defensePoserSideFrame.origin.x;
			realPos.y += defensePoserSideFrame.origin.y;
		}
		curScene = On_BattleScenPos;
	}
	
	if (curScene == On_BattleScenPos) 
	{
		realPos.x = realPos.x;
		realPos.y = gameHeight - realPos.y;
		curScene = openGlScenePos;
	}
	
	return realPos;
	
}

+(BGPoint) turnPositonToScenePositon:(GLDisplayobject *) displayObject
{
	BGPoint retValue = BGPointMake(0, 0, 0);
	retValue.x = displayObject.realPos.x;
	retValue.x += displayObject.scale.x/2;
	retValue.y = gameHeight - displayObject.realPos.y - displayObject.scale.y / 2;
	return retValue;
}

@end
