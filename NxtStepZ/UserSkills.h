//
//  UserSkills.h
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserSkills : NSManagedObject

@property (nonatomic, retain) NSString * user_skills;
@property (nonatomic, retain) NSNumber * status;

@end
