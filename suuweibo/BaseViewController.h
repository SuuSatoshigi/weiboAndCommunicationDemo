//
//  BaseViewController.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "AppDelegate.h"
@interface BaseViewController : UIViewController

- (AppDelegate *)myAppDelegate;
- (void)removeWeiboAuth:(AppDelegate *) myAppDelegate;
- (void)saveWeiboAuth:(AppDelegate *) myAppDelegate;
@end
