//
//  UIViewController+Side.m
//  LoginPage
//
//  Created by Jinaraj on 2/11/15.
//  Copyright (c) 2015 Jinaraj. All rights reserved.
//

#import "UIViewController+Side.h"
#import "JASidePanelController.h"

@implementation UIViewController (Side)


- (JASidePanelController *)sidePanelController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JASidePanelController class]]) {
            return (JASidePanelController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
