//
//  AlbumDetails+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "AlbumDetails+Extension.h"
#import "DBHelper.h"

@implementation AlbumDetails (Extension)

-(void)save{
    
    [DBHelper commit];
}


@end
