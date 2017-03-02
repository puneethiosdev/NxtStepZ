//
//  Login.h
//  NxtStepZ
//
//  Created by Jinaraj on 6/16/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Login : NSManagedObject

@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * profileId;
@property (nonatomic, retain) NSString * profile_image;
@property (nonatomic, retain) NSNumber * status;

@end
