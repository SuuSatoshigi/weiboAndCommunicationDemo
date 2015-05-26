//
//  UserInfoView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-23.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@class RectButton;

@interface UserInfoView : UIView
@property (retain, nonatomic) UserModel *user;
@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UILabel *nickLabel;
@property (retain, nonatomic) IBOutlet UILabel *sexLabel;
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;
@property (retain, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (retain, nonatomic) IBOutlet UILabel *countLabel;

@property (retain, nonatomic) IBOutlet RectButton *likeButton;
@property (retain, nonatomic) IBOutlet RectButton *fansBuntton;

@end
