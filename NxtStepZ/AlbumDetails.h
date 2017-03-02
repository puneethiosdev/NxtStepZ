//
//  AlbumDetails.h
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AlbumDetails : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSNumber * image_id;

@end
