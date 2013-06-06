//
//  GLCellArea.m
//  BallGame
//
//  Created by 沈 冬冬 on 12-1-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GLCellArea.h"
#import "Constants.h"
#import "BattleFuncClass.h"
#import "GLCell.h"
#import "GLPowerSide.h"
#import "GLScene.h"
#import "UIDefine.h"
#import "GLDisplayobjectContainer.h"

@implementation GLCellArea

@synthesize colorCellCount;

@synthesize colorMatrixRecord;
@synthesize colorMatrixRecordByClolumn;

@synthesize singleCheckDic;

@synthesize dictionaryByColum;

@synthesize cellDisapperType;

@synthesize isSimu;
@synthesize waitTimer;
@synthesize fillWaitTimer,curDispearType;

-(void) setPower:(GLPowerSide *)powerInfo
{
	power = powerInfo;
	self.pos = BGPointMake(battleViewFrame.origin.x, battleViewFrame.origin.y, 1);
	self.scale = BGPointMake(battleViewFrame.size.width, battleViewFrame.size.height, 1);
}

-(void) initGLBattle					//初始化opengl场景
{	
	[self initBattleStatus];
	int posx = 0;
	int posy = 0;
	NSMutableArray *cellsInARow;
	NSMutableArray *cellsInAColumn;
	for(int i=0; i<battleRows; i++) {
		cellsInARow = [NSMutableArray array];
		for (int j =0; j < battleColumns; j++){
			posx = j * cellWidth;
			posy = i * cellHeight + verticalGap;
			CGRect posValue = CGRectMake(posx, posy, cellWidth, cellHeight);
			int cellType = [self getNextCellType];
			
			GLCell *tempCell = [BattleFuncClass createGLCell:posValue withTag:i * battleColumns + j type:cellType side:power.sidetype];

			tempCell.cellParent = self;
			tempCell.row = i;
			tempCell.column = j;
			[self addChild:tempCell];
			
			[cellsInARow addObject:tempCell];
			[tempCell initImages];
			
			if (i == 0) {
				cellsInAColumn = [NSMutableArray array];
				[colorMatrixRecordByClolumn addObject:cellsInAColumn];
			}
			else {
				cellsInAColumn = [colorMatrixRecordByClolumn objectAtIndex:j];
			}
			
			[cellsInAColumn addObject:tempCell];
			
		}
		[colorMatrixRecord addObject:cellsInARow];
	}
}

-(void) prepareToCheckCells
{	
	dictionaryByColum = [[NSMutableDictionary alloc] init];
	
	singleCheckDic = [NSMutableDictionary dictionary];
	cellDisapperType = [[NSMutableDictionary alloc] init];
}

/*处理cell的点击事件*/
-(void) colorButtonClicked:(GLCell *)cell
{
	if (cell) 
	{
		[self prepareToCheckCells];
		if (power && power.sidetype == userSide) 
		{
			self.mouseChildren = NO;
		}
		curDispearType = cell.colorType;
		
		[self startChekType:cell.row column:cell.column type:cell.colorType];
		
		waitTimer = [NSTimer scheduledTimerWithTimeInterval:cellFallWaitTime target:self selector:@selector(makecellsfall) 
												   userInfo:nil repeats:NO];
		
		if (power.sidetype == userSide)		//如果是玩家点击，模拟对方的反应
		{
			[power.scene simuAttack];
		}
		if (power) 
		{
			[power handleDisapperCell:cellDisapperType cellType:curDispearType];			//处理此次消失的cell
		}
		
	}
}

/*让cell下降*/
-(void) makecellsfall					
{
	NSMutableArray *singleArray;
	for (NSNumber* index in [dictionaryByColum allKeys]) 
	{
		singleArray = [dictionaryByColum objectForKey:index];
		if (singleArray == nil) 
		{
			continue;
		}
		
		NSMutableArray *rowPosArr = [NSMutableArray array];
		
		//记录这一列的需要消失的cell的row
		NSUInteger i, count = [singleArray count];
		for (i = 0; i < count; i++) {
			GLCell * obj = [singleArray objectAtIndex:i];
			[rowPosArr addObject:[NSNumber numberWithInt:obj.row]];
		}
		
		i = 0;
		count = [rowPosArr count];
		NSNumber * posValue;
		NSMutableArray *cellInAColumn = [colorMatrixRecordByClolumn objectAtIndex:[index intValue]];		//这一列的column
		for (GLCell *downCell in cellInAColumn) {
			if (downCell == nil) {
				continue;
			}
			int downValue = 0;
			for (i = 0; i < count; i++) {
				posValue = [rowPosArr objectAtIndex:i];
				if (posValue == nil) {
					continue;
				}
				if (downCell.column != [index intValue]) {
					continue;
				}
				if (downCell.row == [posValue intValue]) {
					break;
				}
				if (downCell.row < [posValue intValue]) {
					downValue++;
				}
			}
			[downCell setDownValue:downValue];			//设置次column中cell需要下沉的信息
		}
		
		//设置加进来的cell的初始位置,并且减少个数的计数
		for (i = 0; i < count; i++) {
			GLCell * obj = [singleArray objectAtIndex:i];
			[obj setFillPos:i+1];
			[self decreseCellType:obj];
		}
		
		//更新全局的matrix信息
		//cellInAColumn = [colorMatrixRecordByClolumn objectAtIndex:[index intValue]];
		if (cellInAColumn != nil) {
			
			NSMutableArray *tempArr = [NSMutableArray array];
			for (GLCell *cellForRefresh in cellInAColumn) {
				[tempArr addObject:cellForRefresh];
			}
			for (GLCell *cellInfo in tempArr) {
				[self changeValueInfo:cellInfo];
			}
		}
		
		//设置新加进来的cell的类型
		for (i = 0; i < count; i++) {
			GLCell * obj = [singleArray objectAtIndex:i];
			[obj setColorType:[self getNextCellType]];
		}
		
	}
	
	[dictionaryByColum release];
	[cellDisapperType release];
	
	fillWaitTimer = [NSTimer scheduledTimerWithTimeInterval:cellAttackTime target:self selector:@selector(fillFinished) 
												   userInfo:nil repeats:NO];
	
}

-(void) insertNewCell
{
	
}

-(void) fillFinished			//消去的cell已经补进
{
	if (power.sidetype == userSide) {
		self.mouseChildren = YES;
	}
	[power.scene makeAttack:curDispearType powerside:power];
}

-(int) getCellToClick
{
	NSMutableDictionary *tempRecord = [NSMutableDictionary dictionary];
	int countInvolved = 0;						//记录的最多消去cell格子数
	int cellIndex = -1;							//能够消去的最多的cell的index
	dictionaryByColum = [NSMutableDictionary dictionary];
	isSimu = YES;
	
	for (int index = 0;index <  [colorMatrixRecord count]; index++) 
	{
		NSMutableArray *cellInARow = [colorMatrixRecord objectAtIndex:index];
		for (GLCell *cell in cellInARow) {
			if (cell != nil) {
				int uniqueIndex = [self getUniqueIndex:cell.row column:cell.column];
				if ([tempRecord objectForKey:[NSNumber numberWithInt:uniqueIndex]] == nil)			//如果还没有检查过
				{
					[tempRecord setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:uniqueIndex]];
					[self prepareToCheckCells];
					[dictionaryByColum removeAllObjects];
					
					[self startChekType:cell.row column:cell.column type:cell.colorType];
					
					int curCount = [dictionaryByColum count];
					if (curCount > countInvolved) {
						countInvolved = curCount;
						cellIndex = uniqueIndex;
					}
				}
				else 
				{
					continue;
				}
				
			}
		}
	}
	isSimu = NO;
	return cellIndex;
}

-(void) changeValueInfo:(GLCell *)cell
{
	if (cell == nil) {
		return;
	}
	NSMutableArray *temptable;
	
	if (colorMatrixRecord != nil) {
		temptable = [colorMatrixRecord objectAtIndex:cell.row];
		if (temptable) {
			[temptable replaceObjectAtIndex:cell.column withObject:cell];
		}
	}
	
	if (colorMatrixRecordByClolumn != nil) {
		temptable = [colorMatrixRecordByClolumn objectAtIndex:cell.column];
		if (temptable) {
			[temptable replaceObjectAtIndex:cell.row withObject:cell];
		}
	}
}

-(int) getUniqueIndex:(int) rowValue column:(int)clolumnValue
{
	int b_columns = battleColumns;
	int uniqueIndex = rowValue*b_columns + clolumnValue;
	return uniqueIndex;
}

-(GLCell *) getCellByRowColumn:(int)row columnCount:(int)column
{
	GLCell *resValue;
	if (colorMatrixRecord == nil) {
		return nil;
	}
	NSMutableArray *temptable = [colorMatrixRecord objectAtIndex:row];
	if (temptable) {
		resValue = [temptable objectAtIndex:column];
	}
	return resValue;
}

-(GLCell *) getCellByIndex:(int)index
{
	int row = index / battleColumns;
	int column = index % battleColumns;
	GLCell *cell = [self getCellByRowColumn:row columnCount:column];
	return cell;
}

-(void) startChekType:(int) rowValue column:(int)columnValue type:(int)typeValue
{
	if ([self checkCellIsType:rowValue column:columnValue type:typeValue] == YES) {
		
		[self saveCellRevolved:[self getUniqueIndex:rowValue column:columnValue]];
		
		[self startChekType:rowValue-1 column:columnValue type:typeValue];
		[self startChekType:rowValue column:columnValue-1 type:typeValue];
		[self startChekType:rowValue column:columnValue+1 type:typeValue];
		[self startChekType:rowValue+1 column:columnValue type:typeValue];
		return;
	}
	else {
		return;
	}
}

//记录此次消去的cell类型
-(void) recordDisCellType:(int) type
{
	if ([cellDisapperType objectForKey:[NSNumber numberWithInt:type]] == nil) 
	{
		[cellDisapperType setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:type]];
	}
	else 
	{
		NSNumber *value = [cellDisapperType objectForKey:[NSNumber numberWithInt:type]];
		int count = [value intValue];
		count++;
		[cellDisapperType setObject:[NSNumber numberWithInt:count] forKey:[NSNumber numberWithInt:type]];
	}
}

-(void) saveCellRevolved:(int) object				//将满足的cell保存
{
	GLCell *cell = [self getCellByIndex:object];
	NSMutableArray *singleArray;
	
	if (cell == nil) {
		return;
	}
	
	if (isSimu == NO) {
		[cell setVisible:NO];		//设置不可见
	}
	
	if ([dictionaryByColum objectForKey:[NSNumber numberWithInt:cell.column]] == nil) {
		singleArray= [NSMutableArray array];
		[singleArray addObject:cell];
		[dictionaryByColum setObject:singleArray forKey:[NSNumber numberWithInt:cell.column]];
	}
	else {
		singleArray = [dictionaryByColum objectForKey:[NSNumber numberWithInt:cell.column]];
		if (singleArray) {
			[singleArray addObject:cell];
			NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:YES];
			[singleArray sortUsingDescriptors:[NSArray arrayWithObject:sortByA]];
		}
	}
}

-(Boolean) checkCellIsType:(int)rowValue column:(int)columnValue type:(int)value
{
	if(rowValue < 0 || rowValue >= battleRows || columnValue < 0 || columnValue >= battleColumns)
	{
		return NO;
	}
	//NSLog(@"the cell row is %d colimn  is %d",rowValue,columnValue);
	int index = [self getUniqueIndex:rowValue column:columnValue];
	if([singleCheckDic objectForKey:[NSNumber numberWithInt:index]] == nil)
	{
		[singleCheckDic setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:index]];
	}
	else {
		return NO;
	}
	
	GLCell *cell = [self getCellByRowColumn:rowValue columnCount:columnValue];
	if (cell) {
		if (cell.colorType == value) {
			[self recordDisCellType:cell.effecttype];
			return YES;
		}
	}
	else {
		return NO;
	}
	return NO;
}

-(void) initBattleStatus
{
	colorCellCount = [[NSMutableArray alloc]  initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],
					  [NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil] ;
	colorMatrixRecord = [[NSMutableArray alloc] init];
	colorMatrixRecordByClolumn = [[NSMutableArray alloc] init];
}

-(int) getNextCellType
{
	int randomNum = arc4random() % cellColors;
	return randomNum;
	while (1) {
		NSNumber *curCount = [[colorCellCount objectAtIndex:randomNum] retain];
		NSInteger count = [curCount intValue];
		[curCount release];
		if (count >= 25) {
			randomNum = (randomNum + 1) % 4;
		}
		else {
			[colorCellCount replaceObjectAtIndex:randomNum withObject:[NSNumber numberWithInt:count + 1]];
			break;
		}
	}
	return randomNum;
}

-(void) decreseCellType:(GLCell *)cell				//消失的cell，减少他们对应的类型的数量
{
	NSNumber *num = [colorCellCount objectAtIndex:cell.colorType];
	int count = [num intValue];
	[colorCellCount replaceObjectAtIndex:cell.colorType withObject:[NSNumber numberWithInt:count - 1]];
}

- (void)dealloc {
	[colorCellCount release];
	[singleCheckDic release];
	[dictionaryByColum release];
	[colorMatrixRecordByClolumn release];
	[colorMatrixRecord release];
	[cellDisapperType release];
	[power release];
	[waitTimer release];
	isSimu = NO;
	curDispearType = 0;
	[super dealloc];
	
}

@end
