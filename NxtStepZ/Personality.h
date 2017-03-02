//
//  Personality.h
//  NxtStepZ
//
//  Created by Purushothaman on 22/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Personality : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * percentage;
@property (nonatomic, retain) NSNumber * order;

@end
