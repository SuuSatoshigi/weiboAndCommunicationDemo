//
//  UserViewController.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "WeiboModel.h"
@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //利用userinfoview生成uiview的xib，一种连线方式
    self.userInfo = [[[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, [SuuUitil ScreenWidth], 230)] autorelease];
    self.tableView.eventDelegate = self;
    
    [self loadUserData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- table delegaete
//下拉
- (void)pullDown:(BaseTableView *)tableView {
    [tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2];
}

//上拉
- (void)pullUp:(BaseTableView *)tableView {
    [tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
}

/*
 接口升级后，对未授权本应用的uid，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
 */
#pragma mark -- load data
- (void)loadUserData {
    //显示加载提示
    [super showHud:@"loading" isDim:NO];
    //    [super showLoading:YES];
    
    NSString *accessToken =[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
    if (self.userId.length == 0) {
        return ;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userId ,@"uid", nil];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [WBHttpRequest requestWithAccessToken:accessToken
                                      url:url
                               httpMethod:@"GET"
                                   params:param
                                 delegate:self
                                  withTag:@"loadUser"];
}

//获取某个用户最新发表的微博列表
- (void)loadWeiborData {
    //显示加载提示
    [super showHud:@"loading" isDim:NO];
    NSString *accessToken =[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken];
    if (self.userId.length == 0) {
        return ;
    }
    
    //    获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userId ,@"uid", nil];
    NSString *url = @"https://api.weibo.com/2/statuses/user_timeline.json";
    
    [WBHttpRequest requestWithAccessToken:accessToken
                                      url:url
                               httpMethod:@"GET"
                                   params:param
                                 delegate:self
                                  withTag:@"loadWeibo"];
}

#pragma mark -
#pragma WBHttpRequestDelegate
//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)result{
    [super hiddenHud];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
    if ([request.tag isEqualToString:@"loadUser"]) {
        UserModel *userModel = [[UserModel alloc] initWithDataDic:dic];
        self.userInfo.user = userModel;
        self.tableView.tableHeaderView = self.userInfo;
        
        [self loadWeiborData];
        
    } else if ([request.tag isEqualToString:@"loadWeibo"]) {
        NSArray *statuse = [dic objectForKey:@"statuses"];
        //这个方法返回一个添加了autorelease的对象
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:statuse.count];
        for (NSDictionary *statusDic in statuse) {
            WeiboModel *weiboModel = [[WeiboModel alloc] initWithDataDic:statusDic];
            [array addObject:weiboModel];
            //weibo走出循环后计数自动释放（在循环里是1，但是因为没有retain所以不用管，），而weibomodel在这里引用计数为2
            [weiboModel release];
        }
        self.tableView.data = array;
        //        if (array.count >= 20) {
        //            self.tableView.isMore = YES;
        //        } else  {
        //             self.tableView.isMore = NO;
        //        }
        
        [self.tableView reloadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
