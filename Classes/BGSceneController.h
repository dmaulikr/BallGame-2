//
//  BBSceneController.h
//  BBOpenGLGameTemplate
//
//  Created by SDD on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BGInputViewController;
@class EAGLView;
@class BBSceneObject;

@interface BGSceneController : NSObject {
	NSMutableArray * sceneObjects;
	NSMutableArray * objectsToRemove;
	NSMutableArray * objectsToAdd;
	
	BGInputViewController * inputController;
	EAGLView * openGLView;
	
	NSTimer *animationTimer;
	NSTimeInterval animationInterval;
	
	NSTimeInterval deltaTime;
	
	NSTimeInterval lastFrameStartTime;
	NSTimeInterval thisFrameStartTime;
	
	NSDate * levelStartDate;			//游戏开始时间
}

@property (retain) BGInputViewController * inputController;
@property (retain) EAGLView * openGLView;
@property NSTimeInterval deltaTime;
@property (retain) NSDate *levelStartDate;

@property NSTimeInterval animationInterval;
@property (nonatomic, assign) NSTimer *animationTimer;

+ (BGSceneController*)sharedSceneController;
- (void) dealloc;
- (void) loadScene;
- (void) startScene;
- (void)gameLoop;
- (void)renderScene;
- (void)setAnimationInterval:(NSTimeInterval)interval ;
- (void)setAnimationTimer:(NSTimer *)newTimer ;
- (void)startAnimation;
- (void)stopAnimation;
- (void)updateModel;
- (void)removeObjectFromScene:(BBSceneObject*)sceneObject;
- (void)addObjectToScene:(BBSceneObject*)sceneObject;

@end
