//
//  DetailViewController.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-19.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"

@class WeiboView;
@class WeiboModel;
@interface DetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    WeiboView *_weiboView;
}
@property(nonatomic,retain)WeiboModel *weiboModel;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *userImageView;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;

@property (strong, nonatomic) IBOutlet UIView *userBarView;
@end
