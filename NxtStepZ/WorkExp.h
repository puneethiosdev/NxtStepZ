//
//  WorkExp.h
//  NxtStepZ
//
//  Created by Purushothaman on 06/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WorkExp : NSManagedObject

@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSNumber * fld_id;
@property (nonatomic, retain) NSDate * fromdate;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * todate;
@property (nonatomic, retain) NSString * syncStatus;

@end
