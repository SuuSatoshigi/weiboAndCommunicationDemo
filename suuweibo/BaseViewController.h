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

@class MBProgressHUD;
@interface BaseViewController : UIViewController{
    UIView *_loadView;
}

@property (nonatomic, retain)MBProgressHUD *hud;
- (AppDelegate *)myAppDelegate;
- (void)removeWeiboAuth:(AppDelegate *) myAppDelegate;
- (void)saveWeiboAuth:(AppDelegate *) myAppDelegate;

//首页加载提示
- (void)showLoading:(BOOL)show;
- (void)showHud:(NSString *)title isDim:(BOOL)isDim;
- (void)hiddenHud;
- (void)showHudComplete:(NSString *)title;
@end
