//
//  RoleSprite.h
//  用于播放自己的动画
//
//

#import <Foundation/Foundation.h>
#import "Sprite.h"

@interface RoleSprite : Sprite {
	CGFloat w2;						// 
	CGFloat h2;						//
	CGFloat roleWidth;				//
	CGFloat roleHeight;
	
	UIImage *atlas;					// 保存所有的图片，用于显示
	CGImageRef image;				// 用来绘图的图形引用3.。
	
	CGRect clipRect;				// 用于切图的rect
	int rows;						// 行数
	int columns;					// 列数
}

@property (assign) CGFloat w2, h2, roleWidth, roleHeight;
@property (assign) CGRect clipRect;
@property (assign) int rows, columns;
@property (retain, nonatomic) UIImage *atlas;
@property (assign) CGImageRef image;

+ (RoleSprite *) fromFile: (NSString *) fname withRows: (int) rows withColumns: (int) columns
			 contentWidth:(int)contentWidth contentHeight:(int)contentHeight;
+ (NSMutableDictionary *) sharedSpriteAtlas;
+ (UIImage *) getSpriteAtlas: (NSString *) name;

@end