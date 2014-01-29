//
//  VSViewController.m
//  TableWithFooters
//
//  Created by Valentine on 23.01.14.
//  Copyright (c) 2014 silvansky. All rights reserved.
//

#import "VSViewController.h"
#import "VSSectionInfo.h"
#import "VSCellInfo.h"

@interface VSViewController ()

@property NSMutableArray *sections; // array of VSSectionInfo

- (void)findSection:(NSInteger)section outRealSection:(NSInteger *)realSection outSubsection:(NSInteger *)subsection;

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	VSSectionInfo *si1, *si2, *si3;
	id cells1, cells2, cells3;
	cells1 = @[
			   [VSCellInfo cellInfoWithTitle:@"Cell 1/1" footerText:nil],
			   [VSCellInfo cellInfoWithTitle:@"Cell 2/1" footerText:nil],
			   [VSCellInfo cellInfoWithTitle:@"Cell 3/1" footerText:nil]
			   ];
	si1 = [VSSectionInfo sectionInfoWithCaption:@"section 1" cells:cells1];

	cells2 = @[
			   [VSCellInfo cellInfoWithTitle:@"Cell 1/2" footerText:nil],
			   [VSCellInfo cellInfoWithTitle:@"Cell 2/2" footerText:@"Footer 1/2"],
			   [VSCellInfo cellInfoWithTitle:@"Cell 3/2" footerText:nil]
			   ];
	si2 = [VSSectionInfo sectionInfoWithCaption:@"section 2" cells:cells2];

	cells3 = @[
			   [VSCellInfo cellInfoWithTitle:@"Cell 1/3" footerText:nil],
			   [VSCellInfo cellInfoWithTitle:@"Cell 2/3" footerText:@"Footer 1/3"],
			   [VSCellInfo cellInfoWithTitle:@"Cell 3/3" footerText:nil],
			   [VSCellInfo cellInfoWithTitle:@"Cell 4/3" footerText:@"Footer 2/3"],
			   [VSCellInfo cellInfoWithTitle:@"Cell 5/3" footerText:nil]
			   ];
	si3 = [VSSectionInfo sectionInfoWithCaption:@"section 3" cells:cells3];

	self.sections = [NSMutableArray arrayWithArray:@[si1, si2, si3]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger subsection = 0;
	NSInteger realSection = 0;
	[self findSection:section outRealSection:&realSection outSubsection:&subsection];
	VSSectionInfo *si = self.sections[realSection];
	return [si rowsInSubsection:subsection];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger totalSections = 0;
	for (VSSectionInfo *si in self.sections)
	{
		totalSections += [si subsectionsCount];
	}
	return totalSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellId = @"just-a-cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

	NSInteger subsection = 0;
	NSInteger realSection = 0;
	[self findSection:indexPath.section outRealSection:&realSection outSubsection:&subsection];
	VSSectionInfo *si = self.sections[realSection];
	VSCellInfo *info = [si cellInfoForSubsection:subsection row:indexPath.row];

	cell.textLabel.text = info.title;
	cell.detailTextLabel.text = @"";

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSInteger subsection = 0;
	NSInteger realSection = 0;
	[self findSection:section outRealSection:&realSection outSubsection:&subsection];
	VSSectionInfo *si = self.sections[realSection];
	return [si titleForFooterInSubsection:subsection];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSInteger subsection = 0;
	NSInteger realSection = 0;
	[self findSection:section outRealSection:&realSection outSubsection:&subsection];
	VSSectionInfo *si = self.sections[realSection];
	if (subsection == 0)
	{
		return si.caption;
	}
	return nil;
}

#pragma mark - Private

- (void)findSection:(NSInteger)section outRealSection:(NSInteger *)realSection outSubsection:(NSInteger *)subsection
{
	VSSectionInfo *si = nil;
	NSInteger currentSection = 0;
	NSInteger totalSectionsBehind = 0;
	while (true)
	{
		si = self.sections[currentSection];
		totalSectionsBehind += [si subsectionsCount];
		if (totalSectionsBehind > section)
		{
			// base section found, searching for subsection...
			*subsection = section - (totalSectionsBehind - [si subsectionsCount]);
			*realSection = currentSection;
			break;
		}
		++currentSection;
	}
}

@end
