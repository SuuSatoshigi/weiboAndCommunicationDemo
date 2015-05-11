//
//  WeiboCell.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@class WeiboView;
@interface WeiboCell : UITableViewCell

//微博数据模型
@property(nonatomic, retain)WeiboModel  *weibo;
//微博视图
@property(nonatomic, retain)WeiboView *weiboView;

@end
