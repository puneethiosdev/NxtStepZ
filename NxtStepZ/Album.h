//
//  Album.h
//  NxtStepZ
//
//  Created by Purushothaman on 17/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * album_name;
@property (nonatomic, retain) NSNumber * album_id;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSNumber * image_id;

@end
