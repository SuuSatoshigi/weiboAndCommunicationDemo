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
@class ImageView;
@interface WeiboCell : UITableViewCell {
    ImageView     *_userImage;    //用户头像视图
    UILabel         *_nickLabel;    //昵称
    UILabel         *_repostCountLabel; //转发数
    UILabel         *_commentLabel;     //回复数
    UILabel         *_sourceLabel;      //发布来源
    UILabel         *_createLabel;      //发布时间

}

//微博数据模型
@property(nonatomic, retain)WeiboModel  *weibo;
//微博视图
@property(nonatomic, retain)WeiboView *weiboView;

@end
