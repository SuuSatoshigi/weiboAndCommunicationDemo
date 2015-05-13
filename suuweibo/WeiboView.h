//
//  WeiboView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"


#define kWeibo_Width_List  (320-60) //微博在列表中的宽度
#define kWeibo_Width_Detail 300     //微博在详情页面的宽度

//如果需要实现delegate用import导入
@class WeiboModel;
@class ThemeImageView;
@interface WeiboView : UIView <RTLabelDelegate> {
@private
    RTLabel     *_textLabel;            //微博内容
    UIImageView *_image;    //图片
    ThemeImageView *_repostBackgroundImage;//转发微博视图背景
    WeiboView   *_repostView; //转发的微博视图
}
//微博模型对象
@property(nonatomic, retain)WeiboModel *weiboModel;

@property(nonatomic, assign)BOOL isDetail;//微博是否在详情页面

@property(nonatomic, assign)BOOL isRepost; //是否转发

//受两个因素影响，是否转发和是否详情
+ (CGFloat)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

//计算微博视图高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weibo isRepost:(BOOL)isRepost isDetail:(BOOL)isdetail;
@end
