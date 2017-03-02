//
//  ProjectDetailViewController.m
//  NxtStepZ
//
//  Created by Purushothaman on 10/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ProjectDetailViewController.h"


@interface ProjectDetailViewController ()

@end

@implementation ProjectDetailViewController

@synthesize projectId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    array_edit = [NSMutableArray new];
    
    proj = [Projects getByProjectId:self.projectId];
    
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enableDoneButton)];
    self.navigationItem.rightBarButtonItem = edit;
    
    
    
}

-(void)enableDoneButton{
    
    isEditable = YES;
    [table_details reloadData];

    [array_edit removeAllObjects];
    
    [array_edit addObject: [proj project_title]];
    [array_edit addObject: [proj short_description]];
    [array_edit addObject: [proj long_description]];
    [array_edit addObject: [proj skills_names]];

    self.navigationItem.rightBarButtonItem = nil;

    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveProjects)];
    self.navigationItem.rightBarButtonItem = edit;
}

-(void)saveProjects{
    
    isEditable = NO;
    [table_details reloadData];
    
    proj.project_title = [array_edit objectAtIndex:0];
    proj.short_description = [array_edit objectAtIndex:1];
    proj.long_description  = [array_edit objectAtIndex:2];
    proj.skills_names = [array_edit objectAtIndex:3];
    [proj save];
    
    [postRequest postProjectDetail:[[Login MR_findFirst] userId] andProjectObj:proj];
    
    
    
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enableDoneButton)];
    self.navigationItem.rightBarButtonItem = edit;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *txtString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [array_edit replaceObjectAtIndex:textView.tag withObject:txtString];

    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 4;
 
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"table";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
   // UIImageView *imageView = nil;
    UILabel *lbl_name = nil;//,*lbl_skills = nil,*lbl_date = nil,*lbl_desc = nil;
    UITextView *txt_view = nil;
    
    UIButton *btn_likeCount , *btn_comment, *btn_camera;
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 150, 24)];
        lbl_name.font = [UIFont boldSystemFontOfSize:13];
        lbl_name.textAlignment = NSTextAlignmentLeft;
        lbl_name.textColor = [UIColor grayColor];
        [cell.contentView addSubview:lbl_name];
        
//        lbl_desc = [[UILabel alloc] initWithFrame:CGRectMake(170, 5, 280, 34)];
//        lbl_desc.font = [UIFont systemFontOfSize:12];
//        lbl_desc.textAlignment = NSTextAlignmentLeft;
//        lbl_desc.numberOfLines = 2;
//        lbl_desc.textColor = [UIColor grayColor];
//        [cell.contentView addSubview:lbl_desc];
        
        txt_view = [[UITextView alloc] initWithFrame:CGRectMake(170, 10, 140, 40)];
        txt_view.textAlignment = NSTextAlignmentLeft;
        txt_view.font = [UIFont boldSystemFontOfSize:14];
        txt_view.delegate = self;
        txt_view.tag = indexPath.row;
        [cell.contentView addSubview:txt_view];
        
        btn_likeCount = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
        btn_likeCount.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_likeCount setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_likeCount.tag = indexPath.row;
        [btn_likeCount setBackgroundImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateNormal];
        //[btn_likeCount setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_likeCount setClipsToBounds:false];
        //[btn_likeCount setTitle:@"Button" forState:UIControlStateNormal];
        btn_likeCount.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_likeCount.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_likeCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_likeCount setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_likeCount setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [cell.contentView addSubview:btn_likeCount];
        
        btn_likeCount.hidden = TRUE;
        
        
        
        btn_comment = [[UIButton alloc] initWithFrame:CGRectMake(130, 10, 20, 20)];
        btn_comment.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_comment.tag = indexPath.row;
        [btn_comment addTarget:self action:@selector(btn_comments) forControlEvents:UIControlEventTouchUpInside];
        [btn_comment setBackgroundImage:[UIImage imageNamed:@"Comment-50.png"] forState:UIControlStateNormal];
        //[btn_likeCount setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_likeCount setClipsToBounds:false];
        //[btn_likeCount setTitle:@"Button" forState:UIControlStateNormal];
        btn_comment.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_comment.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_comment setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_comment setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [cell.contentView addSubview:btn_comment];
        
        btn_comment.hidden = TRUE;
        
        
        
        btn_camera = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 20, 18)];
        btn_camera.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn_camera setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn_camera.tag = indexPath.row;
        [btn_camera setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        //[btn_likeCount setCenter:CGPointMake(128.f, 128.f)]; // SET the values for your wishes
        [btn_camera setClipsToBounds:false];
        //[btn_likeCount setTitle:@"Button" forState:UIControlStateNormal];
        btn_camera.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_camera.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [btn_camera setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; // SET the colour for your wishes
        [btn_camera setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; // SET the colour for your wishes
        [btn_camera setTitleEdgeInsets:UIEdgeInsetsMake(10.f, -60.f, 10.f, -100.f)];
        [cell.contentView addSubview:btn_camera];
        
        btn_camera.hidden = TRUE;
        
      
        
        
//        lbl_skills = [[UILabel alloc] initWithFrame:CGRectMake(5, 47, 320, 24)];
//        lbl_skills.font = [UIFont systemFontOfSize:12];
//        lbl_skills.textAlignment = NSTextAlignmentLeft;
//        lbl_skills.numberOfLines = 0;
//        lbl_skills.textColor = [UIColor grayColor];
//        [cell.contentView addSubview:lbl_skills];
//        
//        
//        
//        lbl_date = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 100, 24)];
//        lbl_date.font = [UIFont systemFontOfSize:12];
//        lbl_date.textAlignment = NSTextAlignmentLeft;
//        [cell.contentView addSubview:lbl_date];
//        
//        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
//        [cell.contentView addSubview:imageView];
//        
        
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    txt_view.editable = isEditable;
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            lbl_name.text = @"Project Title";
            txt_view.text = [proj project_title];
        }
        else if (indexPath.row == 1) {
            
            lbl_name.text = @"Short description";
            txt_view.text = [proj short_description];
            
        }
        else if (indexPath.row == 2) {
            
            lbl_name.text = @"Long description";
            txt_view.text = [proj long_description];
            
        }
        else if (indexPath.row == 3) {
            
            lbl_name.text = @"Skills";
            txt_view.text = [proj skills_names];
            
        }
        
    }
    else{
        
        btn_likeCount.hidden = FALSE;
        btn_comment.hidden = FALSE;
        btn_camera.hidden = FALSE;

        txt_view.hidden = TRUE;
        lbl_name.hidden = TRUE;
        [btn_likeCount setTitle:[NSString stringWithFormat:@"%@",[proj like_count]] forState:UIControlStateNormal];
        [btn_comment setTitle:[NSString stringWithFormat:@"%@",[proj comment_count]] forState:UIControlStateNormal];


    }
   
    
//    lbl_name.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] project_title];
//    lbl_desc.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] short_description];
//    lbl_skills.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] skills_names];
    
    //  lbl_date.text = [NSString stringWithFormat:@"%@",[[[Projects MR_findAll] objectAtIndex:indexPath.row] created_date]];
    
    
    
    
    // cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 60;

    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}



-(void)btn_comments{
    
    
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentsViewController *comm = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Comments"];
    [self.navigationController pushViewController:comm animated:YES];
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
