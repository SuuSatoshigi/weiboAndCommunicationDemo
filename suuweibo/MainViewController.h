//
//  MainViewController.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboSDK.h"

@interface MainViewController : UITabBarController<WBHttpRequestDelegate> {
    UIImageView *_badgeView;
    
}

//控制tabar是否隐藏
- (void)showTabbar:(BOOL)show;


@end
