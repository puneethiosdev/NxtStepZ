//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"

@implementation MJDetailViewController
@synthesize editArray;
@synthesize editType;

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    arrayValues = [NSMutableArray new];
    
    if ([editType isEqualToString:@"JobType"]) {
        
        UILabel *jobs = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 200, 30)];
        jobs.font = [UIFont boldSystemFontOfSize:16];
        jobs.textAlignment = NSTextAlignmentLeft;
        jobs.textColor = [UIColor blackColor];
        jobs.text = @"Desired Job Type";
        [self.view addSubview:jobs];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(33, 135, 200, 1)];
        line.font = [UIFont boldSystemFontOfSize:16];
        line.textAlignment = NSTextAlignmentLeft;
        line.backgroundColor = [UIColor grayColor];
        [self.view addSubview:line];
        
        table_pop.hidden = TRUE;
        [self createJobsGroup];
    }
    else  if ([editType isEqualToString:@"About me"]) {
    
        
        [arrayValues addObject:[[[Profile MR_findFirst] profile_description] length] == 0 ? @"" : [[Profile MR_findFirst] profile_description]];

        table_pop.hidden = TRUE;
        
        UITextView *txt_about = [[UITextView alloc] initWithFrame:CGRectMake(5, 45, 250, 190)];
        txt_about.textColor = [UIColor blackColor];
        txt_about.textAlignment = NSTextAlignmentLeft;
        txt_about.text = [[Profile MR_findFirst] profile_description];
        txt_about.editable = YES;
        txt_about.delegate = self;
        
        [self.view addSubview:txt_about];
        
    }
    else if([editType isEqualToString:@"Personal"]){
        
//        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 260, 150)];
//        [datePicker setDate:[NSDate date]];
//        [datePicker setDatePickerMode:UIDatePickerModeDate];
//        [self.view addSubview:datePicker];
//        datePicker.hidden = TRUE;
        
        
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] dob]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] gender]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] marital_status]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] phno]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] email]]];
        [arrayValues addObject:[NSString stringWithFormat:@"%@",[[Profile MR_findFirst] address]]];



    }
    else if([editType isEqualToString:@"EduTraning"]){
        
        dict_values = [NSMutableDictionary new];
        
        int i = 0;
        NSMutableDictionary *tempDict = [NSMutableDictionary new];
        
        
        for (EduandTraning *edu in [EduandTraning MR_findAll]){
            
            [tempDict removeAllObjects];
            
            [tempDict setObject:edu.degree_name forKey:[NSString stringWithFormat:@"0"]];
            [tempDict setObject:edu.branch forKey:[NSString stringWithFormat:@"1"]];
            [tempDict setObject:edu.years forKey:[NSString stringWithFormat:@"2"]];
            [tempDict setObject:edu.university_name forKey:[NSString stringWithFormat:@"3"]];

            [dict_values setObject:[tempDict copy] forKey:[NSString stringWithFormat:@"%d",i]];
        
            i++;
        }
        
        
        NSLog(@"Dic valiiue %@",dict_values);
        
    }
    else if([editType isEqualToString:@"WorkExp"]){
        
        dict_values = [NSMutableDictionary new];
        
        int i = 0;
        NSMutableDictionary *tempDict = [NSMutableDictionary new];
        
        
        for (WorkExp *edu in [WorkExp MR_findAll]){
            
            [tempDict removeAllObjects];
            
            [tempDict setObject:edu.title forKey:[NSString stringWithFormat:@"0"]];
            [tempDict setObject:[NSString stringWithFormat:@"%@",edu.fromdate] forKey:[NSString stringWithFormat:@"1"]];
            [tempDict setObject:[NSString stringWithFormat:@"%@",edu.todate] forKey:[NSString stringWithFormat:@"2"]];
            [tempDict setObject:edu.descriptions forKey:[NSString stringWithFormat:@"3"]];
            
            [dict_values setObject:[tempDict copy] forKey:[NSString stringWithFormat:@"%d",i]];
            
            i++;
        }
        
        
        NSLog(@"Dic valiiue %@",dict_values);
        
    }
    else if([editType isEqualToString:@"HonorsAwards"]){
        
        dict_values = [NSMutableDictionary new];
        
        int i = 0;
        NSMutableDictionary *tempDict = [NSMutableDictionary new];
        
        
        for (HonorsAwards *edu in [HonorsAwards MR_findAll]){
            
            [tempDict removeAllObjects];
            
            [tempDict setObject:[NSString stringWithFormat:@"%@",edu.fromdate] forKey:[NSString stringWithFormat:@"0"]];
            [tempDict setObject:edu.title forKey:[NSString stringWithFormat:@"1"]];
//            [tempDict setObject:[NSString stringWithFormat:@"%@",edu.todate] forKey:[NSString stringWithFormat:@"2"]];
            [tempDict setObject:edu.descriptions forKey:[NSString stringWithFormat:@"2"]];
            
            [dict_values setObject:[tempDict copy] forKey:[NSString stringWithFormat:@"%d",i]];
            
            i++;
        }
        
        
        NSLog(@"Dic valiiue %@",dict_values);
        
    }
    else{
        
        [table_pop reloadData];

    }
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *txtString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    
    NSLog(@"Row is %d",(int)textView.tag);
    NSLog(@"section is %@",textView.section);

    
    if ([editType isEqualToString:@"About me"]) {
        
        [arrayValues replaceObjectAtIndex:textView.tag withObject:txtString];

    }else if ([editType isEqualToString:@"EduTraning"]) {
        
        NSLog(@"set obj is %@",[NSString stringWithFormat:@"%d",(int)textView.tag]);

        NSMutableDictionary *dictObj = [[dict_values objectForKey:[NSString stringWithFormat:@"%@",textView.section]] mutableCopy];
        [dictObj setObject:txtString forKey:[NSString stringWithFormat:@"%d",(int)textView.tag]];
        [dict_values setObject:[dictObj mutableCopy] forKey:[NSString stringWithFormat:@"%@",textView.section]];
        NSLog(@"dictObj %@",dictObj);
        
        
    }
    else if ([editType isEqualToString:@"WorkExp"] || [editType isEqualToString:@"HonorsAwards"]){
        
        NSLog(@"set obj is %@",[NSString stringWithFormat:@"%d",(int)textView.tag]);
        
        NSMutableDictionary *dictObj = [[dict_values objectForKey:[NSString stringWithFormat:@"%@",textView.section]] mutableCopy];
        [dictObj setObject:txtString forKey:[NSString stringWithFormat:@"%d",(int)textView.tag]];
        [dict_values setObject:[dictObj mutableCopy] forKey:[NSString stringWithFormat:@"%@",textView.section]];
        NSLog(@"dictObj %@",dictObj);
    }
    else
        [arrayValues replaceObjectAtIndex:textView.tag withObject:txtString];

    
    
    
    return YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if ([editType isEqualToString:@"EduTraning"]) {
        
        return [[EduandTraning MR_findAll] count];
        
    }else if ([editType isEqualToString:@"WorkExp"]) {
        
        return [[WorkExp MR_findAll] count];
        
    }
    else if ([editType isEqualToString:@"HonorsAwards"]) {
        
        return [[HonorsAwards MR_findAll] count];
        
    }
    else
        return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([editType isEqualToString:@"EduTraning"] || [editType isEqualToString:@"WorkExp"]) {
        
        return 4;
    }
    else if ([editType isEqualToString:@"HonorsAwards"]) {
        
        return 3;
    }
    else if ([editType isEqualToString:@"Personal"]) {
        
        return 6;
    }

    return 0;
    
    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CallCell";
    
    UITableViewCell *cell = nil;
    UILabel *label = nil,*staticLabel = nil;
    GCPlaceholderTextView *txtView = nil;
    
   // cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 150, 24)];
        [label setNumberOfLines:0];
        
        // [label setFont:[UIFont systemFontOfSize:14]];
        [label setTag:indexPath.row];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:12];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkGrayColor];
        [cell .contentView addSubview:label];
        
        
        txtView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(140, 7, 100, 24)];
        txtView.delegate = self;
        txtView.tag = indexPath.row;
        [txtView setSection:[NSNumber numberWithInteger:indexPath.section]];

        //      txtView.autocorrectionType = UITextAutocorrectionTypeNo;
        txtView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtView.keyboardType = UIKeyboardTypeDefault;
        txtView.font = [UIFont systemFontOfSize:14];
        txtView.textColor = [UIColor blackColor];
        txtView.tag = indexPath.row;
        txtView.backgroundColor = [UIColor clearColor];
        [cell .contentView addSubview:txtView];
        
        table_pop.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        
    }
    
    if ([editType isEqualToString:@"EduTraning"]) {
        
       
        NSString *degree = [(EduandTraning*)[[EduandTraning MR_findAll] objectAtIndex:indexPath.section] degree_name];
        NSString *branch = [(EduandTraning*)[[EduandTraning MR_findAll] objectAtIndex:indexPath.section] branch];
        NSString *years = [(EduandTraning*)[[EduandTraning MR_findAll] objectAtIndex:indexPath.section] years];
        NSString *univer = [(EduandTraning*)[[EduandTraning MR_findAll] objectAtIndex:indexPath.section] university_name];

        if (indexPath.row == 0) {
            
            label.text = @"Degree";
            txtView.text = degree;
            
        }else if (indexPath.row == 1) {
            
            label.text = @"Branch";
            txtView.text = branch;

            
        }else if (indexPath.row == 2) {
            
            label.text = @"Year";
            txtView.text = years;

        }
        else if (indexPath.row == 3) {
            
            label.text = @"College/University";
            txtView.text = univer;

            
        }

    }
    else   if ([editType isEqualToString:@"WorkExp"]) {
        
        
        NSString *titles = [(WorkExp*)[[WorkExp MR_findAll] objectAtIndex:indexPath.section] title];
        NSString *desc = [(WorkExp*)[[WorkExp MR_findAll] objectAtIndex:indexPath.section] descriptions];
        NSString *fromDate =[NSString stringWithFormat:@"%@", [(WorkExp*)[[WorkExp MR_findAll] objectAtIndex:indexPath.section] fromdate]];
        NSString *toDate = [NSString stringWithFormat:@"%@", [(WorkExp*)[[WorkExp MR_findAll] objectAtIndex:indexPath.section] todate]];
        
        if (indexPath.row == 0) {
            
            label.text = @"Company Name";
            txtView.text = titles;
            
        }else if (indexPath.row == 1) {
            
            label.text = @"From";
            txtView.text = fromDate;
            
            
        }else if (indexPath.row == 2) {
            
            label.text = @"To";
            txtView.text = toDate;
            
        }
        else if (indexPath.row == 3) {
            
            label.text = @"Job Description";
            txtView.text = desc;
            
            
        }
        
    }
    else   if ([editType isEqualToString:@"HonorsAwards"]) {
        
        
        NSString *titles = [(HonorsAwards*)[[HonorsAwards MR_findAll] objectAtIndex:indexPath.section] title];
        NSString *desc = [(HonorsAwards*)[[HonorsAwards MR_findAll] objectAtIndex:indexPath.section] descriptions];
        NSString *fromDate =[NSString stringWithFormat:@"%@", [(HonorsAwards*)[[HonorsAwards MR_findAll] objectAtIndex:indexPath.section] fromdate]];
     //   NSString *toDate = [NSString stringWithFormat:@"%@", [(HonorsAwards*)[[HonorsAwards MR_findAll] objectAtIndex:indexPath.section] todate]];
        
        if (indexPath.row == 0) {
            
            label.text = @"Awared date";
            txtView.text = fromDate;
            
        }else if (indexPath.row == 1) {
            
            label.text = @"Title";
            txtView.text = titles;
            
            
        }else if (indexPath.row == 2) {
            
            label.text = @"Description";
            txtView.text = desc;
            
        }
    }
    else   if ([editType isEqualToString:@"Personal"]) {
        
        
        NSString *dob =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] dob]];
        NSString *gender =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] gender]];
        NSString *marital =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] marital_status]];
        NSString *contact =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] phno]];
        NSString *email =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] email]];
        NSString *address =[NSString stringWithFormat:@"%@", [(Profile*)[[Profile MR_findAll] objectAtIndex:indexPath.section] address]];



        //   NSString *toDate = [NSString stringWithFormat:@"%@", [(HonorsAwards*)[[HonorsAwards MR_findAll] objectAtIndex:indexPath.section] todate]];
        
        if (indexPath.row == 0) {
            
            label.text = @"Date Of Birth";
            txtView.text = dob;

            
        }else if (indexPath.row == 1) {
            
            label.text = @"Gender";
            txtView.text = [gender isEqualToString:@"1"] ? @"Male" : @"Female";
            txtView.userInteractionEnabled = FALSE;
            
            
        }else if (indexPath.row == 2) {
            
            label.text = @"Marital Status";
            txtView.text = [marital isEqualToString:@"1"] ? @"Single" : @"Married";
            txtView.userInteractionEnabled = FALSE;

        }
        else if (indexPath.row == 3) {
            
            label.text = @"Contact No";
            txtView.text = contact;
            
        }
        else if (indexPath.row == 4) {
            
            label.text = @"E-Mail Id";
            txtView.text = email;
            
        }
        else if (indexPath.row == 5) {
            
            label.text = @"Address";
            txtView.text = address;
            
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
      if ([editType isEqualToString:@"Personal"]) {
          
          selectedIndex = (int)indexPath.row;
          
          if (indexPath.row == 1) {
             
              czArray = @[@"Male", @"Female"];
              [self showPicker:@"Gender"];
          }
          else if (indexPath.row == 2) {
              
              czArray = @[@"Single", @"Married"];
              [self showPicker:@"Marital"];
              
          }

      }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}


- (void)createJobsGroup {
    
    TNCircularCheckBoxData *full = [[TNCircularCheckBoxData alloc] init];
    full.identifier = @"full";
    full.labelText = @"Full time";
    full.borderColor = [UIColor blackColor];
    full.circleColor = [UIColor blackColor];
    full.borderRadius = 20;
    full.circleRadius = 15;
    
    TNCircularCheckBoxData *part = [[TNCircularCheckBoxData alloc] init];
    part.identifier = @"part";
    part.labelText = @"Part time";
    part.borderColor = [UIColor blackColor];
    part.circleColor = [UIColor blackColor];
    part.borderRadius = 20;
    part.circleRadius = 15;
    
    TNCircularCheckBoxData *intern = [[TNCircularCheckBoxData alloc] init];
    intern.identifier = @"intern";
    intern.labelText = @"Internship";
    intern.borderColor = [UIColor blackColor];
    intern.circleColor = [UIColor blackColor];
    intern.borderRadius = 20;
    intern.circleRadius = 15;
    
    TNCircularCheckBoxData *volun = [[TNCircularCheckBoxData alloc] init];
    volun.identifier = @"vol";
    volun.labelText = @"Volunteer";
    volun.borderColor = [UIColor blackColor];
    volun.circleColor = [UIColor blackColor];
    volun.borderRadius = 20;
    volun.circleRadius = 15;
    
    TNCircularCheckBoxData *contract = [[TNCircularCheckBoxData alloc] init];
    contract.identifier = @"contract";
    contract.labelText = @"Contarct";
    contract.borderColor = [UIColor blackColor];
    contract.circleColor = [UIColor blackColor];
    contract.borderRadius = 20;
    contract.circleRadius = 15;
    
    TNCircularCheckBoxData *temp = [[TNCircularCheckBoxData alloc] init];
    temp.identifier = @"temp";
    temp.labelText = @"Temporary";
    temp.borderColor = [UIColor blackColor];
    temp.circleColor = [UIColor blackColor];
    temp.borderRadius = 20;
    temp.circleRadius = 15;
    
    
    for (NSString *types in editArray){
        
        int job = [types intValue];
        
        if (job == 1) {
            
            full.checked = YES;
        }
        else if (job == 2) {
            
            part.checked = YES;
            
        }else if (job == 3) {
            
            intern.checked = YES;
            
        }else if (job == 4) {
            
            volun.checked = YES;
            
        }else if (job == 5) {
            
            contract.checked = YES;
            
        }else if (job == 6) {
            
            temp.checked = YES;
        }
    }
    
    
    checkGroup = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[full, part, intern, volun,contract,temp] style:TNCheckBoxLayoutHorizontal];
    checkGroup.rowItemCount = 2;
    [checkGroup create];
    checkGroup.position = CGPointMake(25, 170);

    
    [self.view addSubview:checkGroup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GroupChanged:) name:GROUP_CHANGED object:checkGroup];
}

-(IBAction)btn_cancel:(id)sender{
    
    NSLog(@"check box %@",checkGroup.checkedCheckBoxes);
    

    if (self.canceldelegate && [self.canceldelegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.canceldelegate cancelButtonClicked:self];
    }
}

-(IBAction)btn_save:(id)sender{
    NSLog(@"Checked arrayValues %@,%ld", arrayValues,(long)[(UIButton *)sender tag]);

    int section = -1;
    
    if([editType isEqualToString:@"Personal"]){
        
        section = 0;
        
    }else if([editType isEqualToString:@"About me"]){
     
        section = 1;
        
    }
    else if([editType isEqualToString:@"Area"]){
        
        section = 2;
        
    }
    else if([editType isEqualToString:@"JobType"]){
        
        section = 3;
        
    }
    else if ([editType isEqualToString:@"EduTraning"]) {
        
        section = 4;

    } else if ([editType isEqualToString:@"WorkExp"]) {
        
        section = 5;
        
    }
    else if ([editType isEqualToString:@"HonorsAwards"]) {
        
        section = 6;
        
    }

 
    if (section == 4 || section == 5 || section == 6) {
        
        [DBOperations updateAdditionalProfile:dict_values andSection:section];

    }
    else{
        
        [DBOperations updateProfile:arrayValues andSection:section];

    }
    

    
    if (self.canceldelegate && [self.canceldelegate respondsToSelector:@selector(saveEdit:)]) {
        [self.canceldelegate saveEdit:self];
    }
}
- (void)GroupChanged:(NSNotification *)notification {
    
    NSLog(@"Checked checkboxes %@", checkGroup.checkedCheckBoxes);
    NSLog(@"Unchecked checkboxes %@", checkGroup.uncheckedCheckBoxes);
    
    [arrayValues removeAllObjects];
    [arrayValues addObject:@""];
    
    NSString *selectedString = @"";
    
    for (TNCheckBoxData *data in checkGroup.checkedCheckBoxes){
        
        NSLog(@"data tag is %d",(int)data.tag);
        
        selectedString = [selectedString stringByAppendingString:[NSString stringWithFormat:@"%d,",(int)data.tag + 1]];
        
        
    }
        selectedString = [selectedString substringToIndex:[selectedString length]-1];

        [arrayValues replaceObjectAtIndex:0 withObject:selectedString];
    

}

-(void)localSave : (NSString *)selectedString{
    
    if ([editType isEqualToString:@"Personal"]) {
        
        Profile *po = [Profile MR_findFirst];
        
        if (selectedIndex == 1) {
            
            [arrayValues replaceObjectAtIndex:selectedIndex withObject:[selectedString isEqualToString:@"Male"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2]];
            po.gender = [selectedString isEqualToString:@"Male"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2];
            
        }
       else if (selectedIndex == 2) {
           
           [arrayValues replaceObjectAtIndex:selectedIndex withObject:[selectedString isEqualToString:@"Single"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2]];
            po.marital_status = [selectedString isEqualToString:@"Single"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2];
            
        }
        [po save];
    }
    
    [table_pop reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:selectedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
}
#pragma mark - CZPickerView

-(void)showPicker : (NSString *)titles{
    
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:titles cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = YES;
    [picker show];
}

- (NSAttributedString *)CZPickerView:(CZPickerView *)pickerView
                         titleForRow:(NSInteger)row{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:czArray[row]];
    return str;
}
- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView{
    return czArray.count;
}
- (void)CZPickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    NSLog(@"%@ is chosen!", czArray[row]);
    
    [self localSave:czArray[row]];
    
}

- (void)CZPickerViewDidClickCancelButton:(CZPickerView *)pickerView{
    NSLog(@"Canceled.");
}


@end
