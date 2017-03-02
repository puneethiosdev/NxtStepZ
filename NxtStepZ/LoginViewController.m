//
//  ViewController.m
//  LoginPage
//
//  Created by Jinaraj on 1/27/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "LoginViewController.h"
#import "Registration.h"
//#import "MenuViewController.h"
//#import "Profile.h"
#import "SlideMenuTableViewController.h"
#import "JASidePanelController.h"
#import "homeViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    if ([self.userName.text length] == 0 && [self.userPassword.text length] == 0) {
        
        [AppHelper alert:@"Please enter user name and password"];

    }
    else if ([self.userName.text length] == 0) {
        
        [AppHelper alert:@"User name is mandatory"];
        
    }
    else if ([self.userPassword.text length] == 0) {
        
        [AppHelper alert:@"Password is mandatory"];
        
    }
    
    else{
        
        NSArray *resultArray = [WSHelper syncRequest:[NSString stringWithFormat:@"http://beta.nxtstepz.com/webservice/webservice.php?oper=checklogin&username=%@&password=%@",self.userName.text,self.userPassword.text]];
        NSDictionary *resultDict = (NSDictionary*)resultArray;
        NSLog(@"result dict %@",resultDict);
        NSString *str = [resultDict objectForKey:@"status"];
        
        if ([[NSNumber numberWithInt:[str intValue]] isEqualToNumber:[NSNumber numberWithInt:0]])
        {
    
            [AppHelper alertWithTitle:@"Login Failed" :@"Invalid login" :^{
                
            }];
        }
        else{
            
            
            Login *log = [Login MR_createEntity];
            log.firstName  = [[resultDict objectForKey:@"firstname"] isEqual:[NSNull null]] ? @"" : [resultDict objectForKey:@"firstname"];
            log.profile_image  = [[resultDict objectForKey:@"profile_image"] isEqual:[NSNull null]] ? @"" : [resultDict objectForKey:@"profile_image"];

            log.lastName  = [[resultDict objectForKey:@"lastName"] isEqual:[NSNull null]] ? @"" : [resultDict objectForKey:@"lastName"];

            log.gender = [[resultDict objectForKey:@"gender"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[resultDict objectForKey:@"gender"] intValue]];
            log.profileId = [[resultDict objectForKey:@"profile_id"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[resultDict objectForKey:@"profile_id"] intValue]];
            log.status = [[resultDict objectForKey:@"status"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[resultDict objectForKey:@"status"] intValue]];
            log.userId = [[resultDict objectForKey:@"userid"] isEqual:[NSNull null]] ? [NSNumber numberWithInt:0] :  [NSNumber numberWithInt:[[resultDict objectForKey:@"userid"] intValue]];
            log.password = self.userPassword.text;
            [AppHelper setUserId:[resultDict objectForKey:@"userid"]];
            
            //For getting profile details
            
            NSNumber *userId = [[Login MR_findFirst] userId];
            
            [postRequest getProfileDetails:userId];
            [postRequest getAdditionalProfile:userId];
            [postRequest getAlbumList:userId];
            [postRequest getProfileScoreDetails:userId];
            [postRequest getFollowList:userId];
            [postRequest getFollowerList:userId];
            [postRequest getProfileScore:userId];

            
            
            

            // Navigate to home screen
            
            [self navigateToHomeScreen];
            
        }
       
    }

    
  //  http://nxtstepz.com/webservice/webservice.php?oper=checklogin&username=srdidh@di.cm&password=123456
    
    
    
}

-(void)navigateToHomeScreen{
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Profile
    MainViewController *profileScreen=[storyBoard instantiateViewControllerWithIdentifier:@"Home"];
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
