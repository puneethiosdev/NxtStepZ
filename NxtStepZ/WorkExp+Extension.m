//
//  WorkExp+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "WorkExp+Extension.h"

@implementation WorkExp (Extension)


+(NSArray *)getBySyncStatus :(NSString *)syncStatus{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"syncStatus == \"%@\"", syncStatus]];
    return  [WorkExp MR_executeFetchRequest:fetch];
    
}

-(void)save{
    
    [DBHelper commit];
}

@end
