/*
 *  BGPoint.h
 *  BallGame
 
 *	用来定义基础的点
 
 *  Created by 沈 冬冬 on 11-12-26.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */
typedef struct {
	CGFloat			x, y, z;
} BGPoint;

typedef BGPoint* BBPointPtr;

static inline BGPoint BGPointMake(CGFloat x, CGFloat y, CGFloat z)
{
	return (BGPoint) {x, y, z};
}

static inline BGPoint BGPointFilter(CGFloat x, CGFloat y, CGFloat z)
{
	if (x < 0) {
		x = 0;
	}
	if (y < 0) {
		y = 0;
	}
	if (z < 0) {
		z = 0;
	}
	return (BGPoint){x,y,z};
}

//记录两个point之间的差值
static inline BGPoint BGPointSubtract(BGPoint finalValue,BGPoint originalValue)
{
	return (BGPoint){finalValue.x - originalValue.x,finalValue.y - originalValue.y, finalValue.z - originalValue.z};
}

//判断某个point是否为空
static inline bool isPointEmpty(BGPoint ptValue)
{
	return ptValue.x <= 0 && ptValue.y <= 0 && ptValue.z <= 0;
}

static inline BGPoint BGPointADDPoint(BGPoint pt1,BGPoint pt2)
{
	return (BGPoint){pt1.x + pt2.x,pt1.y + pt2.y,pt1.z + pt2.z};
}

static inline NSString * NSStringFromBBPoint(BGPoint p)
{
	return [NSString stringWithFormat:@"{%3.2f, %3.2f, %3.2f}",p.x,p.y,p.z];
}

static inline NSString * NSStringFromMatrix(CGFloat * m)
{
	return [NSString stringWithFormat:@"%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n%3.2f %3.2f %3.2f %3.2f\n",m[0],m[4],m[8],m[12],m[1],m[5],m[9],m[13],m[2],m[6],m[10],m[14],m[3],m[7],m[11],m[15]];
}

static inline BGPoint BBPointMatrixMultiply(BGPoint p, CGFloat* m)
{
	CGFloat x = (p.x*m[0]) + (p.y*m[4]) + (p.z*m[8]) + m[12];
	CGFloat y = (p.x*m[1]) + (p.y*m[5]) + (p.z*m[9]) + m[13];
	CGFloat z = (p.x*m[2]) + (p.y*m[6]) + (p.z*m[10]) + m[14];
	
	return (BGPoint) {x, y, z};
}

static inline float BBPointDistance(BGPoint p1, BGPoint p2)
{
	return sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + 
				((p1.y - p2.y)  * (p1.y - p2.y)) + 
				((p1.z - p2.z) * (p1.z - p2.z)));
}
