//
//  BHCollectionViewController.m
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import "ImageGallery.h"
#import "BHPhotoAlbumLayout.h"
#import "BHAlbumPhotoCell.h"
#import "BHAlbum.h"
#import "BHPhoto.h"
#import "BHAlbumTitleReusableView.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";
static NSString * const AlbumTitleIdentifier = @"AlbumTitle";

@interface ImageGallery ()

@property (nonatomic, strong) NSMutableArray *albums;
@property (nonatomic, weak) IBOutlet BHPhotoAlbumLayout *photoAlbumLayout;
@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;

@end

@implementation ImageGallery

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Gallery";
    
    UIImage *patternImage = [UIImage imageNamed:@"concrete_wall"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    self.albums = [NSMutableArray array];

    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/ShadoFlameX/PhotoCollectionView/master/Photos/"];
	
    NSInteger photoIndex = 0;
    
    for (Album *alb in [Album MR_findAll]) {
        
        BHAlbum *album = [[BHAlbum alloc] init];
        album.name = alb.album_name;
        
        NSUInteger photoCount = arc4random()%4 + 2;
        for (NSInteger p = 0; p < photoCount; p++) {
            // there are up to 25 photos available to load from the code repository
            //NSString *photoFilename = [NSString stringWithFormat:@"thumbnail%d.jpg",photoIndex % 25];
            NSURL *photoURL = [NSURL URLWithString:alb.imageUrl];//[urlPrefix URLByAppendingPathComponent:photoFilename];
            BHPhoto *photo = [BHPhoto photoWithImageURL:photoURL];
            [album addPhoto:photo];
            
            photoIndex++;
        }
        
        [self.albums addObject:album];
    }
    
    [self.collectionView registerClass:[BHAlbumPhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    [self.collectionView registerClass:[BHAlbumTitleReusableView class]
            forSupplementaryViewOfKind:BHPhotoAlbumLayoutAlbumTitleKind
                   withReuseIdentifier:AlbumTitleIdentifier];
    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.photoAlbumLayout.numberOfColumns = 3;
        
        // handle insets for iPhone 4 or 5
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ?
                            45.0f : 25.0f;
        
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
        
    } else {
        self.photoAlbumLayout.numberOfColumns = 2;
        self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.albums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BHAlbum *album = self.albums[section];
    
    return album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BHAlbumPhotoCell *photoCell =
        [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                                  forIndexPath:indexPath];
    
    BHAlbum *album = self.albums[indexPath.section];
    BHPhoto *photo = album.photos[indexPath.item];
    
    // load photo images in the background
    __weak ImageGallery *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *image = [photo image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                BHAlbumPhotoCell *cell =
                    (BHAlbumPhotoCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                cell.imageView.image = image;
            }
        });
    }];
    
    operation.queuePriority = (indexPath.item == 0) ?
        NSOperationQueuePriorityHigh : NSOperationQueuePriorityNormal;
    
    [self.thumbnailQueue addOperation:operation];

    return photoCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath;
{
    BHAlbumTitleReusableView *titleView =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:AlbumTitleIdentifier
                                                  forIndexPath:indexPath];
    
    BHAlbum *album = self.albums[indexPath.section];
    
    titleView.titleLabel.text = album.name;
    
    return titleView;
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Album id is %@",[[[Album MR_findAll] objectAtIndex:indexPath.row] album_id]);
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GalleryDetails *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GalleryDetail"];
    proj.title = [[[Album MR_findAll] objectAtIndex:indexPath.section] album_name];
    proj.albumId = [[[Album MR_findAll] objectAtIndex:indexPath.section] album_id];
    [self.navigationController pushViewController:proj animated:YES];

}
@end
