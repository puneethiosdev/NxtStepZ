//
//  MEExpandableHeaderView.m
//  Expandable Header View
//
//  Created by Pablo Romero on 6/12/14.
//  Copyright (c) 2014 Microeditionbiz. All rights reserved.
//

#import "MEExpandableHeaderView.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/QuartzCore.h>

@interface MEExpandableHeaderView()<UIScrollViewDelegate>

@property(nonatomic, strong) UIImage *originalImage;
@property(nonatomic, assign) CGPoint previousContentOffset;
@property(nonatomic, assign) CGFloat originalHeight;

@property(nonatomic, strong, readwrite) UIImageView *backgroundImageView;
@property(nonatomic, strong, readwrite) UIScrollView *pagesScrollView;
@property(nonatomic, strong, readwrite) UIPageControl *pageControl;
@property(nonatomic, strong) NSString *originalImageString;

@end

@implementation MEExpandableHeaderView

#pragma mark - NSObject Lifecycle

- (id)initWithSize:(CGSize)size
   backgroundImage:(NSString*)imageString
      contentPages:(NSArray*)contentPages
{
   // assert(image != nil && [image isKindOfClass:[UIImage class]]);
   // assert(pages == nil || [pages isKindOfClass:[NSArray class]]);
    
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self)
    {
        _originalHeight = size.height;
        _originalImageString = imageString;
        _previousContentOffset = CGPointZero;
        
        [self setupBackgroundView];
       // [self setupPages:contentPages];
       // [self setupPageControl:[contentPages count]];
    }
    return self;
}

#pragma mark - Setup

- (void)setupBackgroundView
{
    assert(!self.backgroundImageView);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.bounds;
    
    
    NSLog(@"self.originalImageString %@",self.originalImageString);
    
    
    __block UIActivityIndicatorView *activityIndicators;
    __weak UIImageView *weakImageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.originalImageString]
                          placeholderImage:nil
                                   options:SDWebImageProgressiveDownload
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                      if (!activityIndicators) {
                                          [weakImageView addSubview:activityIndicators = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                          activityIndicators.center = weakImageView.center;
                                          [activityIndicators startAnimating];
                                      }
                                  }
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     [activityIndicators removeFromSuperview];
                                     activityIndicators = nil;
                                     
                                     if (image == nil) {
                                         
                                        // cell.image_profile.image = [UIImage imageNamed:@"no_img.png"];
                                         
                                     }
                                     else{
                                         self.originalImage = [self imageWithImage:image scaledToSize:CGSizeMake(320, 200)];
                                         imageView.image = self.originalImage;
                                     }
                                     
                                 }];

    
    imageView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:imageView];
    self.backgroundImageView = imageView;
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setupPages:(NSArray*)pages
{
    assert(!self.pagesScrollView);
    
    UIScrollView *pagesScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
  
    [pagesScrollView setDelegate:self];
    [pagesScrollView setPagingEnabled:YES];
    [pagesScrollView setShowsHorizontalScrollIndicator:NO];
    [pagesScrollView setShowsVerticalScrollIndicator:NO];
    
    CGFloat posX = 0.0;
    
    for (UIView *page in pages)
    {
        assert([page isKindOfClass:[UIView class]]);
        
        page.center = CGPointMake(posX + self.bounds.size.width/2.0,
                                  self.bounds.size.height/2.0);
        
        [pagesScrollView addSubview:page];
        
        posX += self.bounds.size.width;
    }
    
    [pagesScrollView setContentSize:CGSizeMake(posX, self.bounds.size.height)];
    
    [self addSubview:pagesScrollView];
    self.pagesScrollView = pagesScrollView;

}

- (void)setupPageControl:(NSUInteger)pagesCount
{
    assert(!self.pageControl);
    
    if (pagesCount > 1)
    {
        static CGFloat const kPageControlPadding = 7.0;
        static CGRect const kPageControlDefaultFrame = {0, 0, 20, 20};
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:kPageControlDefaultFrame];
        
        [pageControl addTarget:self
                        action:@selector(pageControlChanged)
              forControlEvents:UIControlEventValueChanged];
        
        [pageControl setNumberOfPages:pagesCount];
        [pageControl setCurrentPage:0];
   
        UIColor *backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [pageControl setBackgroundColor:backgroundColor];
        
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:pagesCount];
      
        pageControl.frame = CGRectMake((self.bounds.size.width-pageControlSize.width)/2.0,
                                       self.bounds.size.height-(pageControl.frame.size.height+kPageControlPadding),
                                       pageControlSize.width+kPageControlPadding*2,
                                       pageControl.frame.size.height);
        
        pageControl.layer.cornerRadius = pageControl.frame.size.height/2.0;
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
}

#pragma mark - Actions

- (void)pageControlChanged
{
    assert([self.pagesScrollView isKindOfClass:[UIScrollView class]]);
    
    CGPoint newOffset = CGPointMake(self.bounds.size.width * self.pageControl.currentPage, 0);
	[self.pagesScrollView setContentOffset:newOffset
                                  animated:YES];
	
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self scrollViewDidEndScrolling:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrolling:scrollView];
}

- (void)scrollViewDidEndScrolling:(UIScrollView *)scrollView
{
    if (scrollView == self.pagesScrollView)
    {
        assert([self.pageControl isKindOfClass:[UIPageControl class]]);

        NSUInteger currentPage = scrollView.contentOffset.x / self.bounds.size.width;
        [self.pageControl setCurrentPage:currentPage];
    }
}

#pragma mark - Public

- (void)offsetDidUpdate:(CGPoint)newOffset
{
    if (newOffset.y <= 0)
    {
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0, newOffset.y/2.0);
        
        CGFloat scaleFactor = (self.originalHeight - newOffset.y) / self.originalHeight;
        
        CGAffineTransform translateAndZoom = CGAffineTransformScale(translate, scaleFactor, scaleFactor);
        
        float radius = -newOffset.y/40.0;
        self.backgroundImageView.image = [self.originalImage applyBlurWithRadius:radius
                                                                        tintColor:nil
                                                            saturationDeltaFactor:1.0
                                                                        maskImage:nil];
        self.backgroundImageView.transform = translateAndZoom;
        self.pagesScrollView.transform = translate;
    }
    
    self.previousContentOffset = newOffset;
}

@end
