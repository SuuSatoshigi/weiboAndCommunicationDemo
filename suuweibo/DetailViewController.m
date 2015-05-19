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
    
    NSString *userImage = _weiboModel.user.profile_image_url;
    self.userImageView.layer.cornerRadius = 5;
    //设置超过子图层的部分裁减掉
    //UI框架中使用的方法
    self.userImageView.layer.masksToBounds = YES;
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImage]];
    self.nickLabel.text = _weiboModel.user.screen_name;
    [tableleHeaderView addSubview:self.userBarView];
    tableleHeaderView.frame = [SuuUitil setHeight:tableleHeaderView.frame sendHeight:60];
    
    tableleHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    
//    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
//    pricesView.view.translatesAutoresizingMaskIntoConstraints = NO; // you might get it to work without doing this line
    
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
