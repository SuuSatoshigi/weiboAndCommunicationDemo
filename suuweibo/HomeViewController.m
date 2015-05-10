//
//  HomeViewController.m
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "CONSTS.h"
#import "WeiboModel.h"

@interface HomeViewController ()<WBHttpRequestDelegate>

@end

@implementation HomeViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微博";
        self.tabBarItem.image = [UIImage imageNamed:@"clan_topic_normal1"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注销
    UIBarButtonItem *loginOutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(loginOutAction:)];
    self.navigationItem.leftBarButtonItem = [loginOutItem autorelease];
    // Do any additional setup after loading the view from its nib.
  
    //绑定
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    
    WBAuthorizeResponse *author = [[NSUserDefaults standardUserDefaults] objectForKey:kAuther];
   
    
    NSLog(@"====%@",[[[NSUserDefaults standardUserDefaults] objectForKey:kAuther] accessToken]);
    NSLog(@"++++%@",[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]);
    NSLog(@"------%@",author);
    //判断是否登录微博了
    if (author.accessToken.length != 0) {
        [self loadData];
    }
}

#pragma mark -- load data
- (void)loadData {
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSLog(@"%@",url);
    [WBHttpRequest requestWithAccessToken:self.myAppDelegate.author.accessToken
                                      url:url
                               httpMethod:@"Get"
                                   params:nil
                                 delegate:self
                                  withTag:nil];
}


#pragma mark -
#pragma WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result {
    
}



//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)result
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
    NSArray *statuse = [dic objectForKey:@"statuses"];
    NSMutableArray *weibo = [NSMutableArray arrayWithCapacity:statuse.count];
    for (NSDictionary *statusDic in statuse) {
        WeiboModel *weiboModel = [[WeiboModel alloc] initWithDataDic:statusDic];
        [weibo addObject:weiboModel];
        [dic release];
        [statuse release];
    }
    NSLog(@"---------------123%@",weibo);
    NSLog(@"%@",request.url);
    
//    NSString *title = nil;
//    UIAlertView *alert = nil;
//
//    title = NSLocalizedString(@"收到网络回调", nil);
//    alert = [[UIAlertView alloc] initWithTitle:title
//                                       message:[NSString stringWithFormat:@"%@",result]
//                                      delegate:nil
//                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                             otherButtonTitles:nil];
//    [alert show];
//    [alert release];
}

//网络加载失败
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - actions
- (void)bindAction:(UIBarButtonItem *)buttonItem {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    //   WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    authRequest.userInfo = @{@"ShareMessageFrom": @"HomeViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:authRequest];
    [self saveWeiboAuth:self.myAppDelegate];
}

- (void)loginOutAction:(UIBarButtonItem *)buttonItem {
    [WeiboSDK logOutWithToken:self.myAppDelegate.author.accessToken delegate:self withTag:@"user1"];
    [self removeWeiboAuth:self.myAppDelegate];
}

#pragma Internal Method

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.imageSwitch.on)
    {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
    if (self.mediaSwitch.on)
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}

#pragma mark -- memory manager
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidUnload {
    //under ios 6.0
}

@end
