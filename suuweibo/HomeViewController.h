//
//  HomeViewController.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"

@class ThemeImageView;
@interface HomeViewController : BaseViewController<WBHttpRequestDelegate,UITableViewEventDelagate> {
    ThemeImageView *barView;
}
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) UISwitch *textSwitch;
@property (nonatomic, retain) UISwitch *imageSwitch;
@property (nonatomic, retain) UISwitch *mediaSwitch;

//设置成property可以自动release
@property(nonatomic, copy)NSString *topWeiboID;//因为是string所以用copy

@property(retain, nonatomic) WeiboTableView *tableView1;

@property(nonatomic, retain)NSMutableArray *weibo;
@end
