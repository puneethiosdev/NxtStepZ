//
//  Profile+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Profile+Extension.h"

@implementation Profile (Extension)

+(NSArray *)getBySyncStatus :(NSString *)syncStatus{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"syncStatus == \"%@\"", syncStatus]];
    return  [Profile MR_executeFetchRequest:fetch];
    
}

-(void)save{
    
    [DBHelper commit];
}
@end
