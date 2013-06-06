//
//  gameViewController.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class B_CellVIew;
@class B_Scene;
@class Main;
@class GameViewController;
@class BGSceneController;
@class GLScene;

@interface GameViewController : UIViewController
{
	Main *mainUI;				//主界面
	
	BGSceneController * sceneController;
	GameViewController *gameViewController;
	
	B_Scene *scene;				//战场
	
	GLScene *scene2;			//战场，使用opengl实现
}

@property (nonatomic,retain) B_Scene *scene;
@property (nonatomic,retain) Main *mainUI;
@property (nonatomic,retain) BGSceneController * sceneController;
@property (nonatomic, retain) IBOutlet GameViewController *gameViewController;

@property (nonatomic,retain) GLScene *scene2;

-(void)showParticularScene:(int) sceneIndex;

@end
