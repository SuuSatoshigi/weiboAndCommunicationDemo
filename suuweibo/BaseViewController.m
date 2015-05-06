//
//  BaseViewController.m
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//override
//设置导航栏上的标题
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleLabel = [UIFactory createThemeLable:kNavigationBarTitleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}
//override
//- (void)setTitle:(NSString *)title {
//    [super setTitle:title];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = title;
//    [titleLabel sizeToFit];
//    
//    self.navigationItem.titleView = [titleLabel autorelease];
//}

- (AppDelegate *)myAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark -- delegate
- (void)saveWeiboAuth:(AppDelegate *) myAppDelegate{
    //保存用户数据到本地
    NSDictionary *auth = [NSDictionary dictionaryWithObjectsAndKeys:
                          myAppDelegate.author.accessToken, @"AccessAndTokenKey",
                          myAppDelegate.author.expirationDate, @"ExpirationDate",
                          myAppDelegate.author.userID, @"UserID",
                          myAppDelegate.author.refreshToken, @"RefreshToken", nil];
    [[NSUserDefaults standardUserDefaults]setObject:auth forKey:@"weiboUserAuth"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (void)removeWeiboAuth:(AppDelegate *) myAppDelegate {
    //移除
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"weiboUserAuth"];
}
@end
