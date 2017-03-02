//
//  Profile.h
//  NxtStepZ
//
//  Created by Purushothaman on 06/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * areaofinterest;
@property (nonatomic, retain) NSNumber * areaofinterestid;
@property (nonatomic, retain) NSString * companyOrcollege;
@property (nonatomic, retain) NSDate * dob;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSNumber * marital_status;
@property (nonatomic, retain) NSNumber * phno;
@property (nonatomic, retain) NSString * profile_description;
@property (nonatomic, retain) NSString * profile_image;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * syncStatus;

@end
