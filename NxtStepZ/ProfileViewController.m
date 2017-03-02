//
//  MGViewController.m
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "ProfileViewController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 150.0f
#define CELL_CONTENT_MARGIN 5.0f




@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize imagePath;

static BOOL isEditable;

- (void)viewDidLoad {
    [self setOverView:self.myOverView];
    
    
    arrayValues = [NSMutableArray new];
    
    self.delegate = self;
    
//    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEdit:)];
//    self.navigationItem.rightBarButtonItem = saveBtn;
    
    

    
    UIImage *faceImage = [UIImage imageNamed:@"ic_menu.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    [face addTarget:self action:@selector(showGridMenu:) forControlEvents:UIControlEventTouchUpInside];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    self.navigationItem.rightBarButtonItem = menuBtn;
    
}

- (UIView *)myOverView {
    UIView *view = [[UIView alloc] initWithFrame:self.overView.bounds];
    
    //Add an example imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(view.center.x-50.0, view.center.y-60.0, 100.0, 100.0)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    [imageView setImage:[UIImage imageWithContentsOfFile:self.imagePath]];
    [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [imageView.layer setBorderWidth:2.0];
    [imageView.layer setCornerRadius:imageView.frame.size.width/2.0];
    imageView.userInteractionEnabled = YES;
    
    //Add an example label
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(view.center.x-120.0, view.center.y+50.0, 240.0, 50.0)];
    [lblTitle setText:@"Name Surname"];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:25.0]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor whiteColor]];
    
    UIButton *btContact = [[UIButton alloc] initWithFrame:CGRectMake(view.center.x-35.0, view.center.y+100.0, 70.0, 35.0)];
    [btContact setTitle:@"Contact" forState:UIControlStateNormal];
    [btContact addTarget:self action:@selector(actionContact:) forControlEvents:UIControlEventTouchUpInside];
    btContact.backgroundColor = [UIColor darkGrayColor];
    btContact.titleLabel.font = [UIFont fontWithName:@"Verdana" size:12.0];
    btContact.layer.cornerRadius = 5.0;
    
    [view addSubview:imageView];
    [view addSubview:lblTitle];
    [view addSubview:btContact];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tapRecognizer];
    
    return view;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Grid Menu

- (IBAction)showGridMenu:(id)sender {
    
    CNPGridMenuItem *laterToday = [[CNPGridMenuItem alloc] init];
    laterToday.icon = [UIImage imageNamed:@"LaterToday"];
    laterToday.title = @"Projects";
    
    CNPGridMenuItem *thisEvening = [[CNPGridMenuItem alloc] init];
    thisEvening.icon = [UIImage imageNamed:@"ThisEvening"];
    thisEvening.title = @"Gallery";
    
    CNPGridMenuItem *tomorrow = [[CNPGridMenuItem alloc] init];
    tomorrow.icon = [UIImage imageNamed:@"Tomorrow"];
    tomorrow.title = @"Profile Score";
    
    CNPGridMenuItem *thisWeekend = [[CNPGridMenuItem alloc] init];
    thisWeekend.icon = [UIImage imageNamed:@"ThisWeekend"];
    thisWeekend.title = @"Peoples";
    
    CNPGridMenuItem *nextWeek = [[CNPGridMenuItem alloc] init];
    nextWeek.icon = [UIImage imageNamed:@"NextWeek"];
    nextWeek.title = @"Settings";
    
    
//    CNPGridMenuItem *pickDate = [[CNPGridMenuItem alloc] init];
//    pickDate.icon = [UIImage imageNamed:@"PickDate"];
//    pickDate.title = @"Pick Date";
    
    CNPGridMenu *gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[laterToday, thisEvening, tomorrow, thisWeekend, nextWeek]];
    gridMenu.delegate = self;
    [self presentGridMenu:gridMenu animated:YES completion:^{
        NSLog(@"Grid Menu Presented");   
    }];
}

- (void)gridMenuDidTapOnBackground:(CNPGridMenu *)menu {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Dismissed With Background Tap");
    }];
}

- (void)gridMenu:(CNPGridMenu *)menu didTapOnItem:(CNPGridMenuItem *)item {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Did Tap On Item: %@", item.title);
        
        if ([item.title isEqualToString:@"Projects"]) {
            
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProjectViewController *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"projectVC"];
             [self.navigationController pushViewController:proj animated:YES];
            
        }
        else  if ([item.title isEqualToString:@"Gallery"]) {
            
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ImageGallery *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Gallery"];
            [self.navigationController pushViewController:proj animated:YES];
            
        }
        
        else  if ([item.title isEqualToString:@"Profile Score"]) {
            
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PersonalityTest *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Test"];
            [self.navigationController pushViewController:proj animated:YES];

        }
        else  if ([item.title isEqualToString:@"Peoples"]) {
            
            UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PeoplesController *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"People"];
            [self.navigationController pushViewController:proj animated:YES];
        }
        
        
    }];
}

#pragma mark - UITableView Delegate & Datasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [super tableView:tableView viewForHeaderInSection:section];
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    return @"My Section";
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if(section == 0)
        return self.overView.frame.size.height;
    else
        return 40;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 6;
    }
   
    else if (section == 1 || section == 2 || section == 3) {
        
        return 1;
    }
    else if (section == 4){
        
        return [[EduandTraning MR_findAll] count];
    }
    else if (section == 5){
        
        return [[WorkExp MR_findAll] count];
    }
    else if (section == 6){
        
        return [[HonorsAwards MR_findAll] count];
    }
    
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellID";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:identifier];
    
    UILabel *label = nil,*label1 = nil;
    UITextView *txtView = nil,*txtView1 = nil,*txtView2 = nil;
    
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       // [cell setBackgroundColor:[UIColor darkGrayColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 150, 24)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label];
        
        
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 150, 24)];
        label1.font = [UIFont boldSystemFontOfSize:12];
        label1.textColor = [UIColor darkGrayColor];
        label1.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:label1];
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(165, 5,tableView.frame.size.width, 30)];
        txtView.font = [UIFont boldSystemFontOfSize:14];
        txtView.textColor = [UIColor blackColor];
        txtView.delegate = self;
        [cell.contentView addSubview:txtView];
        
        txtView1 = [[UITextView alloc] initWithFrame:CGRectMake(165, 5, tableView.frame.size.width, 30)];
        txtView1.font = [UIFont boldSystemFontOfSize:14];
        txtView1.textColor = [UIColor blackColor];
        txtView1.delegate = self;
        [cell.contentView addSubview:txtView1];
        txtView1.hidden = TRUE;
        
        txtView2 = [[UITextView alloc] initWithFrame:CGRectMake(165, 5, 150, 30)];
        txtView2.font = [UIFont boldSystemFontOfSize:14];
        txtView2.textColor = [UIColor blackColor];
        txtView2.delegate = self;
        [cell.contentView addSubview:txtView2];
        txtView2.hidden = TRUE;

    }
    NSString *text = @"";
    NSString *textForLabel = @"";
    NSString *textForLabel1 = @"";
    
    txtView.tag = indexPath.row;
    txtView1.tag = indexPath.row;

    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            label.text = @"Date Of Birth";
            txtView.text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] dob]];
            
            
        }else if (indexPath.row == 1) {
            
            label.text = @"Gender";
            txtView.text = [[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] gender]] isEqualToString:@"1"] ? @"Male" : @"Female";

            
        }else if (indexPath.row == 2) {
            
            label.text = @"Marital Status";
            txtView.text = [[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] marital_status]] isEqualToString:@"1"] ? @"Single" : @"Married";

            
        }else if (indexPath.row == 3) {
            
            label.text = @"Contact No";
            txtView.text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] phno]];

            
        }else if (indexPath.row == 4) {
            
            label.text = @"E-Mail Id";
            txtView.text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] email]];

            
        }else if (indexPath.row == 5) {
            
            label.text = @"Address";
            txtView.text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] address]];

            
        }
        textForLabel = label.text;
        text = txtView.text;


    }
    else if (indexPath.section == 1){
        
        txtView.frame = CGRectMake(5, 5, 300, 20);
        txtView.text = [[Profile MR_findFirst] profile_description];
        text = txtView.text;
        
    }
    else if (indexPath.section == 2){
        
        txtView.frame = CGRectMake(5, 5, 300, 20);
        txtView.text = [[Profile MR_findFirst] areaofinterest];
        text = txtView.text;

    }
    else if (indexPath.section == 3){
        
        NSArray *types = [[[JobTypes MR_findFirst] job_types] componentsSeparatedByString:@","];
        NSString *jobType = @"";
        
        for (NSString *strType in types){
            
            
            if ([strType isEqualToString:@"1"]) {
                
                
                jobType = [jobType stringByAppendingString:@"Full time,"];

            }else if ([strType isEqualToString:@"2"]) {
                
                jobType = [jobType stringByAppendingString:@"Part time,"];

                
            }else if ([strType isEqualToString:@"3"]) {
                
                jobType = [jobType stringByAppendingString:@"Internship,"];

            }else if ([strType isEqualToString:@"4"]) {
                
                jobType = [jobType stringByAppendingString:@"Volunteer,"];

            }else if ([strType isEqualToString:@"5"]) {
                
                jobType = [jobType stringByAppendingString:@"Contract,"];

            }else if ([strType isEqualToString:@"6"]) {
                
                jobType = [jobType stringByAppendingString:@"Temporary,"];

            }
            
        }
        
        jobType = [jobType substringToIndex:[jobType length]-1];

        txtView.frame = CGRectMake(5, 5, 300, 20);
        txtView.text = jobType;
        text = txtView.text;

    }
    else if (indexPath.section == 4){
        
        txtView.frame = CGRectMake(5, 5, 300, 20);
        
        txtView.text = [NSString stringWithFormat:@"%@ %@\n%@\n%@",[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] degree_name],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] years],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] branch],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] university_name]];
        text = txtView.text;

    }
    else if (indexPath.section == 5){
        
      //  label1.frame = CGRectMake(5, 20, 300, 20);
       // txtView.frame = CGRectMake(5, 35, 300, 20);

       // txtView1.tag = 100;

        txtView.text = [NSString stringWithFormat:@"%@",[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] title]];
        txtView1.text = [NSString stringWithFormat:@"From %@ To %@\n%@",[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] fromdate],[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] todate],[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] descriptions]];
        NSLog(@"%@",txtView1.text);
       // txtView.text = [[[WorkExp MR_findAll] objectAtIndex:indexPath.row] descriptions];
        textForLabel = txtView1.text;
        text = txtView.text;
    }
    else if (indexPath.section == 6){
        
       // txtView1.tag = 200;
        
        //  label1.frame = CGRectMake(5, 20, 300, 20);
        // txtView.frame = CGRectMake(5, 35, 300, 20);
        
        
        txtView.text = [NSString stringWithFormat:@"%@",[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] title]];
        txtView1.text = [NSString stringWithFormat:@"From %@ To %@\n%@",[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] fromdate],[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] todate],[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] descriptions]];
        // txtView.text = [[[WorkExp MR_findAll] objectAtIndex:indexPath.row] descriptions];
        textForLabel = txtView1.text;
        text = txtView.text;
        
        
    }
  
    txtView.editable = NO;
    txtView1.editable = NO;
    
//    if (selectedIndex == indexPath.section) {
//        
//        txtView.editable = isEditable;
//        txtView1.editable = isEditable;
//
//    }
//    else{
//        
//        txtView.editable = NO;
//        txtView1.editable = NO;
//
//
//    }
    
    
    
    CGSize cellSize ;
    cellSize.width = 320;

    
    
    CGSize constraint = CGSizeMake(cellSize.width - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize constraintForLabel = CGSizeMake(130 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [WordWrap text:text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraint];
    CGSize sizeForLabel = [WordWrap text:textForLabel sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
    CGSize sizeForLabel1 = [WordWrap text:textForLabel1 sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];

    [txtView setText:text];
    [label setText:textForLabel];
    [label1 setText:textForLabel];

    
    if (indexPath.section == 0) {
        
        [txtView setFrame:CGRectMake(150, 5, 150 - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 38.0f))];
        [label setFrame:CGRectMake(5, 5, 130 - (CELL_CONTENT_MARGIN * 2), MAX(sizeForLabel.height, 38.0f))];
        [label1 setFrame:CGRectMake(5, 5, 130 - (CELL_CONTENT_MARGIN * 2), MAX(sizeForLabel1.height, 38.0f))];

    }else  if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        
        [txtView setFrame:CGRectMake(5, -5, 315 - (CELL_CONTENT_MARGIN * 2), MAX(size.height+20, 38.0f))];
        
    }else if (indexPath.section == 5 || indexPath.section == 6) {
        
        
       CGSize constraintForLabel = CGSizeMake(txtView1.frame.size.width, 20000.0f);
        
        CGSize sizeForLabel = [WordWrap text:textForLabel sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
        CGSize sizeForTitle = [WordWrap text:text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(txtView.frame.size.width, 20000.0f)];
        

        txtView1.hidden = FALSE;
        
        [txtView setFrame:CGRectMake(2 ,2, txtView.frame.size.width, MAX(sizeForTitle.height, txtView.frame.size.height))];
        
        [txtView1 setFrame:CGRectMake(5, 35, txtView1.frame.size.width, MAX(sizeForLabel.height, 38.0f))];
       // [label1 setFrame:CGRectMake(5, 20, 315 - (CELL_CONTENT_MARGIN * 2), MAX(sizeForLabel1.height, 38.0f))];
        
    }
    

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = @"";
    NSString *textForLabel = @"";
    NSString *textForLabel1 = @"";
    
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            textForLabel = @"Date Of Birth";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] dob]];
            
            
        }else if (indexPath.row == 1) {
            
            textForLabel = @"Gender";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] gender]];
            
            
        }else if (indexPath.row == 2) {
            
            textForLabel= @"Marital Status";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] marital_status]];
            
            
        }else if (indexPath.row == 3) {
            
            textForLabel = @"Contact No";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] phno]];
            
            
        }else if (indexPath.row == 4) {
            
            textForLabel = @"E-Mail Id";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] email]];
            
            
        }else if (indexPath.row == 5) {
            
           textForLabel = @"Address";
            text = [NSString stringWithFormat:@"%@",[[Profile MR_findFirst] address]];
            
            
        }
       
        
        
    }
    else if (indexPath.section == 1){
        
        
        text = [[Profile MR_findFirst] profile_description];
        
    }
    else if (indexPath.section == 2){
        
        text = [[Profile MR_findFirst] areaofinterest];
        
    }
    else if (indexPath.section == 3){
        
        text = [[JobTypes MR_findFirst] job_types];

        
    }
    else if (indexPath.section == 4){
        
        text = [NSString stringWithFormat:@"%@ %@\n%@\n%@",[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] degree_name],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] years],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] branch],[[[EduandTraning MR_findAll] objectAtIndex:indexPath.row] university_name]];
        
    }
    else if (indexPath.section == 5){

        textForLabel = [[[WorkExp MR_findAll] objectAtIndex:indexPath.row] title];
        textForLabel1 = [NSString stringWithFormat:@"From %@ To %@",[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] fromdate],[[[WorkExp MR_findAll] objectAtIndex:indexPath.row] todate]];
        text = [[[WorkExp MR_findAll] objectAtIndex:indexPath.row] descriptions];
    }
    else if (indexPath.section == 6){
        
        textForLabel = [[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] title];
        textForLabel1 = [NSString stringWithFormat:@"From %@ To %@",[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] fromdate],[[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] todate]];
        text = [[[HonorsAwards MR_findAll] objectAtIndex:indexPath.row] descriptions];
    }
    
   
        CGSize cellSize ;
        cellSize.width = 320;
    
    CGSize sizeForValue,sizeForLabel,sizeForLabel1,sizeForCell;
    CGSize  constraintForValue = CGSizeMake(315 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize  constraintForLabel = CGSizeMake(130 - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    if (indexPath.section == 0) {
        
        
        sizeForValue = [WordWrap text:text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraintForValue];
        sizeForLabel = [WordWrap text:textForLabel sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
        sizeForLabel1 = [WordWrap text:textForLabel1 sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
    }
    else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        
        
        sizeForValue = [WordWrap text:text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraintForValue];
        sizeForValue.height = sizeForValue.height + 10;
//        sizeForLabel = [WordWrap text:textForLabel sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
//        sizeForLabel1 = [WordWrap text:textForLabel1 sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
    }
    else if (indexPath.section == 5 || indexPath.section == 6) {
        
        
        sizeForValue = [WordWrap text:text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraintForValue];
        sizeForLabel = [WordWrap text:textForLabel sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
        sizeForLabel1 = [WordWrap text:textForLabel1 sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraintForLabel];
        
        sizeForValue.height = sizeForLabel1.height + sizeForLabel.height + sizeForValue.height;
        
    }
        
    
    

    
        if (sizeForLabel.height >= sizeForValue.height) {
            
            sizeForCell = sizeForLabel;
        }
        else
            sizeForCell = sizeForValue;
        
        
        CGFloat height = MAX(sizeForCell.height, 38.0f);
        return height + (CELL_CONTENT_MARGIN * 2);

}
//- (void)textViewDidBeginEditing:(UITextView *)inView
//{
//    [self performSelector:@selector(setCursorToBeginning:) withObject:inView afterDelay:0.01];
//}
//
//- (void)setCursorToBeginning:(UITextView *)inView
//{
//    //you can change first parameter in NSMakeRange to wherever you want the cursor to move
//    inView.selectedRange = NSMakeRange(3, 0);
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *txtString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    

    [arrayValues replaceObjectAtIndex:textView.tag withObject:txtString];
    
    return YES;
    
}
#pragma mark - Action

- (void)cancelButtonClicked:(MJDetailViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
}


-(void)editButtonClicked :(id)index{
    
    UIButton *btn = (UIButton *)index;
    selectedIndex = (int)btn.tag;
    [self addDetails:selectedIndex];
    
    NSLog(@"button index is %d",(int)btn.tag);
    
}

-(void)openPopover : (NSArray *)edtArray andEditType:(NSString *)editType{
    
    if([editType isEqualToString:@"Area"]){
        
        TagViewController *detailViewController = [[TagViewController alloc] initWithNibName:@"TagViewController" bundle:nil];
        detailViewController.editArray = [edtArray mutableCopy];
        detailViewController.canceldelegate = self;
        [self presentPopupViewController:detailViewController animationType:1];
 
    }
    else{
        
        MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
        detailViewController.editArray = [edtArray mutableCopy];
        detailViewController.editType = editType;
        detailViewController.canceldelegate = self;
        [self presentPopupViewController:detailViewController animationType:1];

    }
        
    
}
-(void)addDetails :(int)section{
    
    [arrayValues removeAllObjects];
    
    if (section == 0) {

        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] dob]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] gender]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] marital_status]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] phno]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] email]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] address]]];

        [self openPopover:nil andEditType:@"Personal"];

    }
    
    else if (section == 1 || section == 2 || section == 3) {
        
        if (section == 1){
         
            [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] profile_description]]];
            [self openPopover:nil andEditType:@"About me"];

        }
        if (section == 2){
            
            [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] areaofinterest]]];
            [self openPopover:[[[Profile MR_findFirst] areaofinterest] componentsSeparatedByString:@","] andEditType:@"Area"];

        }
        if (section == 3){
            
            [arrayValues addObject:[NSString stringWithFormat:@"%@",[[JobTypes MR_findFirst] job_types]]];
            [self openPopover:[[[JobTypes MR_findFirst] job_types] componentsSeparatedByString:@","] andEditType:@"JobType"];

        }

        
    }
    else if (section == 4){
        
        for (int i = 0; i<[[EduandTraning MR_findAll] count]; i++) {
            
            [arrayValues addObject:[NSString stringWithFormat:@"%@ %@\n%@\n%@",[[[EduandTraning MR_findAll] objectAtIndex:i] degree_name],[[[EduandTraning MR_findAll] objectAtIndex:i] years],[[[EduandTraning MR_findAll] objectAtIndex:i] branch],[[[EduandTraning MR_findAll] objectAtIndex:i] university_name]]];
            
        }
        
        [self openPopover:[EduandTraning MR_findAll] andEditType:@"EduTraning"];

    }
    else if (section == 5){
        
        for (int i = 0; i<[[WorkExp MR_findAll] count]; i++) {
            
            [arrayValues addObject:[NSString stringWithFormat:@"%@",[[[WorkExp MR_findAll] objectAtIndex:i] title]]];
            [arrayValues addObject:[NSString stringWithFormat:@"From %@ To %@\n%@",[[[WorkExp MR_findAll] objectAtIndex:i] fromdate],[[[WorkExp MR_findAll] objectAtIndex:i] todate],[[[WorkExp MR_findAll] objectAtIndex:i] descriptions]]];
        }
        
        
        [self openPopover:[WorkExp MR_findAll] andEditType:@"WorkExp"];


    }
    else if (section == 6){
        
        
        for (int i = 0; i<[[HonorsAwards MR_findAll] count]; i++) {
            
           [arrayValues addObject:[NSString stringWithFormat:@"%@",[[[HonorsAwards MR_findAll] objectAtIndex:i] title]]];
            [arrayValues addObject:[NSString stringWithFormat:@"From %@ To %@\n%@",[[[HonorsAwards MR_findAll] objectAtIndex:i] fromdate],[[[HonorsAwards MR_findAll] objectAtIndex:i] todate],[[[HonorsAwards MR_findAll] objectAtIndex:i] descriptions]]];
            
        }
        
        [self openPopover:[HonorsAwards MR_findAll] andEditType:@"HonorsAwards"];

    }
    
}
-(void)reloadTable:(id)index{

    UIButton *btn = (UIButton *)index;
    NSLog(@"Reloading table %ld",(long)btn.tag);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void)saveEdit :(id)sender{
    
   
  //  [DBOperations updateProfile:arrayValues andSection:selectedIndex];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];

    [self.tableView reloadData];
    
    [self performSelector:@selector(sendEditedPost) withObject:nil afterDelay:0.5];
    
    NSLog(@"saved successfully %@",arrayValues);
    
}
-(void)sendEditedPost{
    
    if (selectedIndex == 0 || selectedIndex == 1  || selectedIndex == 2  || selectedIndex == 3) {
        
        [postRequest postEditedProfile:[[Login MR_findFirst] userId] andProfileObj:[Profile MR_findFirst] andJobObj:[JobTypes MR_findFirst]];

    }
    else  if (selectedIndex == 4) {
        
        NSArray *eduArray = [EduandTraning getBySyncStatus:@"N"];
        
        for (EduandTraning *edu in eduArray){
            
            [postRequest postEditedAdditionalProfile:[[Login MR_findFirst] userId] andEduObj:edu andWorkObj:nil andHonorObj:nil];
        }
    }
    else  if (selectedIndex == 5) {
        
        NSArray *eduArray = [WorkExp getBySyncStatus:@"N"];
        
        for (WorkExp *work in eduArray){
            
            [postRequest postEditedAdditionalProfile:[[Login MR_findFirst] userId] andEduObj:nil andWorkObj:work andHonorObj:nil];
        }
    }

    else  if (selectedIndex == 6) {
        
        NSArray *eduArray = [HonorsAwards getBySyncStatus:@"N"];
        
        for (HonorsAwards *honor in eduArray){
            
            [postRequest postEditedAdditionalProfile:[[Login MR_findFirst] userId] andEduObj:nil andWorkObj:nil andHonorObj:honor];
        }
    }

}
- (void)actionContact:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Contact" message:@"Pressed button Contact" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


#pragma mark - Gesture recognizer

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [[[UIAlertView alloc] initWithTitle:@"Gesture recognizer" message:@"Touched image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}


@end
