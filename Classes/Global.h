//
//  Global.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-12-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameViewController;

@interface Global : NSObject 
{
	
}

+(GameViewController *) g_gameController;
+(void) setGloabalController:(GameViewController *)contorller;

@end
