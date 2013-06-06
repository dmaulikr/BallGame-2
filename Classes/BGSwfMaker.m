//
//  BBMaterialController.m
//  BallGame
//
//  Created by SDD on 14/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BGSwfMaker.h"
#import "BGAnimatedImageMesh.h"
#import "BGImageMesh.h"

@implementation BGSwfMaker

@synthesize materialKeys;

static NSMutableDictionary * quadLibrary;
static NSMutableDictionary * materialLibrary;
static NSMutableDictionary * pool;

-(id) init
{
	self = [super init];
	if (self) {
		self.materialKeys = [[NSMutableArray alloc] init];
	}
	return self;
}

+(BGSwfMaker *) getSingleSwfMaker:(NSString *) fileName
{
	BGSwfMaker* result;
	@synchronized(self)
	{
		if (quadLibrary == nil) 
			quadLibrary = [[NSMutableDictionary alloc] init];
		if (materialLibrary == nil) 
			materialLibrary = [[NSMutableDictionary alloc] init];
		if(pool == nil)
		{
			pool = [[NSMutableDictionary alloc] init];
		}
		if ([pool objectForKey:fileName]) {
			result = [pool objectForKey:fileName];
		}
		else											//如果不存再这个文件的swfmaker
		{
			result = [[BGSwfMaker alloc] init];
			[result loadAtlasData:fileName];			//加载文件信息
			[pool setObject:result forKey:fileName];
		}
	}
	return result;
}

//得到单个单帧图片
+(BGImageMesh*)quadFromAtlasKey:(NSString*)atlasKey				
{
	return [quadLibrary objectForKey:atlasKey];
}

//让opengl对某个特定的纹理索引进行绑定操作
+(void)bindMaterial:(NSString*)materialKey
{
	NSNumber * numberObj = [materialLibrary objectForKey:materialKey];
	if (numberObj == nil) 
		return;
	GLuint textureID = [numberObj unsignedIntValue];
	
	glEnable(GL_TEXTURE_2D); 
	glBindTexture(GL_TEXTURE_2D, textureID);
}

//通过某个特定序列中帧图片,组成动画
+(BGAnimatedImageMesh*)animationFromAtlasKeys:(NSArray*)atlasKeys		
{
	BGAnimatedImageMesh * animation = [[BGAnimatedImageMesh alloc] init];
	for (NSString * key in atlasKeys) {
		[animation addFrame:[BGSwfMaker quadFromAtlasKey:key]];
	}
	return [animation autorelease];
}

//通过swf文件加载所有的帧图片
+(BGAnimatedImageMesh *)animationFromSwfName:(NSString *)swfName
{
	BGAnimatedImageMesh * animation = [[BGAnimatedImageMesh alloc] init];
	BGSwfMaker *targetMaker = [BGSwfMaker getSingleSwfMaker:swfName];
	if (targetMaker) {
		for (NSString * key in targetMaker.materialKeys) {
			[animation addFrame:[BGSwfMaker quadFromAtlasKey:key]];
		}
	}
	return [animation autorelease];
}

-(void)loadAtlasData:(NSString*)atlasName				//加载文件
{
	NSAutoreleasePool * apool = [[NSAutoreleasePool alloc] init];	
	
	CGSize atlasSize = [self loadTextureImage:[atlasName stringByAppendingPathExtension:@"png"] materialKey:atlasName];

	//获得所有的配置数据
	NSArray * itemData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:atlasName ofType:@"plist"]];
	
	for (NSDictionary * record in itemData)						//便利配置数组，获得所有的帧数据,并且保存
	{
		BGImageMesh * quad = [self texturedQuadFromAtlasRecord:record atlasSize:atlasSize materialKey:atlasName];
		[quadLibrary setObject:quad forKey:[record objectForKey:@"name"]];
		//NSLog(@"%@",[record objectForKey:@"name"]);
		NSString *tempName = (NSString *)[record objectForKey:@"name"];
		[self.materialKeys addObject:tempName];			//将某个swf文件中的帧数记录下来
	}
	
	[apool release];
}

//通过配置文件，得到单帧图片
-(BGImageMesh*)texturedQuadFromAtlasRecord:(NSDictionary*)record atlasSize:(CGSize)atlasSize materialKey:(NSString*)key;
{
	BGImageMesh * quad = [[BGImageMesh alloc] init];
	
	GLfloat xLocation = [[record objectForKey:@"xLocation"] floatValue];
	GLfloat yLocation = [[record objectForKey:@"yLocation"] floatValue];
	GLfloat width = [[record objectForKey:@"width"] floatValue];
	GLfloat height = [[record objectForKey:@"height"] floatValue];
	
	//获得纹理的坐标区域
	GLfloat uMin = xLocation/atlasSize.width;
	GLfloat vMin = yLocation/atlasSize.height;
	GLfloat uMax = (xLocation + width)/atlasSize.width;
	GLfloat vMax = (yLocation + height)/atlasSize.height;
	
	quad.uvCoordinates[0] = uMin;
	quad.uvCoordinates[1] = vMax;
	
	quad.uvCoordinates[2] = uMax;
	quad.uvCoordinates[3] = vMax;
	
	quad.uvCoordinates[4] = uMin;
	quad.uvCoordinates[5] = vMin;

	quad.uvCoordinates[6] = uMax;
	quad.uvCoordinates[7] = vMin;
	
	quad.materialKey = key;
	
	return [quad autorelease];
}

// 将加载进来的图片转为纹理
-(CGSize)loadTextureImage:(NSString*)imageName materialKey:(NSString*)materialKey
{
	CGContextRef spriteContext; //UIImage的Context
	GLubyte *spriteData; //保存ImageData
	size_t	width, height;
	GLuint textureID; // 此纹理的位移的ID
	
	//将图片转为CGImage
	UIImage*	uiImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
	CGImageRef spriteImage = [uiImage CGImage];
	width = CGImageGetWidth(spriteImage);
	height = CGImageGetHeight(spriteImage);
	
	CGSize imageSize = CGSizeMake(width, height);
	// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
	// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
	
	if (spriteImage) {
		//每个纹理是 RGBA的格式 每个是1个字节
		spriteData = (GLubyte *) malloc(width * height * 4);
		memset(spriteData, 0, (width * height * 4)); 
		// Uses the bitmatp creation function provided by the Core Graphics framework. 
		spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
		// After you create the context, you can draw the sprite image to the context.
		CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), spriteImage);
		//释放
		CGContextRelease(spriteContext);
		
		// 获得纹理对象的索引
		glGenTextures(1, &textureID);
		//对当前的纹理索引进行操作 
		glBindTexture(GL_TEXTURE_2D, textureID);
		// Specidfy a 2D texture image, provideing the a pointer to the image data in memory
		
		//Convert "RRRRRRRRRGGGGGGGGBBBBBBBBAAAAAAAA" to "RRRRRGGGGBBBBAAAA"
		// this will make your images take up half as much space in memory
		// but you will lose half of your color depth.
		if (BB_CONVERT_TO_4444) {
			void*					tempData;
			unsigned int*			inPixel32;
			unsigned short*			outPixel16;
			
			tempData = malloc(height * width * 2);
			
			inPixel32 = (unsigned int*)spriteData;
			outPixel16 = (unsigned short*)tempData;
			NSUInteger i;
			for(i = 0; i < width * height; ++i, ++inPixel32)
				*outPixel16++ = ((((*inPixel32 >> 0) & 0xFF) >> 4) << 12) | ((((*inPixel32 >> 8) & 0xFF) >> 4) << 8) | ((((*inPixel32 >> 16) & 0xFF) >> 4) << 4) | ((((*inPixel32 >> 24) & 0xFF) >> 4) << 0);
			
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_SHORT_4_4_4_4, tempData);
			free(tempData);
		} else {
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);			
		}
		
		free(spriteData);
		// Release 
		// 设置过滤
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		
		// Enable use of the texture
		glEnable(GL_TEXTURE_2D);
		// Set a blending function to use
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		// Enable blending
		glEnable(GL_BLEND);
	} else {
		return CGSizeZero;
	}
	[uiImage release];
	
	glDisable(GL_TEXTURE_2D);
	
	//将materialKey键入缓存池
	[materialLibrary setObject:[NSNumber numberWithUnsignedInt:textureID] forKey:materialKey];
	return imageSize;
}

- (void) dealloc
{
	[materialKeys release];
	[super dealloc];
}

@end
