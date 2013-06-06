//
//  BattleView.h
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "B_Cell.h"
@class B_PowerSide;
@class B_Cell;

@interface B_CellVIew : UIViewController {
	
	NSMutableArray *colorCellCount;
	
	NSMutableArray *colorMatrixRecord;
	NSMutableArray *colorMatrixRecordByClolumn;
	
	NSMutableDictionary* singleCheckDic;
	NSMutableDictionary *dictionaryByColum;			//此次消去牵扯到的cell
	
	NSMutableDictionary *cellDisapperType;
	
	Boolean isSimu;
	B_PowerSide *power;				//父指针，记录属于哪个power
	
	NSTimer *waitTimer;			//消去的时候等待timer
	NSTimer *fillWaitTimer;		//加入的时候等待timer
	//NSTimer *attackTimer;		//攻击等待的timer
	
	int curDispearType;
	
}

@property (nonatomic,assign) Boolean isSimu;

@property (nonatomic,retain) NSMutableArray *colorCellCount;		//记录当前的各个种类按钮的数量

@property (nonatomic,retain) NSMutableArray *colorMatrixRecord;		
@property (nonatomic,retain) NSMutableArray *colorMatrixRecordByClolumn;

@property (nonatomic,retain) NSMutableDictionary* singleCheckDic;
@property (nonatomic,retain) NSMutableDictionary *dictionaryByColum;

@property (nonatomic,retain) NSMutableDictionary *cellDisapperType;
@property (nonatomic,retain) B_PowerSide *power;

@property (nonatomic,retain) NSTimer *waitTimer;
@property (nonatomic,retain) NSTimer *fillWaitTimer;
//@property (nonatomic,retain) NSTimer *attackTimer;

@property (nonatomic,assign) int curDispearType;				//此时消去的cell类型

-(void) initBattleCells;

//点击处理函数
-(void) colorButtonClicked:(B_Cell *)cell;

-(void) initBattleStatus;
-(int) getNextCellType;
-(void) decreseCellType:(id)cell;
-(Boolean) checkCellIsType:(int)rowValue column:(int)columnValue type:(int)value;
-(id) getCellByRowColumn:(int) row columnCount:(int)column;
-(void) startChekType:(int) rowValue column:(int)columnValue type:(int)typeValue;

//功能性方法
-(id) getCellByIndex:(int)index;
-(int) getUniqueIndex:(int) rowValue column:(int)clolumnValue;

//消去相关的方法
-(void) makecellsfall;							//让消去的cell下落新的cell

-(void) saveCellRevolved:(int) object;			//将此次关系到的cell保存
-(void) changeValueInfo:(id)cell;
-(void) recordDisCellType:(int) type;

//某次点击判断的时候进行初始化
-(void) prepareToCheckCells;	

-(int) getCellToClick;			//取得下一个cell去点击

-(void) setcellMouseEnable:(Boolean) allow;

-(void) initGLBattle;

@end
