//
//  VSCellInfo.m
//  TableWithFooters
//
//  Created by Valentine on 27.01.14.
//  Copyright (c) 2014 silvansky. All rights reserved.
//

#import "VSCellInfo.h"

@implementation VSCellInfo

+ (VSCellInfo *)cellInfoWithTitle:(NSString *)title footerText:(NSString *)footerText
{
	VSCellInfo *ci = [VSCellInfo new];
	ci.title = title;
	ci.footerText = footerText;
	return ci;
}

@end
