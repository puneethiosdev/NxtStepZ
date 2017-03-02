//
//  Projects.h
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Projects : NSManagedObject

@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSDate * created_date;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * long_description;
@property (nonatomic, retain) NSNumber * project_id;
@property (nonatomic, retain) NSString * project_title;
@property (nonatomic, retain) NSNumber * project_type;
@property (nonatomic, retain) NSString * short_description;
@property (nonatomic, retain) NSString * skills_names;
@property (nonatomic, retain) NSNumber * status;

@end
