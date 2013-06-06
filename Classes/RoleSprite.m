//
//  RoleSprite.m
//  沈冬冬
//
//

#import "RoleSprite.h"

@implementation RoleSprite
@synthesize rows,columns;
@synthesize image, atlas, roleWidth, roleHeight, clipRect, w2, h2;

+(NSMutableDictionary *) sharedSpriteAtlas
{
	static NSMutableDictionary *sharedSpriteDictionary;
	@synchronized(self)
	{
		if (!sharedSpriteDictionary) {
			sharedSpriteDictionary = [[NSMutableDictionary alloc] init];
			return sharedSpriteDictionary;
		}
	}
	return sharedSpriteDictionary;
}

//静态方法，取得某个名称的资源，资源文件保存再静态缓存中
+ (UIImage *) getSpriteAtlas: (NSString *) name
{
	NSMutableDictionary *d = [RoleSprite sharedSpriteAtlas];
	UIImage *img = [d objectForKey: name];
	if (!img) {
		img = [[UIImage alloc] 
			   initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:nil]];
		[d setObject: img forKey: name];
	}
	return img;
}	

//从某个文件中取出位图信息
+ (RoleSprite *) fromFile: (NSString *) fname withRows: (int) rows withColumns: (int) columns
			 contentWidth:(int)contentWidth contentHeight:(int)contentHeight
{
	RoleSprite *s = [[RoleSprite alloc] init];
	s.atlas = [[RoleSprite getSpriteAtlas:fname] retain];
	CGImageRef img = [s.atlas CGImage];
	s.image = img;
	
	s.contentWidth = contentWidth;
	s.contentHeight = contentHeight;
	
	int width = CGImageGetWidth(s.image);			//整个图片的宽度
	int height = CGImageGetHeight(s.image);			//整个图片的高度
	
	if (rows < 1) 
		rows = 1;
	if (columns < 1) 
		columns = 1;
	
	s.roleWidth = width;
	s.roleHeight = height;
	
	s.rows = rows;
	s.columns = columns;
	
	s.w2 = s.contentWidth*0.5;
	s.h2 = s.contentHeight*0.5;
	
	s.clipRect = CGRectMake(0,0,s.contentWidth,s.contentHeight);
	return s;
}

- (id) init
{
	self = [super init];
	if (self) {
		rows = 0.0;
		columns = 0.0;
	}
	return self;
}

- (void) drawBody: (CGContextRef) context
{	
	int r0 = floor(frameIndex/columns);
	int c0 = frameIndex % columns;
	CGFloat u = c0*contentWidth;						
	CGFloat v = r0*contentHeight;
	
	//获得指定rect区域的位图信息
	CGImageRef partimgRef = CGImageCreateWithImageInRect(image, CGRectMake(u, v, contentWidth, contentHeight));
	
	/*CGContextBeginPath(context);
	CGContextAddRect(context, clipRect);
	CGContextClip(context);*/
	
	//将部分image绘制到context上
	//CGContextDrawImage(context, CGRectMake(-u,-v,roleWidth,roleHeight),image);
	CGContextDrawImage(context,clipRect,partimgRef);
	
}

- (void) dealloc
{
	[atlas release];
	CGImageRelease(image);
	[super dealloc];
}

@end
