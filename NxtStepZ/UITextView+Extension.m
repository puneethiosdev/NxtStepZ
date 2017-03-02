//
//  UITextView+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 05/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

static NSMutableDictionary *sections;

-(void)setSection:(NSNumber *)section
{
    if (sections == nil) {
        sections = [NSMutableDictionary dictionary];
    }
    [sections setObject:section forKey:[NSNumber numberWithUnsignedInteger:self.hash]];
    
}

- (NSNumber *) section {
    if (sections == nil) {
        sections = [NSMutableDictionary dictionary];
    }
    return (NSNumber *)[sections objectForKey:[NSNumber numberWithUnsignedInteger:self.hash]];
}




@end
