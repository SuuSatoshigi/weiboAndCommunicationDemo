//
//  AppDelegate.m
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "WeiboSDK.h"
#import "ThemeManager.h"
#import "CONSTS.h"
@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate
- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)_initSinaWeibo {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    
    self.window.backgroundColor = [UIColor whiteColor];
    //设置主题
    [self setTheme];
    _mainCtrl = [[MainViewController alloc] init];
    
    [self _initSinaWeibo];
    RightViewController *rightCtrl = [[RightViewController alloc] init];
    LeftViewController  *leftCtrl = [[LeftViewController alloc] init];
    
    self.menu = [[DDMenuController alloc] initWithRootViewController:_mainCtrl];
    self.menu.rightViewController = rightCtrl;
    self.menu.leftViewController = leftCtrl;
    
    self.window.rootViewController = self.menu;
    
    [self.window makeKeyAndVisible];
//不能写
//    [rightCtrl release];
//    [menu release];
//    [leftCtrl release];
    
    return YES;
};

- (void)setTheme {
    NSString *themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
    [[ThemeManager shareInstance] setThemeName:themeName];
}

#pragma mark - weibo delegate
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"openurl");
    return [WeiboSDK handleOpenURL:url delegate:self];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    self.author = [[[WBAuthorizeResponse alloc] init]autorelease];
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        
        if (accessToken)
        {
            self.author.accessToken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.author.userID = userID;
        }
        self.author.expirationDate = [sendMessageToWeiboResponse.authResponse expirationDate];
        self.author.refreshToken = [sendMessageToWeiboResponse.authResponse refreshToken];
        [alert show];
        [alert release];
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.author.accessToken = [(WBAuthorizeResponse *)response accessToken];
        self.author.userID = [(WBAuthorizeResponse *)response userID];
        self.author.expirationDate = [(WBAuthorizeResponse *)response expirationDate];
        self.author.refreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
        [alert release];
        
        
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [self setUseRInfo];
}

- (void)setUseRInfo {
    //保存到本地
    NSLog(@"_______%@", _author.accessToken);
    //只能选自己ns的，不能设置其他的，要能设进去的话就要实现nscoding协议
//    [[NSUserDefaults standardUserDefaults] setObject:_author forKey:kAuther];
    [[NSUserDefaults standardUserDefaults] setObject:_author.accessToken forKey:kAccessToken];
    [[NSUserDefaults standardUserDefaults] setObject:_author.userID forKey:kUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
