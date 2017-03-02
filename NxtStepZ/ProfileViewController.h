//
//  MGViewController.h
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGSpotyViewController.h"

#import "Profile+Extension.h"
#import "Profile.h"
#import "JobTypes+Extension.h"
#import "JobTypes.h"
#import "HonorsAwards+Extension.h"
#import "HonorsAwards.h"
#import "EduandTraning+Extension.h"
#import "EduandTraning.h"
#import "WorkExp+Extension.h"
#import "WorkExp.h"
#import <MagicalRecord/MagicalRecord.h>
#import "WordWrap.h"
#import "DBOperations.h"
#import "postRequest.h"
#import "Login+Extension.h"
#import "Login.h"
#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "TagViewController.h"
#import "CNPGridMenu.h"
#import "ProjectViewController.h"
#import "ImageGallery.h"

#import "PersonalityTest.h"
#import "PeoplesController.h"





@interface ProfileViewController : MGSpotyViewController<ProfileDelegate,UITextViewDelegate,MJSecondPopupDelegate,TagViewDelegate,CNPGridMenuDelegate>{
    
    int selectedIndex;
    NSMutableArray *arrayValues;
    
    
}

@property (nonatomic,strong) NSString *imagePath;
@property (nonatomic, strong) CNPGridMenu *gridMenu;


//-(void)editButtonClicked :(id)index;


@end
