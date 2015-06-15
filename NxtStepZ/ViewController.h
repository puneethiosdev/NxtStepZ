//
//  ViewController.h
//  LoginPage
//
//  Created by Jinaraj on 1/27/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JASidePanelController;

@interface ViewController : UIViewController{
    
    IBOutlet UIButton *btn_login;
    IBOutlet UIButton *btn_reg;
    
}
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
- (IBAction)LoginButton:(id)sender;
- (IBAction)forgotPasswordButton:(id)sender;


- (IBAction)facebookButton:(id)sender;
- (IBAction)twitterButton:(id)sender;
- (IBAction)googleButton:(id)sender;
- (IBAction)linkedinButton:(id)sender;
- (IBAction)signUpButton:(id)sender;


@end

