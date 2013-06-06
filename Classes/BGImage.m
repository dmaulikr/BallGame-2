//
//  BGImage.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BGImage.h"
#import "BGSwfMaker.h"
#import "BGImageMesh.h"
#import "PostionFunc.h"

@implementation BGImage

-(id) initWithMaterialName:(NSString*)materialName
{
	self = [super init];
	if (self != nil) 
	{
		self.mesh = [BGSwfMaker quadFromAtlasKey:materialName];
	}
	return self;
}

-(void) changeMaterialName:(NSString *)newName
{
	if (mesh) 
	{
		self.mesh = [BGSwfMaker quadFromAtlasKey:newName];
	}
}

-(void) awake
{
	translation = [PostionFunc turnPositonToScenePositon:self];	
}

@end
