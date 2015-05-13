//
//  HomeViewController.h
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,WBHttpRequestDelegate>
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) UISwitch *textSwitch;
@property (nonatomic, retain) UISwitch *imageSwitch;
@property (nonatomic, retain) UISwitch *mediaSwitch;
//

@property (retain, nonatomic) NSArray *data;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
