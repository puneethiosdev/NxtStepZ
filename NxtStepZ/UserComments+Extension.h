//
//  UserComments+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 01/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "UserComments.h"
#import "DBHelper.h"
#import <MagicalRecord/MagicalRecord.h>

@interface UserComments (Extension)

+(NSArray *)getByCommentId :(NSNumber *)postTypeId;
+(NSArray *)getByPostId :(NSNumber *)postTypeId;

-(void)save;

@end
