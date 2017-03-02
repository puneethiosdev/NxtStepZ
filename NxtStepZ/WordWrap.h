//
//  WordWrap.h
//  FieldEZ
//
//  Created by FieldEZ Technologies Pvt Ltd on 24/09/14.
//  Copyright (c) 2014 FieldEZ Technologies Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WordWrap : NSObject


+(CGSize)text:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;
    
@end
