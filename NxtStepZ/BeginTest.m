//
//  BeginTest.m
//  NxtStepZ
//
//  Created by Purushothaman on 20/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "BeginTest.h"
#import "MNMRadioGroupValue.h"




@implementation BeginTest

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    selectedIndex = -1;
    selectedSection = -1;
    
    
    arrray_answer = [NSMutableArray new];
    
    
    
    [self initRoundedFatProgressBar];

    dict_test = [NSMutableDictionary new];
    
    
//    [TestResult MR_truncateAll];
    TestResult *test = [TestResult MR_findFirst];
    
    if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        [self firstPageQuestions];

    }
    else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:2]]) {
        
        [self secondPageQuestions];
        
    }
    else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:3]]) {
        
        [self thirdPageQuestions];

        
    }
    else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:4]]) {
        
        [self fourthPageQuestion];

        
    }
    else{
        
        [self saveTestResult:0.0f andCurrentPage:1];
        [self firstPageQuestions];
        

    }
    
    CGFloat flo = [[[TestResult MR_findFirst] percentage] floatValue];
    [self setProgress:flo animated:YES];
    
    
    dict_indexes = [NSMutableDictionary new];
    
    for (int i = 0; i<[[Personality MR_findAll] count]; i ++){
        
        
        [dict_indexes setObject:[NSArray arrayWithObjects:@"-1",@"-1", nil] forKey:[NSString stringWithFormat:@"%d",i]];
        
    }
    NSLog(@"dict_test %@",dict_indexes);
    
    [table_test reloadData];
    
    UIBarButtonItem *save;
    if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:4]]){
        
         save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save_click)];
    }
    else{
        
         save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save_click)];
    }
    
   
    self.navigationItem.rightBarButtonItem  = save;
}





-(void)saveTestResult :(float )percentage andCurrentPage :(int)currentPage{
    
    TestResult *test = [TestResult MR_findFirst];
    
    if (test == nil) {
        
        test = [TestResult MR_createEntity];
    }
    
    test.percentage = [NSNumber numberWithFloat:percentage];
    test.currentPage = [NSNumber numberWithInt:currentPage];
    [test save];
    

}

-(void)firstPageQuestions{

    
    
    lbl_percentage.text = @"0%";
    [arrray_answer removeAllObjects];

//    [table_test scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    
    
    [Personality MR_truncateAll];
    Personality *pers = [Personality MR_createEntity];
    pers.question = @"Suppose You are at party, What would you prefer?";
    pers.answer = @"Socialize i.e. Meeting new people,Staying with your friend circle";
    pers.order = [NSNumber numberWithInt:1];
    [pers save];
    
    
    Personality *pers1 = [Personality MR_createEntity];
    pers1.question = @"What would you prefer?";
    pers1.answer = @"Staying late with increasing energy,Leave early with decreased energy";
    pers1.order = [NSNumber numberWithInt:2];
    [pers1 save];
    
    
    Personality *pers2 = [Personality MR_createEntity];
    pers2.question = @"In your social groups,do you";
    pers2.answer = @"Like to know what is going on around you,Like to stay in yourself";
    pers2.order = [NSNumber numberWithInt:3];
    [pers2 save];
    
    
    Personality *pers3 = [Personality MR_createEntity];
    pers3.question = @"In a conversation";
    pers3.answer = @"Do you say what you feel?,Do you think before you speak";
    pers3.order = [NSNumber numberWithInt:4];
    [pers3 save];
    
    
    Personality *pers4 = [Personality MR_createEntity];
    pers4.question = @"In a group do you";
    pers4.answer = @"Initiate conversations,Wait to be approached";
    pers4.order = [NSNumber numberWithInt:5];
    [pers4 save];
    
    
    Personality *pers5 = [Personality MR_createEntity];
    pers5.question = @"Does the non-routin or new interactions";
    pers5.answer = @"Energize you,Decrease your energy level";
    pers5.order = [NSNumber numberWithInt:6];
    [pers5 save];
    
    Personality *pers6 = [Personality MR_createEntity];
    pers6.question = @"Do you perefer";
    pers6.answer = @"Many friend with breaf contacts,Few friends with details contacts";
    pers6.order = [NSNumber numberWithInt:7];
    [pers6 save];
    
    Personality *pers7 = [Personality MR_createEntity];
    pers7.question = @"Do you:";
    pers7.answer = @"Prefer lengthly converstion with strangers,Hardly find anything to talk to them";
    pers7.order = [NSNumber numberWithInt:8];
    [pers7 save];
    
    Personality *pers8 = [Personality MR_createEntity];
    pers8.question = @"When the phone rings";
    pers8.answer = @"Your answer is immediatly,Wait for some time and answer";
    pers8.order = [NSNumber numberWithInt:9];
    [pers8 save];
    
    Personality *pers9 = [Personality MR_createEntity];
    pers9.question = @"How approachable are you?";
    pers9.answer = @"Easy to approach,Somewhat reserved";
    pers9.order = [NSNumber numberWithInt:10];
    [pers9 save];
    
    
    for (int i = 0; i<[[Personality MR_findAll] count]; i ++){
        
        [arrray_answer addObject:@""];
    }
    
    
}
-(void)secondPageQuestions{
    
    
    lbl_percentage.text = @"25%";
    [arrray_answer removeAllObjects];

   
    
    [table_test scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];


    
    [Personality MR_truncateAll];
    Personality *pers1 = [Personality MR_createEntity];
    pers1.question = @"How would you describe yourself?";
    pers1.answer = @"More as Realistic person,More as imaginative person";
    [pers1 save];

   
    Personality *pers2 = [Personality MR_createEntity];
    pers2.question = @"To whom are you attracted?";
    pers2.answer = @"Sensible people,Imaginative people";
    [pers2 save];
    
    Personality *pers3 = [Personality MR_createEntity];
    pers3.question = @"What is your usual way of doing ordinary things?";
    pers3.answer = @"Doing it the usual way,Doing it in your style.";
    [pers3 save];
    

    Personality *pers4 = [Personality MR_createEntity];
    pers4.question = @"In writing do you prefer?";
    pers4.answer = @"The more literal,The more figurative";
    [pers4 save];
    
    Personality *pers5 = [Personality MR_createEntity];
    pers5.question = @"What are your views on facts?";
    pers5.answer = @"Speak for themselves,Illustrate principles";
    [pers5 save];
    

    Personality *pers6 = [Personality MR_createEntity];
    pers6.question = @"Are visionaries";
    pers6.answer = @"Annoying,Fascinating";
    [pers6 save];
    
    
    Personality *pers7 = [Personality MR_createEntity];
    pers7.question = @"Common sense is";
    pers7.answer = @"Rarely questionable,Frequently questionable";
    [pers7 save];
    
    
    
    Personality *pers8 = [Personality MR_createEntity];
    pers8.question = @"How would you describe yourself";
    pers8.answer = @"A practical person,A fanciful person";
    [pers8 save];
    
    
    Personality *pers9 = [Personality MR_createEntity];
    pers9.question = @"Are you more likely to";
    pers9.answer = @"See in your own way,See how others see";
    [pers9 save];

    
    Personality *pers10 = [Personality MR_createEntity];
    pers10.question = @"Do you go more by";
    pers10.answer = @"Facts,Principles";
    [pers10 save];
    
    

    
    Personality *pers11 = [Personality MR_createEntity];
    pers11.question = @"More interested in?";
    pers11.answer = @"Production and distribution,Research and design";
    [pers11 save];
    
    
    Personality *pers12 = [Personality MR_createEntity];
    pers12.question = @"More likely to trust";
    pers12.answer = @"Your experience,Your guts";
    [pers12 save];
    
    
    
    Personality *pers13 = [Personality MR_createEntity];
    pers13.question = @"Do you feel";
    pers13.answer = @"More practical than ingenious,More ingenious than practical";
    [pers13 save];
    

    Personality *pers14 = [Personality MR_createEntity];
    pers14.question = @"You are more drawn to";
    pers14.answer = @"Fundamentals,Overtones";
    [pers14 save];
    
    Personality *pers15 = [Personality MR_createEntity];
    pers15.question = @"Is it harder for you to";
    pers15.answer = @"Identify with others,Utilize others";
    [pers15 save];
    
    
    [dict_indexes removeAllObjects];
    
    for (int i = 0; i<[[Personality MR_findAll] count]; i ++){

        [dict_indexes setObject:[NSArray arrayWithObjects:@"-1",@"-1", nil] forKey:[NSString stringWithFormat:@"%d",i]];
        [arrray_answer addObject:@""];
    }
    
    [table_test reloadData];
    

}
-(void)thirdPageQuestions{
    
    lbl_percentage.text = @"50%";

    [arrray_answer removeAllObjects];

   

    [table_test scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [Personality MR_truncateAll];

    

    Personality *per1 = [Personality MR_createEntity];
    per1.question = @"Are you impressed by";
    per1.answer = @"Principles,Emotions";
    [per1 save];
    
    
    Personality *per2 = [Personality MR_createEntity];
    per2.question = @"You are more drawn towards the";
    per2.answer = @"Convincing,Touching";
    [per2 save];
    

    
    Personality *per3 = [Personality MR_createEntity];
    per3.question = @"While judging others you inclined towards";
    per3.answer = @"Laws than circumstances,Circumstances than laws";
    [per3 save];

    
    Personality *per4 = [Personality MR_createEntity];
    per4.question = @"In approaching others your inclination is";
    per4.answer = @"Somewhat objective,Somewhat personal";
    [per4 save];
    
    
    Personality *per5 = [Personality MR_createEntity];
    per5.question = @"What appeals you the most";
    per5.answer = @"Consistency of thoughts,Harmonious human relationships";
    [per5 save];
    
    
    Personality *per6 = [Personality MR_createEntity];
    per6.question = @"Are you more comfortable in";
    per6.answer = @"Logical judgments,Practical judgments";
    [per6 save];
    

    
    Personality *per7 = [Personality MR_createEntity];
    per7.question = @"Are you";
    per7.answer = @"Cool hearted,Warm hearted";
    [per7 save];
    

    
    Personality *per8 = [Personality MR_createEntity];
    per8.question = @"Which is worse";
    per8.answer = @"Unjust – violation of principles,Merciless";
    [per8 save];

    
    Personality *per9 = [Personality MR_createEntity];
    per9.question = @"Are you more";
    per9.answer = @"Firm than gentle,Gentle than firm";
    [per9 save];
    
    
    Personality *per10 = [Personality MR_createEntity];
    per10.question = @"Which is more satisfying";
    per10.answer = @"Discuss an issue thoroughly,Arrive at agreement on an issue";
    [per10 save];
    

    
    Personality *per12 = [Personality MR_createEntity];
    per12.question = @"Which rules you more";
    per12.answer = @"Head,Heart";
    [per12 save];
    
    
    Personality *per13 = [Personality MR_createEntity];
    per13.question = @"Do you value in yourself more than you are";
    per13.answer = @"Unwavering,Devoted";
    [per13 save];
    
    Personality *per14 = [Personality MR_createEntity];
    per14.question = @"How do you take decisions";
    per14.answer = @"Fair-minded,Sympathetic";
    [per14 save];
    

    
    Personality *per15 = [Personality MR_createEntity];
    per15.question = @"Which seems to be a greater error";
    per15.answer = @"To be too passionate,To be too objective";
    [per15 save];
    
    

    Personality *per16 = [Personality MR_createEntity];
    per16.question = @"Which do you wish more for yourself";
    per16.answer = @"Clarity of reason,Strength of compassion";
    [per16 save];
    
    
    Personality *per17 = [Personality MR_createEntity];
    per17.question = @"Which is greater fault";
    per17.answer = @"Being indiscriminate,Being critical";
    [per17 save];
    

    
    [dict_indexes removeAllObjects];
    
    for (int i = 0; i<[[Personality MR_findAll] count]; i ++){
        
        [dict_indexes setObject:[NSArray arrayWithObjects:@"-1",@"-1", nil] forKey:[NSString stringWithFormat:@"%d",i]];
        [arrray_answer addObject:@""];
        
    }
    
    [table_test reloadData];
    
}

-(void)fourthPageQuestion{
    
    lbl_percentage.text = @"75%";
    [arrray_answer removeAllObjects];
    
   
    [table_test scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];


    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save_click)];
    self.navigationItem.rightBarButtonItem  = done;
    
    
    
    [Personality MR_truncateAll];

    
    Personality *per1 = [Personality MR_createEntity];
    per1.question = @"Do you prefer to work with?";
    per1.answer = @"Deadlines,Just whenever";
    [per1 save];
    
    
    Personality *per2 = [Personality MR_createEntity];
    per2.question = @"Do you tend to choose?";
    per2.answer = @"Rather carefully.,Somewhat impulsively";
    [per2 save];
    
    
    
    Personality *per3 = [Personality MR_createEntity];
    per3.question = @"Are you more:";
    per3.answer = @"Punctual,Leisurely";
    [per3 save];
    
    
    Personality *per4 = [Personality MR_createEntity];
    per4.question = @"Does unorganized things bother you?";
    per4.answer = @"No.,Yes.";
    [per4 save];
    
    
    Personality *per5 = [Personality MR_createEntity];
    per5.question = @"Would you say you are more?";
    per5.answer = @"Serious and determined,Easy-going";
    [per5 save];
    
    
    
    
    
   
    Personality *per6 = [Personality MR_createEntity];
    per6.question = @"Should one usually let events occur?";
    per6.answer = @"By careful selection and choice,Randomly and by chance";
    [per6 save];
    
    
    Personality *per7 = [Personality MR_createEntity];
    per7.question = @"Which is more admirable:";
    per7.answer = @"The ability to organize and be methodical,The ability to adapt and make do";
    [per7 save];
    

    
    Personality *per8 = [Personality MR_createEntity];
    per8.question = @"Are you more";
    per8.answer = @"Orthodox,Open-minded";
    [per8 save];
    

    Personality *per9 = [Personality MR_createEntity];
    per9.question = @"Are you more comfortable with work that is:";
    per9.answer = @"Contracted,Done on a casual basis";
    [per9 save];
    
    Personality *per10 = [Personality MR_createEntity];
    per10.question = @"Do you more often prefer the";
    per10.answer = @"Final and unalterable statement,Tentative and preliminary statement";
    [per10 save];
    
    
    Personality *per11 = [Personality MR_createEntity];
    per11.question = @"Is it preferable mostly to:";
    per11.answer = @"Make sure things are arranged,Just let things happen";
    [per11 save];
    
    Personality *per12 = [Personality MR_createEntity];
    per12.question = @"In relationships should most things be:";
    per12.answer = @"Re-negotiable,Random and circumstantial";
    [per12 save];
    
  
    Personality *per13 = [Personality MR_createEntity];
    per13.question = @"Which situation appeals to you more:";
    per13.answer = @"The structured and scheduled,The unstructured and unscheduled";
    [per13 save];
    
 
    [dict_indexes removeAllObjects];
    
    for (int i = 0; i<[[Personality MR_findAll] count]; i ++){
        
        [dict_indexes setObject:[NSArray arrayWithObjects:@"-1",@"-1", nil] forKey:[NSString stringWithFormat:@"%d",i]];
        [arrray_answer addObject:@""];
        
    }
    
    [table_test reloadData];

}



-(void)save_click{
    
    
    BOOL isFailure = NO;
    
    for (int i = 0; i<[dict_indexes count]; i++){
        
        
        NSArray *arr = [dict_indexes objectForKey:[NSString stringWithFormat:@"%d",i]];
        
    
        for (int i=0; i<[arr count]; i++){
            
            
            if ([[arr objectAtIndex:i] isEqualToString:@"-1"]) {
                
                isFailure = YES;
            }
        }
        
    }
    
    if (!isFailure) {
        
        NSString *finalString = @"";
        
    
        for (NSString *result in arrray_answer){
            
            finalString = [finalString stringByAppendingFormat:@"%@,",result];
        }
        
       finalString = [finalString substringToIndex:[finalString length]-1];
        
        NSLog(@"finalString %@",finalString);
        
        TestResult *test = [TestResult MR_findFirst];
        PersonalityResult *result = [PersonalityResult MR_createEntity];
        result.page = test.currentPage;
        result.result = finalString;
        [result save];
        

         if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:1]]) {
            
             [self saveTestResult:0.25f andCurrentPage:2];
             [self secondPageQuestions];
 
        }
        else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:2]]) {
            
            [self saveTestResult:0.50f andCurrentPage:3];
            [self thirdPageQuestions];

        }
        else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:3]]) {
            
            
            [self saveTestResult:0.75f andCurrentPage:4];
            [self fourthPageQuestion];

        }
        else if ([test.currentPage isEqualToNumber:[NSNumber numberWithInt:4]]) {
            
            lbl_percentage.text = @"100%";
            [self saveTestResult:1.0f andCurrentPage:5];
            
            [self performSelector:@selector(navigateToResultPage) withObject:nil afterDelay:0.3];

        }
        
       

        CGFloat flo = [[[TestResult MR_findFirst] percentage] floatValue];
        [self setProgress:flo animated:YES];
        
        
    }
    else{
        
    
        [AppHelper alertWithTitle:@"Alert" :@"Answer all the questions" :^{
            
        }];

    }
    
}

-(void)navigateToResultPage{
    
    
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FinalResultController *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Final"];
    [self.navigationController pushViewController:proj animated:YES];
    
}
#pragma mark YLViewController Private Methods

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [_progressBarRoundedFat setProgress:progress animated:animated];
}



- (void)initRoundedFatProgressBar
{
    NSArray *tintColors = @[[UIColor colorWithRed:33/255.0f green:180/255.0f blue:162/255.0f alpha:1.0f],
                            [UIColor colorWithRed:3/255.0f green:137/255.0f blue:166/255.0f alpha:1.0f],
                            [UIColor colorWithRed:91/255.0f green:63/255.0f blue:150/255.0f alpha:1.0f],
                            [UIColor colorWithRed:165/255.0f green:202/255.0f blue:60/255.0f alpha:1.0f],
                            [UIColor colorWithRed:202/255.0f green:217/255.0f blue:54/255.0f alpha:1.0f],
                            [UIColor colorWithRed:111/255.0f green:188/255.0f blue:84/255.0f alpha:1.0f]];
    
    _progressBarRoundedFat.progressTintColors       = tintColors;
    _progressBarRoundedFat.stripesOrientation       = YLProgressBarStripesOrientationLeft;
    _progressBarRoundedFat.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
    _progressBarRoundedFat.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    _progressBarRoundedFat.progressStretch          = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[Personality MR_findAll] count];    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    UILabel *lbl_options = nil;
    DLRadioButton *radioButton = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        
        lbl_options = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 260, 44)];
        lbl_options.font = [UIFont boldSystemFontOfSize:14];
        lbl_options.textAlignment = NSTextAlignmentLeft;
        lbl_options.numberOfLines = 2;
        [cell.contentView addSubview:lbl_options];
        
        radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(10, 15, 30, 34)];
        radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
        radioButton.icon = [UIImage imageNamed:@"thumbs-down.png"];
       // radioButton.iconSelected = [UIImage imageNamed:@"thumbs-up.png"];
        radioButton.titleLabel.textColor = [UIColor blackColor];
        radioButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        radioButton.tag = indexPath.row;
        radioButton.section = indexPath.section;
        [cell.contentView addSubview:radioButton];
        
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
   
//    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
//    NSArray *header = [[dict_test allKeys] sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
//    // NSLog(@"Values is %@",[dict_test objectForKey:[header objectAtIndex:indexPath.section]]);
//    NSArray *valArray = [dict_test objectForKey:[header objectAtIndex:indexPath.section]];
  //  lbl_options.text = [valArray objectAtIndex:indexPath.row];
    
//    NSMutableArray *valuesArray = [NSMutableArray new];
//    
//    [valuesArray addObject:[[MNMRadioGroupValue alloc] initWithValue:[NSString stringWithFormat:@"%ld",(long)indexPath.row] andText: [valArray objectAtIndex:indexPath.row]]];
//    CGFloat margin = 20.0f;
//    CGFloat width = CGRectGetWidth(self.view.frame) - margin * 2.0f;
//    CGFloat height = [MNMRadioGroup heightForValues:valuesArray andWidth:width];
//    radioGroup_ = [[MNMRadioGroup alloc] initWithFrame:CGRectMake(margin, 5, width, height) andValues:valuesArray];
//    radioGroup_.delegate = self;
// 
//    [cell.contentView addSubview:radioGroup_];
    
    
    NSArray *indexArray = [dict_indexes objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.section]];
    
    if ([[indexArray objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        
        radioButton.icon = [UIImage imageNamed:@"thumbs-up.png"];

    }
    else
        radioButton.iconSelected = [UIImage imageNamed:@"thumbs-down.png"];

    
//    if (indexPath.section == selectedSection) {
//        
//        if (indexPath.row == selectedIndex) {
//            
//            radioButton.icon = [UIImage imageNamed:@"thumbs-up.png"];
//        }
//        else
//            radioButton.iconSelected = [UIImage imageNamed:@"thumbs-down.png"];
//   
//    }
   

  //  [radioButton setTitle:[valArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    NSString *str = [[[Personality MR_findAll] objectAtIndex:indexPath.section] answer];
    NSArray *arr = [str componentsSeparatedByString:@","];
    lbl_options.text = [arr objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    lblStr.text = [[[Personality MR_findAll] objectAtIndex:section] question];
    
//    lblStr.backgroundColor = [UIColor clearColor];
//    lblStr.textColor=[UIColor whiteColor];
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



#pragma mark -
#pragma mark MNMRadioGroupDelegate


- (IBAction)logSelectedButton:(DLRadioButton *)radiobutton {
    NSLog(@"%@ is selected.\n", radiobutton.selectedButton.titleLabel.text);
    
    isSelect = radiobutton.isSelected;
    selectedIndex = (int)radiobutton.tag;
    selectedSection = (int)radiobutton.section;
    
    if (selectedIndex == 0) {
        
        [dict_indexes setObject:[NSArray arrayWithObjects:@"1",@"0", nil] forKey:[NSString stringWithFormat:@"%d",selectedSection]];
        [arrray_answer replaceObjectAtIndex:selectedSection withObject:@"1"];
    }
    else{
        [dict_indexes setObject:[NSArray arrayWithObjects:@"0",@"1", nil] forKey:[NSString stringWithFormat:@"%d",selectedSection]];
        [arrray_answer replaceObjectAtIndex:selectedSection withObject:@"2"];

    }

    NSLog(@"radio button section is %@",dict_indexes);

    
    [table_test reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationAutomatic];

}


/**
 * Tells delegate that a value has been selected
 *
 * @param value The MNMRadioGroupValue object selected
 */
- (void)MNMRadioGroupValueSelected:(MNMRadioGroupValue *)value {
    
    if ([value.value isKindOfClass:[NSString class]]) {
        
        NSString *str = (NSString *)value.value;
        NSLog(@"string value is %@",str);
        
    }
}
@end
