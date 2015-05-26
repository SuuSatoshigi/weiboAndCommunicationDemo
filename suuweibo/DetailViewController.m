//
//  DetailViewController.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-19.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "CommentTableView.h"
#import "CommentModel.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    // Do any additional setup after loading the view from its nib.
    [self _initView];
    [self loadData];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)_initView {
    UIView *tableleHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [SuuUitil ScreenWidth], 0)] retain];
    tableleHeaderView.backgroundColor = [UIColor clearColor];
    
    //头像
    NSString *userImage = _weiboModel.user.profile_image_url;
    self.userImageView.layer.cornerRadius = 5;
    //设置超过子图层的部分裁减掉
    //UI框架中使用的方法
    self.userImageView.layer.masksToBounds = YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImage]];
    
    //昵称
    self.nickLabel.text = _weiboModel.user.screen_name;
    [tableleHeaderView addSubview:self.userBarView];
    tableleHeaderView.frame = [SuuUitil setHeight:tableleHeaderView.frame sendHeight:tableleHeaderView.frame.size.height+60];
    
    //创建微博试图
    float h = [WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isDetail:YES];
    NSLog(@"------------tell me why :%lf",h);
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(10,[SuuUitil bottom:tableleHeaderView.frame]+10, [SuuUitil ScreenWidth]-15, h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
    [tableleHeaderView addSubview:_weiboView];
    tableleHeaderView.frame = [SuuUitil setHeight:tableleHeaderView.frame sendHeight:tableleHeaderView.frame.size.height+h+10];

    self.tableView.tableHeaderView = tableleHeaderView;
   
    [tableleHeaderView release];
    
}

#pragma mark -- load data
- (void)loadData {
    
    //显示加载提示
    [super showHud:@"loading" isDim:NO];
    //    [super showLoading:YES];
    NSString *weiboId = [_weiboModel.weiboId stringValue];
    if (weiboId.length == 0) {
        return ;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:weiboId forKey:@"id"];
    NSString *url = @"https://api.weibo.com/2/comments/show.json";
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken]
                                      url:url
                               httpMethod:@"GET"
                                   params:param
                                 delegate:self
                                  withTag:@"load"];
}

#pragma mark -
#pragma WBHttpRequestDelegate
//网络加载完成
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)result {
    [self hiddenHud];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dic objectForKey:@"comments"];
    //这个方法返回一个添加了autorelease的对象
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *commentDic in array) {
        CommentModel *commentModel = [[CommentModel alloc] initWithDataDic:commentDic];
        [comments addObject:commentModel];
        //走出循环后计数自动释放（在循环里是1，但是因为没有retain所以不用管，），而weibomodel在这里引用计数为2
        [commentModel release];
    }
    self.tableView.data = comments;
    
    
    //刷新
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
