    //
//  BattleView.m
//  BallGame
//
//  Created by 沈 冬冬 on 11-11-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "B_CellVIew.h"
#import "Constants.h"
#import "BattleFuncClass.h"
#import "B_Cell.h"
#import "B_PowerSide.h"
#import "B_Scene.h"
#import "UIDefine.h"

@implementation B_CellVIew

@synthesize colorCellCount;

@synthesize colorMatrixRecord;
@synthesize colorMatrixRecordByClolumn;

@synthesize singleCheckDic;

@synthesize dictionaryByColum;

@synthesize cellDisapperType;
@synthesize power;

@synthesize isSimu;
@synthesize waitTimer;
@synthesize fillWaitTimer;

@synthesize curDispearType;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

-(void) prepareToCheckCells
{	
	dictionaryByColum = [[NSMutableDictionary alloc] init];
	
	singleCheckDic = [NSMutableDictionary dictionary];
	[singleCheckDic removeAllObjects];
	//cellDisapperType = [NSMutableDictionary dictionary];
	cellDisapperType = [[NSMutableDictionary alloc] init];
	
}

-(void) colorButtonClicked:(B_Cell *)cell
{
	if (cell) 
	{
		[self prepareToCheckCells];
		
		if (power && power.sidetype == userSide) 
		{
			[self setcellMouseEnable:NO];
		}
		
		curDispearType = cell.colorType;
		
		[self startChekType:cell.row column:cell.column type:cell.colorType];
		
		waitTimer = [NSTimer scheduledTimerWithTimeInterval:cellFallWaitTime target:self selector:@selector(makecellsfall) 
												   userInfo:nil repeats:NO];
		
		if (power.sidetype == userSide) {
			[power.scene simuAttack];
		}
		if (power) {
			[power handleDisapperCell:cellDisapperType cellType:curDispearType];			//处理此次消失的cell
		}
		
	}
}

-(void) makecellsfall					//插入新的cell
{
	NSMutableArray *singleArray;
	NSMutableArray *columnArrayForChange;
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
			B_Cell * obj = [singleArray objectAtIndex:i];
			[rowPosArr addObject:[NSNumber numberWithInt:obj.row]];
		}
		
		i = 0;
		count = [rowPosArr count];
		NSNumber * pos;
		NSMutableArray *cellInAColumn = [colorMatrixRecordByClolumn objectAtIndex:[index intValue]];		//这一列的column
		for (B_Cell *downCell in cellInAColumn) {
			if (downCell == nil) {
				continue;
			}
			int downValue = 0;
			for (i = 0; i < count; i++) {
				pos = [rowPosArr objectAtIndex:i];
				if (pos == nil) {
					continue;
				}
				if (downCell.column != [index intValue]) {
					continue;
				}
				if (downCell.row == [pos intValue]) {
					break;
				}
				if (downCell.row < [pos intValue]) {
					downValue++;
				}
			}
			[downCell setDownValue:downValue];
		}
		
		//设置加进来的cell的初始位置,并且减少个数的计数
		for (i = 0; i < count; i++) {
			B_Cell * obj = [singleArray objectAtIndex:i];
			[obj setFillPos:i+1];
			[self decreseCellType:obj];
		}
		
		columnArrayForChange = [colorMatrixRecordByClolumn objectAtIndex:[index intValue]];
		if (columnArrayForChange != nil) {
			NSMutableArray *tempArr = [NSMutableArray array];
			for (B_Cell *cellForRefresh in columnArrayForChange) {
				[tempArr addObject:cellForRefresh];
			}
			for (B_Cell *cellInfo in tempArr) {
				[self changeValueInfo:cellInfo];
			}
		}
		
		//设置新加进来的cell的类型
		for (i = 0; i < count; i++) {
			B_Cell * obj = [singleArray objectAtIndex:i];
			[obj setCellType:[self getNextCellType]];
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
	[self setcellMouseEnable:YES];
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
		for (B_Cell *cell in cellInARow) {
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

-(void) setcellMouseEnable:(Boolean) allow
{
	for (int index = 0;index <  [colorMatrixRecord count]; index++) 
	{
		NSMutableArray *cellInARow = [colorMatrixRecord objectAtIndex:index];
		for (B_Cell *cell in cellInARow)
		{
			if (cell != nil)
			{
				[cell.view setUserInteractionEnabled:allow];
			}
		}
	}
	
}

-(void) changeValueInfo:(B_Cell *)cell
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

-(B_Cell *) getCellByRowColumn:(int)row columnCount:(int)column
{
	B_Cell *resValue;
	if (colorMatrixRecord == nil) {
		return nil;
	}
	NSMutableArray *temptable = [colorMatrixRecord objectAtIndex:row];
	if (temptable) {
		resValue = [temptable objectAtIndex:column];
	}
	return resValue;
}

-(B_Cell *) getCellByIndex:(int)index
{
	int row = index / battleColumns;
	int column = index % battleColumns;
	B_Cell *cell = [self getCellByRowColumn:row columnCount:column];
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
	B_Cell *cell = [self getCellByIndex:object];
	NSMutableArray *singleArray;
	
	if (cell == nil) {
		return;
	}
	
	if (isSimu == NO) {
		[cell setSelfVisible:NO];
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

	B_Cell *cell = [self getCellByRowColumn:rowValue columnCount:columnValue];
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

-(void)initBattleCells
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
			CGRect pos = CGRectMake(posx, posy, cellWidth, cellHeight);
			int cellType = [self getNextCellType];
			B_Cell *tempCell = [BattleFuncClass createCellButtonForView:pos withTag:i * battleColumns + j type:cellType];
			
			[self.view addSubview:tempCell.view];
			
			tempCell.cellParent = self;
			tempCell.row = i;
			tempCell.column = j;
			[cellsInARow addObject:tempCell];
			
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
		//NSLog(@"%d",[colorMatrixRecord count]);
	}
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

-(void) decreseCellType:(B_Cell *)cell				//消失的cell，减少他们对应的类型的数量
{
	NSNumber *num = [colorCellCount objectAtIndex:cell.colorType];
	int count = [num intValue];
	[colorCellCount replaceObjectAtIndex:cell.colorType withObject:[NSNumber numberWithInt:count - 1]];
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
			CGRect pos = CGRectMake(posx, posy, cellWidth, cellHeight);
			int cellType = [self getNextCellType];
			
			B_Cell *tempCell = [BattleFuncClass createCellButtonForView:pos withTag:i * battleColumns + j type:cellType];
			
			tempCell.cellParent = self;
			tempCell.row = i;
			tempCell.column = j;
			[cellsInARow addObject:tempCell];
			
			if (i == 0) {
				cellsInAColumn = [NSMutableArray array];
				[colorMatrixRecordByClolumn addObject:cellsInAColumn];
			}
			else {
				cellsInAColumn = [colorMatrixRecordByClolumn objectAtIndex:j];
			}
			 
			//[cellsInAColumn addObject:tempCell];
			
		}
		[colorMatrixRecord addObject:cellsInARow];
	}
}

-(void)loadView
{
	//self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 280, 400, 320)];
	self.view = [[UIView alloc] initWithFrame:battleViewFrame];
	
	self.view.backgroundColor = [UIColor grayColor];
	self.view.clipsToBounds = YES;
	
	[self initBattleCells];
}

-(void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
