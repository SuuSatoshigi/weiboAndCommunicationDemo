//
//  BaseViewController.m
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
#import "SuuUitil.h"
#import "MBProgressHUD.h"
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
    if ([ThemeManager shareInstance].themeName.length == 0) {
        titleLabel.textColor = [UIColor whiteColor];
    } 
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

////首页加载提示
//- (void)showLoading:(BOOL)show {
//    if (_loadView == nil) {
//        _loadView = [[UIView alloc] initWithFrame:CGRectMake(0, [SuuUitil ScreenHeight]/2-80, [SuuUitil ScreenWidth], 20)];
//        //loading
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        
//        [activityView startAnimating];
//        
//        //loading label
//        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        loadLabel.backgroundColor = [UIColor clearColor];
//        loadLabel.text = @"loading";
//        loadLabel.font = [UIFont boldSystemFontOfSize:16.0];
//        loadLabel.textColor = [UIColor grayColor];
//        [loadLabel sizeToFit];
//        
//        loadLabel.frame = [SuuUitil setOriginX:loadLabel.frame sendX:(320-loadLabel.frame.size.width)/2];
//        activityView.frame = [SuuUitil setOriginX:activityView.frame sendX:loadLabel.frame.origin.x + loadLabel.frame.size.width];
//        [_loadView addSubview:loadLabel];
//        [_loadView addSubview:activityView];
//        [activityView release];
//                              
//    }
//    
//    if (show) {
//        if (![_loadView superview]) {
//            [self.view addSubview:_loadView];
//        }
//    }else {
//        //从父视图中清除出来
//        [_loadView removeFromSuperview];
//        
//    }
//}

- (void)showHud:(NSString *)title isDim:(BOOL)isDim {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.dimBackground = isDim;
    self.hud.labelText = title;
}
- (void)hiddenHud {
    [self.hud hide:YES];
}
@end
