//
//  TestResult.h
//  NxtStepZ
//
//  Created by Purushothaman on 24/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestResult : NSManagedObject

@property (nonatomic, retain) NSNumber * currentPage;
@property (nonatomic, retain) NSNumber * percentage;
@property (nonatomic, retain) NSNumber * test_completion;
@property (nonatomic, retain) NSString * personality_type;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * personality_name;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * status;

@end
