//
//  UIView+Additions.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIViewController *)viewController {
    //拿到下一个响应者
    UIResponder *next = [self nextResponder];
//    循环获取到viewcontroller的响应
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}
@end
