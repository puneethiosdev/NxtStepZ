//
//  Replies.h
//  NxtStepZ
//
//  Created by Purushothaman on 31/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Replies : NSManagedObject

@property (nonatomic, retain) NSString * titles;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * replycount;
@property (nonatomic, retain) NSString * profile_image;
@property (nonatomic, retain) NSNumber * post_id;
@property (nonatomic, retain) NSNumber * parent_id;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * createdDate;
@property (nonatomic, retain) NSNumber * created_by;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSNumber * comment_id;

@end
