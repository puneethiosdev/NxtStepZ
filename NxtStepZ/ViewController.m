//
//  ViewController.m
//  LoginPage
//
//  Created by Jinaraj on 1/27/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ViewController.h"
#import "Registration.h"
#import "MenuViewController.h"
#import "Profile.h"
#import "SlideMenuTableViewController.h"
#import "JASidePanelController.h"

#import "homeViewController.h"






@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    btn_login.layer.shadowOffset = CGSizeMake(0, 3);
    btn_login.layer.shadowRadius = 5.0;
    btn_login.layer.shadowColor = [UIColor blueColor].CGColor;
    // globalDatePicker.layer.shadowOpacity = 0.5;
    btn_login.layer.cornerRadius = 10.0;
    btn_login.layer.borderColor = [UIColor whiteColor].CGColor;//[UIColor colorWithHex:@"#2a6dbb" alpha:1.0].CGColor;
    btn_login.layer.borderWidth = 3.0;
    btn_login.layer.masksToBounds = YES;
    
    
    btn_reg.layer.shadowOffset = CGSizeMake(0, 3);
    btn_reg.layer.shadowRadius = 5.0;
    btn_reg.layer.shadowColor = [UIColor blueColor].CGColor;
    // globalDatePicker.layer.shadowOpacity = 0.5;
    btn_reg.layer.cornerRadius = 15.0;
    btn_reg.layer.borderColor = [UIColor whiteColor].CGColor;//[UIColor colorWithHex:@"#2a6dbb" alpha:1.0].CGColor;
    btn_reg.layer.borderWidth = 3.0;
    btn_reg.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButton:(id)sender {
    
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // Profile
    homeViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];
    SlideMenuTableViewController *leftMenu=[[SlideMenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:profileScreen];
    

    JASidePanelController* viewController = [[JASidePanelController alloc] init];
    viewController .shouldDelegateAutorotateToVisiblePanel = NO;
    viewController .leftPanel = leftMenu;
    viewController .centerPanel =frontNavigationController;
    
    
   // [self.navigationController pushViewController:mainRevealController animated:YES];

   [self presentViewController:viewController  animated:YES completion:nil];


    
}

- (IBAction)forgotPasswordButton:(id)sender {
}

- (IBAction)facebookButton:(id)sender {
}

- (IBAction)twitterButton:(id)sender {
}

- (IBAction)googleButton:(id)sender {
}

- (IBAction)linkedinButton:(id)sender {
}

- (IBAction)signUpButton:(id)sender {
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Registration *registerVC=[storyBoard instantiateViewControllerWithIdentifier:@"registration"];
    UINavigationController *registerNav=[[UINavigationController alloc]initWithRootViewController:registerVC];
    
    [self presentViewController:registerNav animated:YES completion:nil];
}
@end
