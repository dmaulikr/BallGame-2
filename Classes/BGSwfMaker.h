//
//  BBMaterialController.h
//  BallGame
//
//  Created by SDD on 14/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "BGPoint.h";
#import "BBConfiguration.h";
#import "BGImageMesh.h"

@class BGImageMesh;
@class BGAnimatedImageMesh;

@interface BGSwfMaker : NSObject {
	NSMutableArray * materialKeys;
}

@property (nonatomic,retain) NSMutableArray *materialKeys;
//@property (retain) NSMutableDictionary *quadLibrary;

+(BGSwfMaker *) getSingleSwfMaker:(NSString *) fileName;
+(void)bindMaterial:(NSString *) materialKey;
+(BGImageMesh*)quadFromAtlasKey:(NSString*)atlasKey;
+(BGAnimatedImageMesh*)animationFromAtlasKeys:(NSArray*)atlasKeys;		
+(BGAnimatedImageMesh *)animationFromSwfName:(NSString *)swfName;

-(id) init;
- (BGImageMesh*)texturedQuadFromAtlasRecord:(NSDictionary*)record atlasSize:(CGSize)atlasSize materialKey:(NSString*)key;
- (CGSize)loadTextureImage:(NSString*)imageName materialKey:(NSString*)materialKey;
- (void) dealloc;
- (void)loadAtlasData:(NSString*)atlasName;

@end
