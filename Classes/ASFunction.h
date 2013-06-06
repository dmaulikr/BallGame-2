//
//  Function.h
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASFunction : NSObject {
	id obj;
	SEL method;
	id userData;
}
-(ASFunction*) initWithObject:(id)_obj method:(SEL)_method;
@property (readonly) id obj;
@property (readonly) SEL method;
@property (retain) id userData;
@end
