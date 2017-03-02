//
//  PersonalityTest.m
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "PersonalityTest.h"

@interface BeginTest (Private)

- (CustomizationState)nextCustomizationState:(CustomizationState)state;
- (NSString*)buttonTextForState:(CustomizationState)state;
- (void)customizeAccordingToState:(CustomizationState)state;

@end

@implementation PersonalityTest

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
  
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    TestResult *test = [TestResult MR_findFirst];
    float flo = [test.percentage floatValue];
    [self customizeAccordingToState:CustomizationStateDefault];
    [_circleProgressBar setProgress:flo animated:YES];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    TestResult *test = [TestResult MR_findFirst];
    
    if(item.tag == 0){
        
        if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:5]]) {
            
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            FinalResultController *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Final"];
            [self.navigationController pushViewController:proj animated:YES];
  
        }
        else{
    
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            BeginTest *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Begin"];
            [self.navigationController pushViewController:proj animated:YES];

        }
        
    }
    else  if(item.tag == 1){
        
        UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProfileScore *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Score"];
        [self.navigationController pushViewController:proj animated:YES];
    }
}


- (void)customizeAccordingToState:(CustomizationState)state {
    BOOL customized = state != CustomizationStateDefault;
    
    // Progress Bar Customization
    [_circleProgressBar setProgressBarWidth:(customized ? 12.0f : 0)];
    [_circleProgressBar setProgressBarProgressColor:(customized ? [UIColor colorWithRed:0.2 green:0.7 blue:1.0 alpha:0.8] : nil)];
    [_circleProgressBar setProgressBarTrackColor:(customized ? [UIColor colorWithWhite:0.000 alpha:0.800] : nil)];
    
    // Hint View Customization
    [_circleProgressBar setHintViewSpacing:(customized ? 10.0f : 0)];
    [_circleProgressBar setHintViewBackgroundColor:(customized ? [UIColor colorWithWhite:1.000 alpha:0.800] : nil)];
    [_circleProgressBar setHintTextFont:(customized ? [UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:40.0f] : nil)];
    [_circleProgressBar setHintTextColor:(customized ? [UIColor blackColor] : nil)];
    [_circleProgressBar setHintTextGenerationBlock:(customized ? ^NSString *(CGFloat progress) {
        return [NSString stringWithFormat:@"%.0f / 255", progress * 255];
    } : nil)];
    
    // Attributed String
    [_circleProgressBar setHintAttributedGenerationBlock:(state == CustomizationStateCustomAttributed ? ^NSAttributedString *(CGFloat progress) {
        NSString *formatString = [NSString stringWithFormat:@"%.0f / 255", progress * 255];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:formatString];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:40.0f] range:NSMakeRange(0, string.length)];
        
        NSArray *components = [formatString componentsSeparatedByString:@"/"];
        UIColor *valueColor = [UIColor colorWithRed:(0.2f) green:(0.2f) blue:(0.5f + progress * 0.5f) alpha:1.0f];
        [string addAttribute:NSForegroundColorAttributeName value:valueColor range:NSMakeRange(0, [[components firstObject] length])];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([[components firstObject] length], 1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange([[components firstObject] length] + 1, [[components lastObject] length])];
        return string;
    } : nil)];
}

-(IBAction)btn_beginTest:(id)sender{
    
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BeginTest *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Begin"];
    [self.navigationController pushViewController:proj animated:YES];

}

@end
