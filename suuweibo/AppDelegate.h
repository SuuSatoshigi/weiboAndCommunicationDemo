//
//  AppDelegate.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (retain, nonatomic) MainViewController *mainCtrl;
@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) WBAuthorizeResponse *author;
//@property (strong, nonatomic) NSString *wbtoken;
//@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

