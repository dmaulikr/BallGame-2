//
//  GLDisplayobjectContainer.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLDisplayobject.h"

@interface GLDisplayobjectContainer : GLDisplayobject 
{
	NSMutableArray *childArray;					//保存此控件中的子控件
	
	BGPoint scaleCliped;						//被clip掉的
	
	BOOL mouseChildren;
	BOOL clipContent;			//是否裁剪超过自己区域的子控件
}

@property (retain) NSMutableArray *childArray;
@property (assign) BOOL mouseChildren;
@property (assign) BOOL clipContent;

-(void) startMove;
-(void) dealloc;
-(void) addChild:(GLDisplayobject *)child;
-(void) removeChild:(GLDisplayobject *)child;

@end
