//
//  FinalResultController.m
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "FinalResultController.h"

@interface FinalResultController ()

@end

@implementation FinalResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Personality";
    
    TestResult *test = [TestResult MR_findFirst];
    
    if ([test.image length] == 0) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneParsing) name:@"doneParsing" object:nil];
        [self indicatorWithColor];

    }
    else
        [self calculationCompleted];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)indicatorWithColor{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Set the hud to display with a color
    HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    HUD.labelText = @"Calculating your score...";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    
    
    [self performSelector:@selector(postAnswers) withObject:nil afterDelay:0.5];
    
}

-(void)doneParsing{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"doneParsing" object:nil];
    
    [self performSelector:@selector(calculationCompleted) withObject:nil afterDelay:0.3];
    
}

-(void)calculationCompleted{
    
    TestResult *test = [TestResult MR_findFirst];
    
    [HUD hide:YES];
    img_personality.image = [UIImage imageWithContentsOfFile:[AppHelper loadImage:@"personality" andExtension:@"png"]];
    name.text = test.personality_name;
    type.text = test.personality_type;
    tag.text = test.tag;
    
    
}

-(void)postAnswers{
    
    NSArray *persArray = [PersonalityResult MR_findAll];
    
    for (PersonalityResult *pers in persArray){
    
        [postRequest postTestAnswers:pers.page andAnswers:pers.result andUserId:[[Login MR_findFirst] userId] andValue:pers.page];
    }
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
