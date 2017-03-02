//
//  Post+Extension.m
//  NxtStepZ
//
//  Created by Jinaraj on 6/18/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Post+Extension.h"

@implementation Post (Extension)

+(NSArray *)getByPostTypeId :(NSNumber *)postTypeId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"post_type_id == \"%@\"", postTypeId]];
   return  [Post MR_executeFetchRequest:fetch];

}

+(Post *)getByPostId :(NSNumber *)postId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"ids == \"%@\"", postId]];
    return  (Post*)[[Post MR_executeFetchRequest:fetch] lastObject];
    
}

-(void)save{
    
    [DBHelper commit];
    
}


@end
