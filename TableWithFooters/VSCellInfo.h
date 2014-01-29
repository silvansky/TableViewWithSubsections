//
//  VSCellInfo.h
//  TableWithFooters
//
//  Created by Valentine on 27.01.14.
//  Copyright (c) 2014 silvansky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSCellInfo : NSObject

@property NSString *title;
@property NSString *footerText;

+ (VSCellInfo *)cellInfoWithTitle:(NSString *)title footerText:(NSString *)footerText;

@end
