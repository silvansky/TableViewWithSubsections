//
//  VSSectionInfo.h
//  TableWithFooters
//
//  Created by Valentine on 23.01.14.
//  Copyright (c) 2014 silvansky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSCellInfo;

@interface VSSectionInfo : NSObject

@property NSString *caption;

+ (VSSectionInfo *)sectionInfoWithCaption:(NSString *)caption cells:(NSArray *)cells;

- (NSInteger)subsectionsCount;
- (NSInteger)rows;
- (NSInteger)rowsInSubsection:(NSInteger)subsection;
- (NSInteger)subsectionForRow:(NSInteger)row;
- (VSCellInfo *)cellInfoForSubsection:(NSInteger)subsection row:(NSInteger)row;
- (NSString *)titleForFooterInSubsection:(NSInteger)subsection;

@end
