//
//  SwfImageParser.h
//  BallGame
//	用来将一张整图解析为一帧一帧的图片
//  Created by 沈 冬冬 on 11-12-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwfImageParser : NSObject {

	NSString *fileName;
	
	NSString *originalName;
	int frameCount;
	int frameWidth;
	int frameHeight;
	int frameCountPrtRow;
	
	NSArray *bitmapArr;
	
}

@property (nonatomic,retain) NSString *originalName;
@property (nonatomic,assign) int frameCount;
@property (nonatomic,assign) int frameWidth;
@property (nonatomic,assign) int frameHeight;
@property (nonatomic,assign) int frameCountPrtRow;

-(UIImage *) setFileName:(NSString *)name;				//设置那个文件名字，url用于解析

@end
