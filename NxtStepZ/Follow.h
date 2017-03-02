//
//  Follow.h
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Follow : NSManagedObject

@property (nonatomic, retain) NSNumber * userid;
@property (nonatomic, retain) NSString * titles;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * follower;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSNumber * follow;

@end
