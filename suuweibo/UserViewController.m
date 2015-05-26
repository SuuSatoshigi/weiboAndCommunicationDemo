//
//  UserViewController.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户中心";
    
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
//选中delegate
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
 接口升级后，对未授权本应用的uid，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
 */
#pragma mark -- load data
- (void)loadUserData {
    //显示加载提示
    [super showHud:@"loading" isDim:NO];
    //    [super showLoading:YES];
    if (self.userName.length == 0) {
        return ;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userName,@"screen_name", nil];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken]
                                      url:url
                               httpMethod:@"GET"
                                   params:param
                                 delegate:self
                                  withTag:@"loadUser"];
}

- (void)loadWeiborData {
    //显示加载提示
    [super showHud:@"loading" isDim:NO];
    //    [super showLoading:YES];
    if (self.userName.length == 0) {
        return ;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userName,@"screen_name", nil];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken]
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
    UserModel *userModel = [[UserModel alloc] initWithDataDic:dic];
    if ([request.tag isEqualToString:@"loadUser"]) {
        self.userInfo.user = userModel;
        self.tableView.tableHeaderView = self.userInfo;
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
