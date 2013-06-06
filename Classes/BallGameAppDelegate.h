//
//  BallGameAppDelegate.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameViewController;
@class BGSceneController;

@interface BallGameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	GameViewController *gameViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameViewController *gameViewController;

@end

