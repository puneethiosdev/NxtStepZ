//
//  Login+Extension.m
//  NxtStepZ
//
//  Created by Jinaraj on 6/15/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Login+Extension.h"

@implementation Login (Extension)


+ (Login *) getByUserId:(NSString *)userId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"userId == \"%@\"", userId]];
    return (Login *)[[DBHelper getEntitiesByFetch:fetch] lastObject];
}


@end
