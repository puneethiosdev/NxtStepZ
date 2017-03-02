//
//  postViewController.m
//  NxtStepZ
//
//  Created by Purushothaman on 17/08/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "postViewController.h"

@interface postViewController ()

@end

@implementation postViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(userPost)];
    self.navigationItem.rightBarButtonItem = bar;
    
}

-(void)userPost{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
