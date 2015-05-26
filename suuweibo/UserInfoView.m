//
//  UserInfoView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "UserInfoView.h"
#import "UIImageView+WebCache.h"
@implementation UserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //创建的是uiview，file‘s owner是userinfoview
        UIView *userInfo = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        userInfo.backgroundColor = [UIColor clearColor];
        [self addSubview:userInfo];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //头像
    NSString *headUrl = self.user.avatar_large;
    [self.userImage setImageWithURL:[NSURL URLWithString:headUrl]];
    
    //昵称
    self.nickLabel.text = self.user.screen_name;
    
    //性别
    NSString *gender = self.user.gender;
    NSString *sex = @"保密";
    if ([gender isEqualToString:@"f"]) {
        sex = @"女";
    } else if ([gender isEqualToString:@"m"]) {
        sex = @"男";
    }
    self.sexLabel.text = sex;
    
    //地址
    self.locationLabel.text = (self.user.location == nil)?@"":self.user.location;
    
    //简介
    self.userInfoLabel.text = (self.user.description == nil)?@"":self.user.description;
    
    //微博数
    NSString *counts = [self.user.statuses_count stringValue];
    self.countLabel.text = [NSString stringWithFormat: @"共%@条微博", counts ];
    
//    //按钮
//    long fans = [self.user.followers_count longValue];
//    NSString *fanString = [NSString stringWithFormat:@"%ld", fans];
//    if (fans > 10000) {
//        fans = fans/10000;
//        fanString = [NSString stringWithFormat:@"%@万",fanString];
//    }
//    self.fansBuntton.title = @"粉丝";
//    self.fansBuntton.subtitle = fanString;
//    
//    self.likeButton.title = @"关注";
//    self.likeButton.subtitle = [self.user.friends_count stringValue];
    
}
@end
