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
#import "WeiboTableView.h"

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
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
   
    _tableView1 = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20-49-44) style:UITableViewStylePlain];
    _tableView1.eventDelegate = self;
    [self.view addSubview:_tableView1];
    
    //判断是否登录微博了
    if (accessToken.length != 0) {
        [self loadData];
    }
}

#pragma mark -- load data
- (void)loadData {
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken]
                                      url:url
                               httpMethod:@"GET"
                                   params:nil
                                 delegate:self
                                  withTag:nil];
}

//下拉更新数据
- (void)pullDownData {
    if (self.topWeiboID.length == 0) {
        NSLog(@"problem");
        return ;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.topWeiboID,@"since_id", nil];
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken] url:url httpMethod:@"GET" params:param queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest,id result,NSError *error) {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken]);
        NSLog(@"%@",result);
        NSLog(@"%@",httpRequest);
        NSLog(@"%@",error);
        [self pullDownDataFinish:result h:httpRequest];
    }];//block有可能会造成循环引用，所以要release掉，但是我看不到源码所以就不release－－可能调用的代码已经release了
}

- (void)pullDownDataFinish:(id)result h:(WBHttpRequest *)httpRequest{
    NSLog(@"%@",result);
    NSLog(@"%@",httpRequest);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
    NSArray *statuse = [dic objectForKey:@"statuses"];
    //这个方法返回一个添加了autorelease的对象
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statuse.count];
    for (NSDictionary *statusDic in statuse) {
        WeiboModel *weiboModel = [[WeiboModel alloc] initWithDataDic:statusDic];
        [array addObject:weiboModel];
        //weibo走出循环后计数自动释放（在循环里是1，但是因为没有retain所以不用管，），而weibomodel在这里引用计数为2
        [weiboModel release];
    }
    
    if (array.count > 0) {
        WeiboModel *top = [array objectAtIndex:0];
        self.topWeiboID = [top.weiboId stringValue];
    }
    
    //把旧的微博数组追加到新的微博数组后面
    [array addObjectsFromArray:self.weibo];
    self.weibo = array;
    self.tableView1.data = array;
    
    
    //刷新
    [self.tableView1 reloadData];
    //弹回下拉
    [self.tableView1 doneLoadingTableViewData];
    
    //更新微博数量
    int updateCount = [statuse count];
    NSLog(@"number of new weibo :%d",updateCount);
}

#pragma mark -
#pragma WBHttpRequestDelegate
//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)result
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
    NSArray *statuse = [dic objectForKey:@"statuses"];
    //这个方法返回一个添加了autorelease的对象
    NSMutableArray *weibo = [NSMutableArray arrayWithCapacity:statuse.count];
    for (NSDictionary *statusDic in statuse) {
        WeiboModel *weiboModel = [[WeiboModel alloc] initWithDataDic:statusDic];
        [weibo addObject:weiboModel];
        //weibo走出循环后计数自动释放（在循环里是1，但是因为没有retain所以不用管，），而weibomodel在这里引用计数为2
        [weiboModel release];
    }
    self.tableView1.data = weibo;
    self.weibo = weibo;
    
    //担心会越界所以判断一下
    if (weibo.count > 0) {
        WeiboModel *topWeibo = [weibo objectAtIndex:0];
        self.topWeiboID = [topWeibo.weiboId stringValue];
    }
    
    //刷新tableview
    [self.tableView1 reloadData];
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

#pragma mark - delegate
//下拉
- (void)pullDown:(BaseTableView *)tableView {
    [self pullDownData];
}

//选中
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"choose");
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
    [super viewDidUnload];
}

@end
