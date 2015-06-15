//
//  UIViewController+Side.h
//  LoginPage
//
//  Created by Jinaraj on 2/11/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface UIViewController (Side)

@property (nonatomic, weak, readonly) JASidePanelController *sidePanelController;


@end
