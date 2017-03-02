//
//  UserComments+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "UserComments+Extension.h"

@implementation UserComments (Extension)



+(NSArray *)getByCommentId :(NSNumber *)postTypeId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"comment_id == \"%@\"", postTypeId]];
    return  [UserComments MR_executeFetchRequest:fetch];
}

+(NSArray *)getByPostId :(NSNumber *)postTypeId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"post_id == \"%@\"", postTypeId]];
    return  [UserComments MR_executeFetchRequest:fetch];
}

-(void)save{
    
    [DBHelper commit];
    
}

@end
