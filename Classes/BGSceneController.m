//
//  BBSceneController.m
//  BBOpenGLGameTemplate
//
//  Created by SDD on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BGSceneController.h"
#import "BGInputViewController.h"
#import "EAGLView.h"
#import "BBSceneObject.h"
#import "Constants.h"

@implementation BGSceneController

@synthesize inputController, openGLView;
@synthesize animationInterval, animationTimer,deltaTime,levelStartDate;

//单键模式
+(BGSceneController*)sharedSceneController
{
  static BGSceneController *sharedSceneController;
  @synchronized(self)
  {
    if (!sharedSceneController)
	{
      sharedSceneController = [[BGSceneController alloc] init];
	  sharedSceneController.levelStartDate = [[NSDate alloc] init];
	}
  }
	return sharedSceneController;
}

//初始化UI控件
-(void)loadScene
{
	//初始化总的object
	sceneObjects = [[NSMutableArray alloc] init];
	
	//初始化UI界面
	[inputController loadInterface];
	
}

-(void) startScene
{
	self.animationInterval = 1.0/gameFrameRate;
	[self startAnimation];
}

//向场景中增加显示对象，在下一次loop中调用
-(void)addObjectToScene:(BBSceneObject*)sceneObject
{
	if (objectsToAdd == nil) 
		objectsToAdd = [[NSMutableArray alloc] init];
	sceneObject.active = YES;
	[sceneObject awake];
	[objectsToAdd addObject:sceneObject];
}

//从场景中删除显示对象，在下一次loop中调用
-(void)removeObjectFromScene:(BBSceneObject*)sceneObject
{
	if (objectsToRemove == nil) 
		objectsToRemove = [[NSMutableArray alloc] init];
	[objectsToRemove addObject:sceneObject];
}

- (void)gameLoop
{
	NSAutoreleasePool * apool = [[NSAutoreleasePool alloc] init];
	
	thisFrameStartTime = [levelStartDate timeIntervalSinceNow];
	deltaTime =  lastFrameStartTime - thisFrameStartTime;
	lastFrameStartTime = thisFrameStartTime;
	
	//增加场景对象
	if ([objectsToAdd count] > 0) {
		[sceneObjects addObjectsFromArray:objectsToAdd];
		[objectsToAdd removeAllObjects];
	}
	
	//glEnable(GL_SCISSOR_TEST);
	//glScissor(0, 0, 900, 400);
	
	//更新显示内容
	[self updateModel];
	//进行刷新
	[self renderScene];
	
	//glDisable(GL_SCISSOR_TEST);
	
	//移除场景对象
	if ([objectsToRemove count] > 0) {
		[sceneObjects removeObjectsInArray:objectsToRemove];
		[objectsToRemove removeAllObjects];
	}
	
	[apool release];
	
}

- (void)updateModel
{
	//ui层进行刷新
	[inputController updateInterface];
	//让每个场景对象进行刷新
	
	[sceneObjects makeObjectsPerformSelector:@selector(update)];
	//清除存储的所有的触摸事件
	[inputController clearEvents];
}

- (void)renderScene
{
	//draw
	[openGLView beginDraw];
	
	//让每个对象进行刷新
	[sceneObjects makeObjectsPerformSelector:@selector(render)];
	//ui层进行渲染
	[inputController  renderInterface];
	
	//获得图像 显示出来
	[openGLView finishDraw];
}


#pragma mark Animation Timer

- (void)startAnimation
{
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)stopAnimation {
	self.animationTimer = nil;
}

- (void)setAnimationTimer:(NSTimer *)newTimer {
	[animationTimer invalidate];
	animationTimer = newTimer;
}

- (void)setAnimationInterval:(NSTimeInterval)interval {	
	animationInterval = interval;
	if (animationTimer) {
		[self stopAnimation];
		[self startAnimation];
	}
}

- (void) dealloc
{
	[self stopAnimation];
	[levelStartDate release];
	[super dealloc];
}

@end
