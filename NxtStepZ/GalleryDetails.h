//
//  RecipeCollectionViewController.h
//  RecipePhoto
//
//  Created by Simon on 13/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "Album.h"
#import "Album+Extension.h"
#import "AlbumDetails+Extension.h"
#import "AlbumDetails.h"
#import "postRequest.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

@interface GalleryDetails : UICollectionViewController{
    
    IBOutlet UICollectionView *collection;
    
    NSString *imageUrl;
    
    
}

@property (nonatomic,strong)NSNumber *albumId;


+(void)reloadCollection;

@end
