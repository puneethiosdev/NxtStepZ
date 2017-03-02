//
//  Projects+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Projects+Extension.h"

@implementation Projects (Extension)


+(Projects *)getByProjectId :(NSNumber *)project_id{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"project_id == \"%@\"", project_id]];
    return  (Projects *)[[Projects MR_executeFetchRequest:fetch] lastObject];
}

-(void)save{
    
    [DBHelper commit];
}


@end
