//
//  WordWrap.m
//  FieldEZ
//
//  Created by FieldEZ Technologies Pvt Ltd on 24/09/14.
//  Copyright (c) 2014 FieldEZ Technologies Pvt. Ltd. All rights reserved.
//

#import "WordWrap.h"
#define IOS_NEWER_OR_EQUAL_TO_7 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0 )

@implementation WordWrap


+(CGSize)text:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size{
    if(IOS_NEWER_OR_EQUAL_TO_7){
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        
        CGRect frame = [text boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:attributesDictionary
                                          context:nil];
        
        return frame.size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [text sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}



@end
