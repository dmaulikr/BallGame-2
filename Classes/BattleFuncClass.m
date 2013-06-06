//
//  BattleFuncClass.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BattleFuncClass.h"
#import "B_Cell.h"
#import "Constants.h"
#import "UIDefine.h"
#import "BGGLButton.h"
#import "PostionFunc.h"
#import "BGSceneController.h"
#import "SceneDefines.h"
#import "GLCell.h"
#import "BGImage.h"

@implementation BattleFuncClass

+(B_Cell *)createCellButtonForView:(CGRect)position withTag:(int)tag type:(int)type 
{
	B_Cell *cell = [B_Cell alloc];
	
	int randomNum = arc4random() % 2;
	
	[cell initcell:position];
	[cell loadView];
	
	[cell setCellType:type];
	[cell setcellEffectType:randomNum];
	
    return cell;
}

+(id)createGLCell:(CGRect)position withTag:(int)tag type:(int)type side:(int)side	//生成opengl下的cell
{
	int randomNum = arc4random() % 2;		//攻击武器或者盾牌

	CGPoint realPoint = CGPointMake(position.origin.x, position.origin.y);
	
	GLCell *cell = [[GLCell alloc] initcell:realPoint colorType:type cellType:randomNum];
	return cell;
}

+(void)setInteraction:(BOOL)allow onView:(UIView *)aView includeSelf:(Boolean) selfIncluded
{
	if (selfIncluded) {
		[aView setUserInteractionEnabled:allow];
	}
	for (UIView * v in [aView subviews]) {
		v.userInteractionEnabled = allow;
        //[BattleFuncClass setInteraction:allow onView:v includeSelf:YES];
    }
}

+(UIImageView *)getSkillImageByType:(int) type index:(int) index
{
	int posx = ((index - 1) % maxCountPerLine) * (skillImageWidth + skillImageGap) + startPos;
	int tempValue = (index - 1) / maxCountPerLine;
	int posy = tempValue * skillImageHeigt + startPoxY;
	
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(posx, posy, skillImageWidth, skillImageHeigt)];
	
	if (type == attackTypeDefine)
	{
		[image setImage:[UIImage imageNamed:@"sword.png"]];  
	}
	else 
	{
		[image setImage:[UIImage imageNamed:@"shield.png"]];  
	}
	return image;
}

+(BGImage *) getGlImageByType:(int)type index:(int)index
{
	int posx = ((index - 1) % maxCountPerLine) * (skillImageWidth + skillImageGap) + startPos;
	int tempValue = (index - 1) / maxCountPerLine;
	int posy = tempValue * skillImageHeigt + startPoxY;
	
	BGImage *image;
	
	if (type == attackTypeDefine)
	{
		image = [[BGImage alloc] initWithMaterialName:@"002_1"];
	}
	else 
	{
		image = [[BGImage alloc] initWithMaterialName:@"002_2"];
	}
	image.pos = BGPointMake(posx, posy, 0);
	image.scale = BGPointMake(skillImageWidth, skillImageHeigt, 1);
	
	return image;
}

@end
