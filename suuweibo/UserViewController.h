//
//  UserViewController.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "WBHttpRequest.h"
@class UserInfoView;
@interface UserViewController : BaseViewController <WBHttpRequestDelegate, UITableViewEventDelagate>
@property (retain, nonatomic) IBOutlet WeiboTableView *tableView;
@property (retain, nonatomic) NSString *userId;
@property (retain, nonatomic) UserInfoView *userInfo;
@end
