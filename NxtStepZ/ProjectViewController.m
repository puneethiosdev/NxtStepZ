//
//  ProjectViewController.m
//  NxtStepZ
//
//  Created by Purushothaman on 07/07/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "ProjectViewController.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [postRequest getProjectList:[[Login MR_findFirst] userId]];
    self.title = @"Projects";
    
    
}

#pragma TableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Projects MR_findAll] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"table";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    UIImageView *imageView = nil;
    UILabel *lbl_name = nil,*lbl_skills = nil,*lbl_date = nil,*lbl_desc = nil;
    
    
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 24)];
        lbl_name.font = [UIFont boldSystemFontOfSize:15];
        lbl_name.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lbl_name];
        
        lbl_desc = [[UILabel alloc] initWithFrame:CGRectMake(5, 26, 280, 34)];
        lbl_desc.font = [UIFont systemFontOfSize:12];
        lbl_desc.textAlignment = NSTextAlignmentLeft;
        lbl_desc.numberOfLines = 2;
        lbl_desc.textColor = [UIColor grayColor];
        [cell.contentView addSubview:lbl_desc];
        
        
        lbl_skills = [[UILabel alloc] initWithFrame:CGRectMake(5, 47, 320, 24)];
        lbl_skills.font = [UIFont systemFontOfSize:12];
        lbl_skills.textAlignment = NSTextAlignmentLeft;
        lbl_skills.numberOfLines = 0;
        lbl_skills.textColor = [UIColor grayColor];
        [cell.contentView addSubview:lbl_skills];
        
        
        
        lbl_date = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 100, 24)];
        lbl_date.font = [UIFont systemFontOfSize:12];
        lbl_date.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lbl_date];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [cell.contentView addSubview:imageView];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    lbl_name.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] project_title];
    lbl_desc.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] short_description];
    lbl_skills.text = [[[Projects MR_findAll] objectAtIndex:indexPath.row] skills_names];

  //  lbl_date.text = [NSString stringWithFormat:@"%@",[[[Projects MR_findAll] objectAtIndex:indexPath.row] created_date]];
    
    // cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProjectDetailViewController *proj = [mainStoryBoard instantiateViewControllerWithIdentifier:@"projectDetail"];
    proj.projectId = [[[Projects MR_findAll] objectAtIndex:indexPath.row] project_id];
    [postRequest getProjectDetail:[[Login MR_findFirst] userId] andProjectId:[[[Projects MR_findAll] objectAtIndex:indexPath.row] project_id]];
    [self.navigationController pushViewController:proj animated:YES];

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
