//
//  AMViewController.m
//  TagListViewDemo
//
//  Created by Andrea Mazzini on 20/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "TagViewController.h"
#import "AMTagListView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TagViewController () <UITextFieldDelegate, UIAlertViewDelegate, AMTagListDelegate>{
    
    NSMutableArray *tagsArray;
    
}

@property (weak, nonatomic) IBOutlet UITextField    *textField;
@property (weak, nonatomic) IBOutlet AMTagListView	*tagListView;
@property (nonatomic, strong) AMTagView  *selection;

@end

@implementation TagViewController
@synthesize editArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setTitle:@"Demo"];
    
    tagsArray = [NSMutableArray new];
    
	
	[self.textField.layer setBorderColor:UIColorFromRGB(0x1f8dd6).CGColor];
	[self.textField.layer setBorderWidth:2];
	[self.textField setDelegate:self];
    
	[[AMTagView appearance] setTagLength:10];
	[[AMTagView appearance] setTextPadding:14];
	[[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
	[[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f8dd6)];
	

    for (NSString *str in editArray){
        
        [self.tagListView addTag:str];
        [tagsArray addObject:str];
        

    }
    
    
    
   // NSLog(@"tags %@",self.tagListView.tags);
    
//	[self.tagListView addTag:@"my tag"];
//    [self.tagListView addTag:@"something"];
//   // [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"close"]];
//    [self.tagListView addTag:@"long tag is long"];
//	[self.tagListView addTag:@"hi there"];
    
    
    self.tagListView.tagListDelegate = self;
	__weak TagViewController* weakSelf = self;
	[self.tagListView setTapHandler:^(AMTagView *view) {
		weakSelf.selection = view;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
														message:[NSString stringWithFormat:@"Delete %@?", [view tagText]]
													   delegate:weakSelf
											  cancelButtonTitle:@"Nope"
											  otherButtonTitles:@"Sure!", nil];
		[alert show];
	}];
}

- (BOOL)tagList:(AMTagListView *)tagListView shouldAddTagWithText:(NSString *)text resultingContentSize:(CGSize)size
{
    // Don't add a 'bad' tag
    return ![text isEqualToString:@"bad"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex > 0) {
		[self.tagListView removeTag:self.selection];
        [tagsArray removeObject:self.selection.tagText];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.tagListView addTag:textField.text];
    [tagsArray addObject:textField.text];
    
	[self.textField setText:@""];
	return YES;
}


-(IBAction)btn_save:(id)sender{
    
    
    [DBOperations updateProfile:tagsArray andSection:2];

    if (self.canceldelegate && [self.canceldelegate respondsToSelector:@selector(saveEdit:)]) {
        [self.canceldelegate saveEdit:self];
    }
}

-(IBAction)btn_cnacel:(id)sender{
    
    
   // NSLog(@"array value %@",tagsArray);
    
    if (self.canceldelegate && [self.canceldelegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.canceldelegate cancelButtonClicked:self];
    }
}
// Close the keyboard when the user taps away froma  textfield
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
    }
}

@end
