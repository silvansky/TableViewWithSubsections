//
//  VSSectionInfo.m
//  TableWithFooters
//
//  Created by Valentine on 23.01.14.
//  Copyright (c) 2014 silvansky. All rights reserved.
//

#import "VSSectionInfo.h"
#import "VSCellInfo.h"

@interface VSSectionInfo ()

// array of arrays of cells
@property NSArray *subsectionsCells;

@end

@implementation VSSectionInfo

+ (VSSectionInfo *)sectionInfoWithCaption:(NSString *)caption cells:(NSArray *)cells
{
	VSSectionInfo *si = [VSSectionInfo new];
	si.caption = caption;
	NSMutableArray *subsectionsCells = [NSMutableArray new];
	NSMutableArray *sectionCells = [NSMutableArray new];
	[subsectionsCells addObject:sectionCells];
	for (VSCellInfo *ci in cells)
	{
		[sectionCells addObject:ci];
		if (ci.footerText)
		{
			sectionCells = [NSMutableArray new];
			[subsectionsCells addObject:sectionCells];
		}
	}
	si.subsectionsCells = subsectionsCells;
	return si;
}

- (NSInteger)subsectionsCount
{
	return [self.subsectionsCells count];
}

- (NSInteger)rows
{
	NSInteger totalCells = 0;
	for (NSArray *sub in self.subsectionsCells)
	{
		totalCells += [sub count];
	}
	return totalCells;
}

- (NSInteger)rowsInSubsection:(NSInteger)subsection
{
	return [self.subsectionsCells[subsection] count];
}

- (NSInteger)subsectionForRow:(NSInteger)row
{
	return 0;
}

- (VSCellInfo *)cellInfoForSubsection:(NSInteger)subsection row:(NSInteger)row
{
	return  self.subsectionsCells[subsection][row];
}

- (NSString *)titleForFooterInSubsection:(NSInteger)subsection
{
	NSArray *items = self.subsectionsCells[subsection];
	VSCellInfo *info = [items lastObject];
	return info.footerText;
}

@end
