//
//  RecipeCollectionViewController.m
//  RecipePhoto
//
//  Created by Simon on 13/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "GalleryDetails.h"

@interface GalleryDetails () {
    NSArray *recipeImages;
}

@end

@implementation GalleryDetails
@synthesize albumId;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Initialize recipe image array
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAlbum) name:@"ReloadAlbum" object:nil];
    
    recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [postRequest getAlbumDetails:self.albumId];
    



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[AlbumDetails MR_findAll] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.tag = indexPath.section;
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
//    [tapRecognizer addTarget:self action:@selector(cellTapped:)];
//    [cell addGestureRecognizer:tapRecognizer];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
  //  recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    __block UIActivityIndicatorView *activityIndicator;
    __weak UIImageView *weakImageView = recipeImageView;
    [recipeImageView sd_setImageWithURL:[NSURL URLWithString:[[[AlbumDetails MR_findAll] objectAtIndex:indexPath.row] imageUrl]]
                      placeholderImage:nil
                               options:SDWebImageProgressiveDownload
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  if (!activityIndicator) {
                                      [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                      activityIndicator.center = weakImageView.center;
                                      [activityIndicator startAnimating];
                                  }
                              }
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [activityIndicator removeFromSuperview];
                                 activityIndicator = nil;
                                 
                                 recipeImageView.image = image;
                             }];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    imageUrl = [[[AlbumDetails MR_findAll] objectAtIndex:indexPath.row] imageUrl];
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    imageInfo.imageURL = [NSURL URLWithString:imageUrl];
    
    //    imageInfo.referenceRect = cell.frame;
    //    imageInfo.referenceView = cell.superview;
    //    imageInfo.referenceContentMode = cell.contentMode;
    //    imageInfo.referenceCornerRadius = cell.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}
- (void)cellTapped:(id)sender {
    
    
  //  UICollectionViewCell *cell = (UICollectionViewCell *)sender;
   
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];

    imageInfo.imageURL = [NSURL URLWithString:imageUrl];

//    imageInfo.referenceRect = cell.frame;
//    imageInfo.referenceView = cell.superview;
//    imageInfo.referenceContentMode = cell.contentMode;
//    imageInfo.referenceCornerRadius = cell.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}


-(void)reloadAlbum{
    
    NSLog(@"Total count %lu",(unsigned long)[[AlbumDetails MR_findAll] count]);
    
    [self.collectionView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadAlbum" object:nil];
    
}

@end
