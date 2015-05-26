//
//  ProfileViewController.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "WBHttpRequest.h"
@class UserInfoView;
@interface ProfileViewController : BaseViewController<WBHttpRequestDelegate, UITableViewEventDelagate>
@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) UserInfoView *userInfo;

@end
