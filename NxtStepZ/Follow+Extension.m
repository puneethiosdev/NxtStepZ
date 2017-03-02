//
//  Follow+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Follow+Extension.h"
#import "DBHelper.h"
@implementation Follow (Extension)


+(Follow *)getByUSerId :(NSNumber *)albumId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"userid == \"%@\"", albumId]];
    return  (Follow *)[[Follow MR_executeFetchRequest:fetch] lastObject];
}

-(void)save{
    
    [DBHelper commit];
}


@end
