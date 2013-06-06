//
//  BGAnimation.h
//  SpaceRocks
//
//  Created by 沈 冬冬 on 12-1-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BBSceneObject.h"
#import "GLDisplayobject.h"

@interface BGAnimation:GLDisplayobject
{
	
}

-(id)initWithAtlasKeys:(NSArray*)keys loops:(BOOL)loops;
-(id) initwithTotalName:(NSString *)totalName loops:(BOOL)loops;
-(void)update;
-(void)awake;

@end
