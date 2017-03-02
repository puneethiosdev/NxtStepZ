//
//  Post.h
//  NxtStepZ
//
//  Created by Purushothaman on 30/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * venue;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * to_tim;
@property (nonatomic, retain) NSString * to_date;
@property (nonatomic, retain) NSString * tagnames;
@property (nonatomic, retain) NSNumber * savedid;
@property (nonatomic, retain) NSNumber * savedflag;
@property (nonatomic, retain) NSString * profileimagename;
@property (nonatomic, retain) NSString * profile_title;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * post_type_name;
@property (nonatomic, retain) NSNumber * post_type_id;
@property (nonatomic, retain) NSString * post_title;
@property (nonatomic, retain) NSString * post_description;
@property (nonatomic, retain) NSNumber * num_followers;
@property (nonatomic, retain) NSNumber * likeid;
@property (nonatomic, retain) NSNumber * likeflag;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * imagename;
@property (nonatomic, retain) NSNumber * ids;
@property (nonatomic, retain) NSNumber * goingflag;
@property (nonatomic, retain) NSString * from_time;
@property (nonatomic, retain) NSString * from_date;
@property (nonatomic, retain) NSNumber * followflag;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSNumber * event_phone;
@property (nonatomic, retain) NSString * event_email;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * daysAgo;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * contact1;
@property (nonatomic, retain) NSString * company_college_name;
@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSString * category_name;

@end
