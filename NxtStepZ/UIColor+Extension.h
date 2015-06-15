//
//  UIColor+Extension.h
//  FieldEZ
//
//  Created by FieldEZ Technologies Pvt Ltd on 09/12/13.
//  Copyright (c) 2013 FieldEZ Technologies Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;


@end
