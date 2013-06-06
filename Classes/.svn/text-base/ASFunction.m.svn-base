//
//  Function.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ASFunction.h"

@implementation ASFunction
@synthesize obj;
@synthesize method;
@synthesize userData;
- (ASFunction*) initWithObject:(id)_obj method:(SEL)_method
{
	if((self = [super init]))
	{
		obj = _obj;
		method = _method;
	}
	return self;
}

-(void) doCall
{
	if (obj && method) {
		if ([obj respondsToSelector:method]) {
			[obj performSelector:method];
		}
	}
}

@end
