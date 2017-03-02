//
//  JobTypes.h
//  NxtStepZ
//
//  Created by Purushothaman on 06/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface JobTypes : NSManagedObject

@property (nonatomic, retain) NSString * job_types;
@property (nonatomic, retain) NSString * syncStatus;

@end
