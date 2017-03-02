//
//  Album+Extension.m
//  NxtStepZ
//
//  Created by Purushothaman on 17/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "Album+Extension.h"
#import "DBHelper.h"

@implementation Album (Extension)

-(void)save{
    
    [DBHelper commit];
}

+(Album *)getByAlbumId :(NSNumber *)albumId{
    
    NSFetchRequest *fetch = [DBHelper getFetchRequest:[self class] :[NSString stringWithFormat:@"album_id == \"%@\"", albumId]];
    return  (Album *)[[Album MR_executeFetchRequest:fetch] lastObject];

}

@end
