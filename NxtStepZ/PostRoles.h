//
//  PostRoles.h
//  NxtStepZ
//
//  Created by Purushothaman on 02/08/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PostRoles : NSManagedObject

@property (nonatomic, retain) NSNumber * post_id;
@property (nonatomic, retain) NSString * roles;

@end
