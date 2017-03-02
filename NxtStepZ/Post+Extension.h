//
//  Post+Extension.h
//  NxtStepZ
//
//  Created by Jinaraj on 6/18/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Post.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Post (Extension)

+(NSArray *)getByPostTypeId :(NSNumber *)postTypeId;
+(Post *)getByPostId :(NSNumber *)postId;
-(void)save;


@end
