//
//  Follow+Extension.h
//  NxtStepZ
//
//  Created by Purushothaman on 25/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Follow.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Follow (Extension)


+(Follow *)getByUSerId :(NSNumber *)albumId;
-(void)save;

@end
