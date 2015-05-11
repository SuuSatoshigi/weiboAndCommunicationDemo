//
//  WeiboView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

//如果需要实现delegate用import导入
@class WeiboModel;
@interface WeiboView : UIView {
@private
    RTLabel *_textLabel;    //微博内容
    UIImageView *_image;    //图片
    UIImageView *repostBackgroundImage;//转发微博视图背景
}
//微博模型对象
@property(nonatomic, retain)WeiboModel *weiboModel;
//转发的微博视图
@property(nonatomic, retain)WeiboView *repostView;

@property(nonatomic, assign)BOOL isRepost; //是否转发

@end
