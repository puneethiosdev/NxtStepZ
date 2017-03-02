//
//  Replies+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 31/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Replies.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Replies (Extension)

+(NSArray *)getByCommentId :(NSNumber *)postTypeId;
+(NSArray *)getByPostId :(NSNumber *)postTypeId;
-(void)save;

@end
