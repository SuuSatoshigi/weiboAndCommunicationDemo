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
@interface DetailViewController ()

@end

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initView];
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
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(10, _userBarView.frame.origin.y+_userBarView.frame.size.height+10, [SuuUitil ScreenWidth], h)];
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
    
    [tableleHeaderView addSubview:_weiboView];
    tableleHeaderView.frame = [SuuUitil setHeight:tableleHeaderView.frame sendHeight:tableleHeaderView.frame.size.height+h+10];
    
    NSLog(@"1.%f",tableleHeaderView.frame.origin.x);
    NSLog(@"2.%f",tableleHeaderView.frame.origin.y);
    NSLog(@"3.%f",tableleHeaderView.frame.size.height);
    NSLog(@"4.%f",tableleHeaderView.frame.size.width);

    self.tableView.tableHeaderView = tableleHeaderView;
    
   
    [tableleHeaderView release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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
