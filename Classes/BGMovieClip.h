//
//  GLMovieClip.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-3-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGAnimation.h"

@interface BGMovieClip:BGAnimation {
	int totalFrames;
}

@property (nonatomic,assign) Boolean ismirrorHorizon;
@property (nonatomic,assign) Boolean ismirrorVertical;

-(id) initwithTotalName:(NSString *)totalName loops:(BOOL)loops;

@property (nonatomic,assign) int totalFrames;

@end
