//
//  NSString+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (NSDate *) dateValue {
    return [self dateValue:@"MM/dd/yyyy HH:mm:ss"];
}
- (NSDate *) dateValue: (NSString *)formatName {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:formatName];
    
    return [dateFormatter dateFromString:self];
}

@end
