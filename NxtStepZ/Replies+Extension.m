//
//  Replies+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 31/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Replies+Extension.h"
#import "DBHelper.h"


@implementation Replies (Extension)


+(NSArray *)getByCommentId :(NSNumber *)postTypeId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"comment_id == \"%@\"", postTypeId]];
    return  [Replies MR_executeFetchRequest:fetch];
}

+(NSArray *)getByPostId :(NSNumber *)postTypeId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"post_id == \"%@\"", postTypeId]];
    return  [Replies MR_executeFetchRequest:fetch];
}

-(void)save{
    
    [DBHelper commit];
    
}

@end
