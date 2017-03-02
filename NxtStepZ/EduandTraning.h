//
//  EduandTraning.h
//  NxtStepZ
//
//  Created by Purushothaman on 06/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EduandTraning : NSManagedObject

@property (nonatomic, retain) NSString * branch;
@property (nonatomic, retain) NSString * degree_name;
@property (nonatomic, retain) NSNumber * fld_id;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * university_name;
@property (nonatomic, retain) NSString * years;
@property (nonatomic, retain) NSString * syncStatus;

@end
