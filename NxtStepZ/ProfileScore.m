//
//  ProfileScore.m
//  NxtStepZ
//
//  Created by Purushothaman on 23/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ProfileScore.h"

@implementation ProfileScore


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"Profile Score";
    
    score = [ScoreAndPoints MR_findFirst];
    test = [TestResult MR_findFirst];
    
    
}



#pragma mark -
#pragma mark Tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return 8;
    }
    else  if (section == 4) {
        
        return 4;
        
    }
    return 1;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    UILabel *lbl_options = nil,*lbl_value = nil;
    YLProgressBar *progressBarRoundedFat = nil;
    YLProgressBar *prog1,*prog2,*prog3,*prog4;
    UILabel *l1,*l2,*l3,*l4;
    
    
    UIImageView *imge_per = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
        lbl_options = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 44)];
        lbl_options.font = [UIFont boldSystemFontOfSize:12];
        lbl_options.textAlignment = NSTextAlignmentLeft;
        lbl_options.numberOfLines = 2;
        [cell.contentView addSubview:lbl_options];
        
        
        lbl_value = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 150, 44)];
        lbl_value.font = [UIFont boldSystemFontOfSize:12];
        lbl_value.textAlignment = NSTextAlignmentLeft;
        lbl_value.numberOfLines = 2;
        [cell.contentView addSubview:lbl_value];
        
        
        imge_per = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 163)];
        imge_per.hidden = TRUE;
        [cell.contentView addSubview:imge_per];

        progressBarRoundedFat = [[YLProgressBar alloc] initWithFrame:CGRectMake(10, 10, 260, 30)];
        
        NSArray *tintColors = @[[UIColor colorWithRed:33/255.0f green:180/255.0f blue:162/255.0f alpha:1.0f],
                                [UIColor colorWithRed:3/255.0f green:137/255.0f blue:166/255.0f alpha:1.0f],
                                [UIColor colorWithRed:91/255.0f green:63/255.0f blue:150/255.0f alpha:1.0f],
                                [UIColor colorWithRed:87/255.0f green:26/255.0f blue:70/255.0f alpha:1.0f],
                                [UIColor colorWithRed:126/255.0f green:26/255.0f blue:36/255.0f alpha:1.0f],
                                [UIColor colorWithRed:149/255.0f green:37/255.0f blue:36/255.0f alpha:1.0f],
                                [UIColor colorWithRed:228/255.0f green:69/255.0f blue:39/255.0f alpha:1.0f],
                                [UIColor colorWithRed:245/255.0f green:166/255.0f blue:35/255.0f alpha:1.0f],
                                [UIColor colorWithRed:165/255.0f green:202/255.0f blue:60/255.0f alpha:1.0f],
                                [UIColor colorWithRed:202/255.0f green:217/255.0f blue:54/255.0f alpha:1.0f],
                                [UIColor colorWithRed:111/255.0f green:188/255.0f blue:84/255.0f alpha:1.0f]];
        
        progressBarRoundedFat.progressTintColors       = tintColors;
        progressBarRoundedFat.stripesOrientation       = YLProgressBarStripesOrientationLeft;
        progressBarRoundedFat.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
        progressBarRoundedFat.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        progressBarRoundedFat.progressStretch          = NO;
        
        progressBarRoundedFat.hidden = TRUE;
        [cell.contentView addSubview:progressBarRoundedFat];
        
        
    }
    
    
    if (indexPath.section == 0) {
        
        
        
        l1 = [[UILabel alloc] initWithFrame:CGRectMake(175, 15, 120, 24)];
        l1.font = [UIFont boldSystemFontOfSize:12];
        l1.textAlignment = NSTextAlignmentLeft;
        l1.numberOfLines = 2;
        [cell.contentView addSubview:l1];
        
        
        l2 = [[UILabel alloc] initWithFrame:CGRectMake(175, 33, 120, 24)];
        l2.font = [UIFont boldSystemFontOfSize:12];
        l2.textAlignment = NSTextAlignmentLeft;
        l2.numberOfLines = 2;
        [cell.contentView addSubview:l2];
        
        l3 = [[UILabel alloc] initWithFrame:CGRectMake(175, 60, 120, 120)];
        l3.font = [UIFont boldSystemFontOfSize:12];
        l3.textAlignment = NSTextAlignmentLeft;
        l3.numberOfLines = 5;
        [cell.contentView addSubview:l3];
        
        imge_per.hidden = FALSE;
        imge_per.image = [UIImage imageWithContentsOfFile:[AppHelper loadImage:@"personality" andExtension:@"png"]];
        
        l1.text = test.personality_name;
        l2.text = test.personality_type;
        l3.text = test.tag;
        
        
        
    }
    else if (indexPath.section == 1) {
        
        
        if(indexPath.row == 0){
            
         
            lbl_options.text = @"Group Studies";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.groupstudies_points];
            
        }
        else if(indexPath.row == 1){
            
            lbl_options.text = @"Passions";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.passion_points];


        }
        else if(indexPath.row == 2){
            
            lbl_options.text = @"Projects/ Ideas";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.project_points];


        }
        else if(indexPath.row == 3){
            
            lbl_options.text = @"Events";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.events_points];


        }
        else if(indexPath.row == 4){
            
            lbl_options.text = @"Quote";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.quote_points];


        }
        else if(indexPath.row == 5){
            
            lbl_options.text = @"Help";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.help_points];


        }
        else if(indexPath.row == 6){
            
            lbl_options.text = @"Follower";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.follow_points];


        }
        else if(indexPath.row == 7){
            
            lbl_options.text = @"Total score";
            lbl_value.text = [NSString stringWithFormat:@"%@",score.total_points];
            
            
        }
       
    }
    else if(indexPath.section == 2){
        
        lbl_options.frame = CGRectMake(270, 15, 50, 24);
        lbl_options.text = [NSString stringWithFormat:@"%@/%@",score.total_points,score.limit];
        progressBarRoundedFat.hidden = FALSE;
        [progressBarRoundedFat setProgress:0.2f animated:YES];


    }
    else if(indexPath.section == 3){
        
        
        l1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 37, 150, 24)];
        l1.font = [UIFont boldSystemFontOfSize:12];
        l1.textAlignment = NSTextAlignmentLeft;
        l1.numberOfLines = 2;
        [cell.contentView addSubview:l1];
        
        
        l2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 37, 50, 24)];
        l2.font = [UIFont boldSystemFontOfSize:12];
        l2.textAlignment = NSTextAlignmentLeft;
        l2.numberOfLines = 2;
        [cell.contentView addSubview:l2];
        
        l3 = [[UILabel alloc] initWithFrame:CGRectMake(175, 37, 150, 24)];
        l3.font = [UIFont boldSystemFontOfSize:12];
        l3.textAlignment = NSTextAlignmentLeft;
        l3.numberOfLines = 2;
        [cell.contentView addSubview:l3];
        
        
        l4 = [[UILabel alloc] initWithFrame:CGRectMake(250, 37, 150, 24)];
        l4.font = [UIFont boldSystemFontOfSize:12];
        l4.textAlignment = NSTextAlignmentLeft;
        l4.numberOfLines = 2;
        [cell.contentView addSubview:l4];
        
        
        prog1 = [[YLProgressBar alloc] initWithFrame:CGRectMake(5, 10, 75, 20)];
        
        NSArray *tintColors = @[[UIColor colorWithRed:33/255.0f green:180/255.0f blue:162/255.0f alpha:1.0f]
                                ];
        
        prog1.progressTintColors       = tintColors;
        prog1.stripesOrientation       = YLProgressBarStripesOrientationLeft;
        prog1.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
        prog1.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:0];
        prog1.progressStretch          = NO;
        
        [cell.contentView addSubview:prog1];
        
        prog2 = [[YLProgressBar alloc] initWithFrame:CGRectMake(80, 10, 75, 20)];
        
        NSArray *tintColors1 = @[
                                [UIColor colorWithRed:228/255.0f green:69/255.0f blue:39/255.0f alpha:1.0f]
                                
                              ];
        
        prog2.progressTintColors       = tintColors1;
        prog2.stripesOrientation       = YLProgressBarStripesOrientationLeft;
        prog2.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
        prog2.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:0];
        prog2.progressStretch          = NO;
        
        [cell.contentView addSubview:prog2];
        
        
        prog3 = [[YLProgressBar alloc] initWithFrame:CGRectMake(155, 10, 75, 20)];
        
        NSArray *tintColors2 = @[
                                [UIColor colorWithRed:111/255.0f green:188/255.0f blue:84/255.0f alpha:1.0f]];
        
        prog3.progressTintColors       = tintColors2;
        prog3.stripesOrientation       = YLProgressBarStripesOrientationLeft;
        prog3.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
        prog3.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:0];
        prog3.progressStretch          = NO;
        
        [cell.contentView addSubview:prog3];
        
        
        prog4 = [[YLProgressBar alloc] initWithFrame:CGRectMake(230, 10, 75, 20)];
        
        NSArray *tintColors3 = @[
                                [UIColor colorWithRed:87/255.0f green:26/255.0f blue:70/255.0f alpha:1.0f]
                               ];
        
        prog4.progressTintColors       = tintColors3;
        prog4.stripesOrientation       = YLProgressBarStripesOrientationLeft;
        prog4.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
        prog4.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:0];
        prog4.progressStretch          = NO;
        
        [cell.contentView addSubview:prog4];
        
        
        float f1 = [score.communication floatValue];
        float f2 = [score.organisation floatValue];
        float f3 = [score.popularity floatValue];
        float f4 = [score.dream_driven floatValue];
        

        l1.text = [NSString stringWithFormat:@"%d%%",(int)f1];
        l2.text = [NSString stringWithFormat:@"%d%%",(int)f2];
        l3.text = [NSString stringWithFormat:@"%d%%",(int)f3];
        l4.text = [NSString stringWithFormat:@"%d%%",(int)f4];


        
       // NSLog(@"score %f",f4*10);
        
        [prog1 setProgress:f1*0.01 animated:YES];
        [prog2 setProgress:f2*0.01 animated:YES];
        [prog3 setProgress:f3*0.01 animated:YES];
        [prog4 setProgress:f4*0.01 animated:YES];

        
    }
    else if (indexPath.section == 4){
        
        
        l1 = [[UILabel alloc] initWithFrame:CGRectMake(280, 15, 50, 24)];
        l1.font = [UIFont boldSystemFontOfSize:12];
        l1.textAlignment = NSTextAlignmentLeft;
        l1.numberOfLines = 2;
        [cell.contentView addSubview:l1];

        
        if(indexPath.row == 0){
            
            lbl_options.text = @"Communication Skills";
            l1.text = [NSString stringWithFormat:@"%d%%",[score.communication_bar intValue]];
            
            prog1 = [[YLProgressBar alloc] initWithFrame:CGRectMake(160, 15, 110, 25)];
            
            NSArray *tintColors = @[[UIColor colorWithRed:33/255.0f green:180/255.0f blue:162/255.0f alpha:1.0f]
                                    ];
            
            prog1.progressTintColors       = tintColors;
            prog1.stripesOrientation       = YLProgressBarStripesOrientationLeft;
            prog1.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
            prog1.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:12];
            prog1.progressStretch          = NO;
            
            [cell.contentView addSubview:prog1];
            
        }
        else if(indexPath.row == 1){
            
            lbl_options.text = @"Organisational Skills";
            l1.text = [NSString stringWithFormat:@"%d%%",[score.organisation_bar intValue]];

            
            prog2 = [[YLProgressBar alloc] initWithFrame:CGRectMake(160, 15, 110, 25)];
            
            NSArray *tintColors1 = @[
                                     [UIColor colorWithRed:228/255.0f green:69/255.0f blue:39/255.0f alpha:1.0f]
                                     
                                     ];
            
            prog2.progressTintColors       = tintColors1;
            prog2.stripesOrientation       = YLProgressBarStripesOrientationLeft;
            prog2.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
            prog2.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            prog2.progressStretch          = NO;
            
            [cell.contentView addSubview:prog2];


        }
        else if(indexPath.row == 2){
            
            lbl_options.text = @"Popularity";
            l1.text = [NSString stringWithFormat:@"%d%%",[score.popularity_bar intValue]];

            
            prog3 = [[YLProgressBar alloc] initWithFrame:CGRectMake(160, 15, 110, 25)];
            
            NSArray *tintColors2 = @[
                                     [UIColor colorWithRed:111/255.0f green:188/255.0f blue:84/255.0f alpha:1.0f]];
            
            prog3.progressTintColors       = tintColors2;
            prog3.stripesOrientation       = YLProgressBarStripesOrientationLeft;
            prog3.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
            prog3.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            prog3.progressStretch          = NO;
            
            [cell.contentView addSubview:prog3];
            


        }
        else if(indexPath.row == 3){
            
            lbl_options.text = @"Dream Driven";
            l1.text = [NSString stringWithFormat:@"%d%%",[score.dream_driven_bar intValue]];
            

            
            prog4 = [[YLProgressBar alloc] initWithFrame:CGRectMake(160, 15, 110, 25)];
            
            NSArray *tintColors3 = @[
                                     [UIColor colorWithRed:87/255.0f green:26/255.0f blue:70/255.0f alpha:1.0f]
                                     ];
            
            prog4.progressTintColors       = tintColors3;
            prog4.stripesOrientation       = YLProgressBarStripesOrientationLeft;
            prog4.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
            prog4.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
            prog4.progressStretch          = NO;
            
            [cell.contentView addSubview:prog4];

        }
        
        
        float f1 = [score.communication_bar intValue] * 0.01;
        float f2 = [score.organisation_bar intValue] * 0.01;
        float f3 = [score.popularity_bar intValue] * 0.01;
        float f4 = [score.dream_driven_bar intValue] * 0.01;
        
        NSLog(@"f1 %f",f1);
        NSLog(@"f2 %f",f2);
        NSLog(@"f3 %f",f3);
        NSLog(@"f4 %f",f4);


        [prog1 setProgress:f1 animated:YES];
        [prog2 setProgress:f2 animated:YES];
        [prog3 setProgress:f3 animated:YES];
        [prog4 setProgress:f4 animated:YES];

    }
    
    
    
   
    
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return 200;
        
    }
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *av=[[UIView alloc] initWithFrame:CGRectMake(0, -5, 320, 50)] ;
    UILabel *lblStr = [[UILabel alloc]initWithFrame:CGRectMake(10, -3, 300, 44)];
    //  NSString *str = [[Personality MR_findAll] objectAtIndex:section];//[[dict_test allKeys] sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    
    // NSArray *header = [str componentsSeparatedByString:@","];
    
   // lblStr.text = [[[Personality MR_findAll] objectAtIndex:section] question];
    
    //    lblStr.backgroundColor = [UIColor clearColor];
    //    lblStr.textColor=[UIColor whiteColor];
    
    if (section == 0){
        
        lblStr.text = @"Your Personality";
    }
    else if (section ==1) {
        
        lblStr.text = @"  Activities                         Score";

    }
    else if (section == 2) {
        
        lblStr.text = [NSString stringWithFormat:@"Level-%@",score.level];
        
    }
    else if (section == 3) {
        
        lblStr.text = @"Roles shown in Percentage";
        
    }
    else if (section == 4) {
        
        lblStr.text = @"  Role Types         Your skills in percentage";
        
    }

    lblStr.backgroundColor = [UIColor clearColor];
    lblStr.textColor = [UIColor grayColor];
    lblStr.shadowColor = [UIColor blackColor];
    lblStr.shadowOffset = CGSizeMake(-1.0, 1.0);
    
    lblStr.font = [UIFont boldSystemFontOfSize:15];
    lblStr.numberOfLines = 2;
    
    [av addSubview:lblStr];
    
    return av;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

@end
