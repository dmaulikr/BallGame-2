//
//  GLMovieClip.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-3-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BGMovieClip.h"
#import "BGSwfMaker.h"
#import "BGAnimatedImageMesh.h"

@implementation BGMovieClip

@synthesize totalFrames;
@synthesize ismirrorHorizon,ismirrorVertical;

//通过一个整个系列来初始化
-(id) initwithTotalName:(NSString *)totalName loops:(BOOL)loops
{
	self = [super init];
	if (self) {
		self.mesh = [BGSwfMaker animationFromSwfName:totalName];
		[(BGAnimatedImageMesh*)mesh setLoops:loops];
	}
	return self;
}

@end
