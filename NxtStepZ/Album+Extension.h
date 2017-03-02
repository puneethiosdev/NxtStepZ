//
//  Album+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 17/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Album.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Album (Extension)

-(void)save;
+(Album *)getByAlbumId :(NSNumber *)albumId;

@end
